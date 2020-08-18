package models

import "sns-api/tools/ssl"

type User struct {
	ModelUpdate

	Password string
	Username string `gorm:"unique;not null"`
	Avatar   string
	Phone    string
	Nickname string
}

type UserInfo struct {
	Username string `json:"username"`
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`

	UserProfileInfo
}

type UserList struct {
	Username string `json:"nickname"`
	Nickname string `json:"nickname"`
	Avatar   string `json:"avatar"`
}

func (UserInfo) TableName() string {
	return TableUser
}

func (u *User) BeforeSave() (err error) {
	u.Password = ssl.GeneratePassword(u.Password)
	return
}