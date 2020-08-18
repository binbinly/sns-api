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

//话题列表
func Topic(c *gin.Context)  {
	r := controller.NewResponse(c)
	cid := GetQueryIntKey(c, "cid")
	list, err := db.TopicList("", cid, GetPageOffset(c), PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatTopicList(list))
}

//最近更新话题
func TopicByTime(c *gin.Context)  {
	r := controller.NewResponse(c)
	list, err := db.TopicListByTime(PageSize)
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
}

//话题详情
func TopicDetail(c *gin.Context)  {
	r := controller.NewResponse(c)
	id := GetQueryIntKey(c, "id")
	if id == 0 {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	t, err := db.TopicDetail(id)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if t == nil {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}
	list, err := db.PostRecommendList(id)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	if len(list) == 0 {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}

	r.ResponseSuccess(proto.TopicDetailRsp{
		TopicRsp:  proto.TopicRsp{
			Topic:      t,
			TodayCount: 0,
		},
		Recommend: list,
	})
}