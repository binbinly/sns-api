package user

import (
	"github.com/gin-gonic/gin"
	"sns-api/app/api/controller"
	"sns-api/app/api/controller/v1"
	"sns-api/app/api/middleware/auth"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/app/logic"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//注销登录
func Logout(c *gin.Context) {
	r:= controller.NewResponse(c)
	err := auth.Logout(c)
	if err != nil {
		r.ResponseErrorNil()
		return
	}
	r.ResponseSuccessNil()
}

//注册
func Register(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.RegisterReq
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
		user, err = db.UserByName(form.Username)
		if err != nil {
			logger.Error(err)
			r.ResponseError(common.ErrorDBError)
			return
		}
	}
	if user != nil {
		r.ResponseError(common.ErrorRegisterNameExist)
		return
	}
	u := db.CreateUser(form.Username, form.Password, form.Phone)
	if u {
		r.ResponseSuccessNil()
		return
	}
	r.ResponseErrorNil()
}

//我的-页面信息
func MyInfo(c *gin.Context) {
	r := controller.NewResponse(c)
	var userId = v1.GetUserId(c)

	my := &proto.UserMyRsp{}

	my.Info = logic.UserMyInfo(userId)
	list, err := db.AdsList(models.AdsMyBanner)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	my.Bg = logic.FormatImageUrl(list)
	r.ResponseSuccess(my)
}

//用户空间
func Space(c *gin.Context) {
	r := controller.NewResponse(c)
	uid := v1.GetQueryIntKey(c, "uid")
	if uid == 0 {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	uc := logic.UserProfile(v1.GetUserId(c), uid)
	r.ResponseSuccess(uc)
}

//用户详情
func ProfileInfo(c *gin.Context) {
	r := controller.NewResponse(c)
	var userId = v1.GetUserId(c)
	user, err := db.UserProfileInfo(userId)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if user == nil {
		r.ResponseErrorNil()
		return
	}
	r.ResponseSuccess(user)
}

//用户详情保存
func ProfileSave(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.UserProfileReq
	_ = v1.BindJsonValid(c, &form)
	is := db.UserProfileSave(v1.GetUserId(c), form)
	if !is {
		r.ResponseErrorNil()
		return
	}
	r.ResponseSuccessNil()
}

//用户赞踩
func Like(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.UserLikeReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	is := db.PostLikeUser(v1.GetUserId(c), form.PostId, form.Type)
	if !is {
		r.ResponseErrorNil()
		return
	}
	r.ResponseSuccessNil()
}

//绑定手机号
func BindPhone(c *gin.Context)  {
	r := controller.NewResponse(c)
	var form proto.PhoneCodeLoginReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	is := db.EditPhone(v1.GetUserId(c),form.Phone)
	if !is {
		r.ResponseErrorNil()
		return
	}
	r.ResponseSuccessNil()
}
