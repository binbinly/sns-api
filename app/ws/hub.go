package ws

import "fmt"

//消息
type Message struct {
	MType   int    `json:"m_type"`  //消息类型
	CType   int    `json:"c_type"`  //消息内容类型
	Time    int    `json:"time"`    //发送时间
	Content string `json:"content"` //消息内容
	Mime    *user  `json:"mime"`    //发送人
	To      *user  `json:"to"`      //接收人
}

//用户
type user struct {
	Id       int    `json:"id"`       //用户ID
	Username string `json:"username"` //用户名
	Avatar   string `json:"avatar"`   //头像
}

// hub maintains the set of active connections and broadcasts messages to the
// connections.
type hub struct {
	// Registered connections.
	//注册连接
	connections map[int]*connection

	// Inbound messages from the connections.
	//连接中的绑定消息
	msg chan *Message

	// Register requests from the connections.
	//添加新连接
	register chan *connection

	// Unregister requests from connections.
	//删除连接
	unregister chan int
}

var H = &hub{
	//广播slice
	msg: make(chan *Message),
	//注册者slice
	register: make(chan *connection),
	//未注册者sclie
	unregister: make(chan int),
	//连接map
	connections: make(map[int]*connection),
}

func init()  {
	go H.Run()
}

func (h *hub) Run() {
	for {
		select {
		//注册者有数据，则插入连接map
		case c := <-h.register:
			h.connections[c.uid] = c
		//注销连接
		case uid := <-h.unregister:
			if c, ok := h.connections[uid]; ok {
				delete(h.connections, uid)
				close(c.send)
				c.ws.Close()
			}
		//广播有数据
		case m := <- h.msg:
			fmt.Printf("msg:%v\n", m)
			if m.To != nil {
				c, ok := h.connections[m.To.Id]
				if !ok {
					return
				}
				select {
				//发送数据给连接
				case c.send <- m:
				default:
				}
			} else {//广播消息
				for _, c := range h.connections {
					select {
					//发送数据给连接
					case c.send <- m:
					default:
					}
				}
			}
		}
	}
}
