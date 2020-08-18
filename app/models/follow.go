package models

const followTableName = "user_follow"

type Follow struct {
	ModelCreate

	UserId   int
	FollowId int
}

type FollowUserInfo struct {
	UserId   int    `json:"user_id"`
	Gender   int    `json:"gender"`
	Username string `json:"username"`
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`
	Hometown string `json:"hometown"`
	Birthday string `json:"birthday"`
}

func (Follow) TableName() string {
	return followTableName
}
