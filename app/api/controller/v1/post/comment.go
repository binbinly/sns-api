package post

import (
	"github.com/gin-gonic/gin"
	"github.com/microcosm-cc/bluemonday"
	"sns-api/app/api/controller"
	"sns-api/app/api/controller/v1"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/app/logic"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//添加一条评论
func CreateComment(c *gin.Context) {
	r := controller.NewResponse(c)
	form := &proto.CommentReq{}
	isValid := v1.BindJsonValid(c, form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	//xss过滤
	p := bluemonday.NewPolicy()
	form.Content = p.Sanitize(form.Content)
	is := db.CreateComment(v1.GetUserId(c), form)
	if is {
		r.ResponseSuccessNil()
		return
	}
	r.ResponseErrorNil()
}

//评论列表
func CommentList(c *gin.Context) {
	r := controller.NewResponse(c)
	pid := v1.GetQueryIntKey(c, "pid")
	if pid == 0 {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	list, err := db.CommentList(pid, v1.GetPageOffset(c), v1.PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatCommentList(list))
}