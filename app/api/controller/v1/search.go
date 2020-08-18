package v1

import (
	"github.com/gin-gonic/gin"
	"sns-api/app/api/controller"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/app/logic"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

const (
	SearchTypeUser  = 1	//搜索用户
	SearchTypeTopic = 2	//搜索话题
	SearchTypePost  = 3	//搜索动态
)

//搜索
func Search(c *gin.Context) {
	r := controller.NewResponse(c)
	var form proto.SearchReq
	isValid := BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}
	userId := GetUserId(c)
	switch form.T {
	case SearchTypePost:
		list, err := db.PostList(form.Q, 0, GetPageOffset(c), PageSize)
		if err != nil {
			logger.Error(err)
			r.ResponseError(common.ErrorDBError)
			return
		}
		if len(list) == 0 {
			r.ResponseError(common.ErrorDataNotFound)
			return
		}
		r.ResponseSuccess(logic.FormatPostList(userId, list))
		return
	case SearchTypeTopic:
		list, err := db.TopicList(form.Q, 0, GetPageOffset(c), PageSize)
		if err != nil {
			logger.Error(err)
			r.ResponseError(common.ErrorDBError)
			return
		}
		if len(list) == 0 {
			r.ResponseError(common.ErrorDataNotFound)
			return
		}
		r.ResponseSuccess(logic.FormatTopicList(list))
		return
	case SearchTypeUser:
		list, err := db.UserList(form.Q)
		if err != nil {
			logger.Error(err)
			r.ResponseError(common.ErrorDBError)
			return
		}
		if len(list) == 0 {
			r.ResponseError(common.ErrorDataNotFound)
			return
		}
		r.ResponseSuccess(list)
		return
	}
	r.ResponseError(common.ErrorRequestParams)
}
