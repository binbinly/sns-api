package v1

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"math/rand"
	"sns-api/app/api/controller"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/dal/db"
	"sns-api/dal/redis"
	"sns-api/tools/logger"
	"time"
)

//版本升级
func VersionUpgrade(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.VersionUpgradeReq

	isValid := BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}

	newVersion, err := db.Newest()
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if newVersion == nil {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}
	ret := versionCompare(form.Num, newVersion.VersionNumber)
	if ret == 0 {
		r.ResponseError(common.ErrorRequestParamsCheck)
	} else if ret < 0 {
		r.ResponseError(common.ErrorNotNewVersion)
	} else {
		r.ResponseSuccess(newVersion)
	}
}

//发送短信验证码
func SendCode(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.SendCodeReq

	isValid := BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}

	code := rand.New(rand.NewSource(time.Now().UnixNano())).Int31n(1000)
	redis.Client.Set(SmsCodeKey+ form.Phone, code, time.Second * 300)
	r.ResponseSuccessMsg(fmt.Sprintf("验证码：%d", code))
}