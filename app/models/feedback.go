package models

type Feedback struct {
	ModelCreate

	UserId  int
	Content string
}
