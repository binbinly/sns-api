package post

import (
	"github.com/gin-gonic/gin"
	"sns-api/app/api/controller"
	"sns-api/app/common"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//所有分类
func Cat(c *gin.Context)  {
	r := controller.NewResponse(c)
	list, err := db.CatAll()
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(list)
}