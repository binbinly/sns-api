package user

import (
	"github.com/gin-gonic/gin"
	"sns-api/app/api/controller"
	v1 "sns-api/app/api/controller/v1"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/dal/db"
)

//加入黑名单
func AddBlack(c *gin.Context)  {
	r := controller.NewResponse(c)
	var form proto.UserIDReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	is := db.AddBlack(v1.GetUserId(c), form.UserId)
	if is {
		r.ResponseSuccessNil()
	} else {
		r.ResponseErrorNil()
	}
}

//移除黑名单
func RemoveBlack(c *gin.Context)  {
	r := controller.NewResponse(c)
	var form proto.UserIDReq
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	is := db.RemoveBlack(v1.GetUserId(c), form.UserId)
	if is {
		r.ResponseSuccessNil()
	} else {
		r.ResponseErrorNil()
	}
}