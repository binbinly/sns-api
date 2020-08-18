package app

type User struct {
	UserId   int    `json:"user_id"`
	Username string `json:"username"`
	Avatar   string `json:"avatar"`
	Phone    string `json:"phone"`
	Token    string `json:"token"`
}
