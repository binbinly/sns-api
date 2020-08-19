package user

import (
	"github.com/gin-gonic/gin"
	"sns-api/app/api/controller"
	"sns-api/app/api/controller/v1"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//用户关注
func Follow(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.UserIDReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	var userId = v1.GetUserId(c)
	if userId == form.UserId {
		r.ResponseErrorMsg("不可以关注自己")
		return
	}
	s := db.FollowUser(userId, form.UserId)
	if s {
		r.ResponseSuccessNil()
		return
	}
	r.ResponseErrorNil()
}

//取消关注
func UnFollow(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.UserIDReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	var userId = v1.GetUserId(c)
	if userId == form.UserId {
		r.ResponseErrorMsg("不可以取消关注自己")
		return
	}
	s := db.UnFollowUser(userId, form.UserId)
	if s {
		r.ResponseSuccessNil()
		return
	}
	r.ResponseErrorNil()
}

//好友列表
func FriendList(c *gin.Context) {
	r := controller.NewResponse(c)
	list, err := db.FriendList(v1.GetUserId(c))
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(list)
}

//关注列表
func FollowList(c *gin.Context) {
	r := controller.NewResponse(c)
	list, err := db.FollowList(v1.GetUserId(c))
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(list)
}

//粉丝列表
func FensList(c *gin.Context) {
	r := controller.NewResponse(c)
	list, err := db.FensList(v1.GetUserId(c))
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(list)
}

//统计数量
func Count(c *gin.Context) {
	r := controller.NewResponse(c)
	userId := v1.GetUserId(c)
	count := &proto.UserCountRsp{
		FriendCount: db.FriendCount(userId),
		FollowCount: db.FollowCount(userId),
		FensCount:   db.FensCount(userId),
	}
	r.ResponseSuccess(count)
}
