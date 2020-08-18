package models

const (
	TypeUploadImage  = 0 //上传图片
	TypeUploadAvatar = 1 //上传头像
)

type Image struct {
	ModelCreate
	UserId   int
	Type     int
	Size     int64
	Filename string
	MimeType string
	FileMd5  string
	Path     string
}

type ImageList struct {
	PostId int    `json:"post_id"`
	Path   string `json:"path"`
}
