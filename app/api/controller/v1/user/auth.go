package user

import (
	"github.com/gin-gonic/gin"
	"sns-api/app"
	"sns-api/app/api/controller"
	"sns-api/app/api/controller/v1"
	"sns-api/app/api/middleware/auth"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools/logger"
	"sns-api/tools/ssl"
)

//短信验证码登录
func PhoneCodeLogin(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.PhoneCodeLoginReq

	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	user, err := db.UserByPhone(form.Phone)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if user == nil {
		r.ResponseError(common.ErrorLoginNameNot)
		return
	}
	r.ResponseSuccess(authUser(user))
}

//用户名密码登录
func LoginByPassword(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.LoginByPasswordReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	var user *models.User
	user, err := db.UserByPhone(form.Username)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if user.ID == 0 {
		user, err = db.UserByName(form.Username)
		if err != nil {
			logger.Error(err)
			r.ResponseError(common.ErrorDBError)
			return
		}
	}
	if user.ID == 0 {
		r.ResponseError(common.ErrorLoginNameNot)
		return
	}
	if !ssl.ValidatePassword(form.Password, user.Password) {
		r.ResponseError(common.ErrorLoginPassword)
		return
	}
	r.ResponseSuccess(authUser(user))
}

func authUser(user *models.User) *app.User {
	var name string
	if user.Nickname != "" {
		name = user.Nickname
	} else {
		name = user.Username
	}
	authUser := &app.User{
		UserId:   user.ID,
		Username: name,
		Avatar:   user.Avatar,
		Phone:    user.Phone,
	}
	authUser.Token = auth.Login(authUser)
	return authUser
}
