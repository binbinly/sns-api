package ws

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/gorilla/websocket"
	"net/http"
	"sns-api/tools/logger"
	"time"
)

const (
	//对方写入会话等待时间
	// Time allowed to write a message to the peer.
	writeWait = 10 * time.Second

	//对方读取下次消息等待时间
	// Time allowed to read the next pong message from the peer.
	pongWait = 60 * time.Second

	//对方ping周期
	// Send pings to peer with this period. Must be less than pongWait.
	pingPeriod = (pongWait * 9) / 10

	//对方最大写入字节数
	// Maximum message size allowed from peer.
	maxMessageSize = 512
)

var (
	newline = []byte{'\n'}
	space   = []byte{' '}
)

//服务器配置信息
var upGrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	// 解决跨域问题
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

// connection 是websocket的conntion和hub的中间人
// connection is an middleman between the websocket connection and the hub.
type connection struct {
	// The websocket connection.
	//websocket的连接
	ws *websocket.Conn

	// Buffered channel of outbound messages.
	//出站消息缓存通道
	send chan *Message

	//绑定用户id
	uid int
}

//读取connection中的数据导入到hub中，实则发广播消息
//服务器读取的所有客户端的发来的消息
// readPump pumps messages from the websocket connection to the hub.
func (c *connection) readPump() {
	defer func() {
		H.unregister <- c.uid
		c.ws.Close()
	}()
	c.ws.SetReadLimit(maxMessageSize)
	c.ws.SetReadDeadline(time.Now().Add(pongWait))
	c.ws.SetPongHandler(func(string) error { c.ws.SetReadDeadline(time.Now().Add(pongWait)); return nil })
	for {
		_, message, err := c.ws.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				logger.Error(err)
			}
			break
		}
		message = bytes.TrimSpace(bytes.Replace(message, newline, space, -1))
		fmt.Printf("message:%v\n", string(message))

		msgS := &Message{}
		err = json.Unmarshal(message, msgS)
		if err != nil {
			logger.Error(err)
			continue
		}
		H.msg <- msgS
	}
}

//从hub到connection写数据
//服务器端发送消息给客户端
// writePump pumps messages from the hub to the websocket connection.
func (c *connection) writePump() {
	//定时执行
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		c.ws.Close()
	}()
	for {
		select {
		case message, ok := <-c.send:
			fmt.Printf("write message:%v\n", message)
			c.ws.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				// The hub closed the channel.
				c.ws.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			w, err := c.ws.NextWriter(websocket.TextMessage)
			if err != nil {
				return
			}
			messageJson, err := json.Marshal(message)
			if err != nil {
				return
			}
			w.Write(messageJson)

			if err := w.Close(); err != nil {
				return
			}
		case <-ticker.C:
			c.ws.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.ws.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

//处理客户端对websocket请求
// serveWs handles websocket requests from the peer.
func ServeWs(w http.ResponseWriter, r *http.Request) {
	//设定环境变量
	ws, err := upGrader.Upgrade(w, r, nil)
	if err != nil {
		logger.Error(err)
		return
	}
	token := r.URL.Query().Get("token")
	if token == "" {
		return
	}
	u, err := CheckToken(token)
	if err != nil {
		logger.Error(err)
		return
	}
	//初始化connection
	c := &connection{send: make(chan *Message, 256), ws: ws, uid:u.UserId}
	//加入注册通道，意思是只要连接的人都加入register通道
	H.register <- c
	go c.writePump() //服务器端发送消息给客户端
	go c.readPump()  //服务器读取的所有客户端的发来的消息
}
