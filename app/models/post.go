package models

const (
	SeeTypeAll    = 0 //所有人可见
	SeeTypeFriend = 1 //好友可见
	SeeTypeMy     = 2 //仅自己可见

	TypePost      = 1 //动态
	TypeTopicPost = 2 //帖子

	PostOrderNewest = 1 //最新
	PostOrderHot    = 2 //最热
)

type Post struct {
	ModelUpdate
	TopicId      int `gorm:"default:0"`
	CatId        int `gorm:"default:0"`
	UserId       int
	ShareCount   int `gorm:"default:0"`
	LikeCount    int `gorm:"default:0"`
	UnlikeCount  int `json:"unlike_count" gorm:"default:0"`
	CommentCount int `gorm:"default:0"`
	SeeType      int `gorm:"default:0"`
	Type         int `gorm:"default:1"`
	Title        string
	Content      string
	Location     string
}

type PostInfo struct {
	ModelCreate
	UserId       int    `json:"user_id"`
	ShareCount   int    `json:"share_count"`
	LikeCount    int    `json:"like_count"`
	UnlikeCount  int    `json:"unlike_count"`
	CommentCount int    `json:"comment_count"`
	Title        string `json:"title"`
	Content      string `json:"content"`
	Location     string `json:"location"`
	UserList
}

type PostRecommend struct {
	ModelId
	Title string `json:"title"`
}

type PostCount struct {
	Type  int //类型
	C int //汇总数量
}
