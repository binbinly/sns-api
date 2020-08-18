package models

type FeedBack struct {
	ModelCreate

	UserId  int
	FromId  int
	Content string
}
