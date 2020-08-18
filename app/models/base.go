package models

const (
	TableAds         = "ads"
	TableCat         = "cat"
	TableComment     = "comment"
	TableFeedback    = "feedback"
	TableFollow      = "user_follow"
	TableImage       = "image"
	TablePost        = "post"
	TablePostLike    = "post_like"
	TableTopic       = "topic"
	TableUser        = "user"
	TableUserProfile = "user_profile"
	TableVersion     = "app_version"
)

type Model struct {
	ID        int `gorm:"primary_key" json:"id"`
	CreatedAt int `json:"created_at"`
	UpdatedAt int `json:"updated_at"`
	DeletedAt int `json:"deleted_at"`
}

type ModelId struct {
	ID int `gorm:"primary_key" json:"id"`
}

type ModelCreate struct {
	ID        int `gorm:"primary_key" json:"id"`
	CreatedAt int `json:"created_at"`
}

type ModelOnlyUpdate struct {
	ID        int `gorm:"primary_key" json:"id"`
	UpdatedAt int `json:"updated_at"`
}

type ModelUpdate struct {
	ID        int `gorm:"primary_key" json:"id"`
	CreatedAt int `json:"created_at"`
	UpdatedAt int `json:"updated_at"`
}
