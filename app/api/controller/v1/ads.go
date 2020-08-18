package v1

import (
	"github.com/gin-gonic/gin"
	"github.com/unknwon/com"
	"sns-api/app/api/controller"
	"sns-api/app/common"
	"sns-api/app/logic"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//广告列表
func AdsList(c *gin.Context)  {
	r := controller.NewResponse(c)
	pid := com.StrTo(c.Query("pid")).MustInt()
	list, err := db.AdsList(pid)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if len(list) == 0 {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}

	r.ResponseSuccess(logic.FormatImageUrl(list))
}