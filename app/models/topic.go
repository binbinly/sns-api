package models

type Topic struct {
	ModelId

	Title     string `json:"title"`
	Cover     string `json:"cover"`
	Desc      string `json:"desc"`
	PostCount int    `json:"post_count"`
}
