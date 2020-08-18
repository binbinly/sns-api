package models

type Comment struct {
	ModelCreate

	PostId    int    `json:"post_id"`
	UserId    int    `json:"user_id"`
	ReplyId   int    `json:"reply_id"`
	ReplyRoot int    `json:"reply_root"`
	Content   string `json:"content"`
}

type CommentList struct {
	Comment
	UserList
}
