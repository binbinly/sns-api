package models


type UserProfile struct {
	ModelId

	UserId     int    `json:"user_id"`
	Gender     int    `json:"gender"`
	Emotion    int    `json:"emotion"`
	Job        string `json:"job"`
	Hometown   string `json:"hometown"`
	Birthday   string `json:"birthday"`
	Sign       string `json:"sign"`
	Background string `json:"background"`
}

type UserProfileInfo struct {
	Gender     int    `json:"gender"`
	Emotion    int    `json:"emotion"`
	Job        string `json:"job"`
	Hometown   string `json:"hometown"`
	Birthday   string `json:"birthday"`
	Sign       string `json:"sign"`
}

func (UserProfileInfo) TableName() string {
	return TableUserProfile
}
