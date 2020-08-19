package proto

type VersionUpgradeReq struct {
	Num string `json:"num" binding:"required,v_num"`
}

type SendCodeReq struct {
	Phone string `json:"phone" binding:"required,mobile"`
}

type SearchReq struct {
	T int    `json:"t" binding:"required"`
	Q string `json:"q" binding:"required"`
}

type FeedbackReq struct {
	Category string `json:"category" binding:"required"`
	Content  string `json:"content" binding:"required"`
}

type PhoneCodeLoginReq struct {
	Phone string `json:"phone" binding:"required,mobile"`
	Code  string `json:"code" binding:"required,len=4"`
}

type UserPwdLoginReq struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

type PostReq struct {
	TopicId int    `json:"topic_id" binding:"omitempty,numeric"`
	CatId   int    `json:"cat_id" binding:"omitempty,numeric"`
	SeeType int    `json:"see_type" binding:"omitempty,numeric"`
	Content string `json:"content" binding:"required"`
	Image   string `json:"image"`
}

type CommentReq struct {
	PostId    int    `json:"post_id" binding:"required,numeric"`
	ReplyId   int    `json:"reply_id" binding:"omitempty,numeric"`
	ReplyRoot int    `json:"reply_root" binding:"omitempty,numeric"`
	Content   string `json:"content" binding:"required"`
	Image     string `json:"image"`
}

type RegisterReq struct {
	Username        string `json:"username" binding:"required,min=3,max=18"`
	Password        string `json:"password" binding:"required,min=6,max=20"`
	ConfirmPassword string `json:"confirm_password" binding:"required,eqfield=Password"`
	Phone           string `json:"phone" binding:"required,mobile"`
	Code            string `json:"code" binding:"required"`
}

type LoginByPasswordReq struct {
	Username string `json:"username" binding:"required,min=3,max=18"`
	Password string `json:"password" binding:"required,min=6,max=20"`
}

type UserIDReq struct {
	UserId int `json:"user_id" binding:"required,numeric"`
}

type UserLikeReq struct {
	PostId int `json:"post_id" binding:"required,numeric"`
	Type   int `json:"type" binding:"required,numeric"`
}

type UserProfileReq struct {
	Gender     int    `json:"gender" binding:"omitempty,numeric"`
	Emotion    int    `json:"emotion" binding:"omitempty,numeric"`
	Avatar     string `json:"avatar"`
	Nickname   string `json:"nickname"`
	Job        string `json:"job"`
	Hometown   string `json:"hometown"`
	Birthday   string `json:"birthday"`
	Sign       string `json:"sign"`
	Background string `json:"background"`
}
