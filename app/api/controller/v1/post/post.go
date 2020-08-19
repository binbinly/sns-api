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
	"sns-api/tools"
	"sns-api/tools/logger"
)

func Create(c *gin.Context) {
	r := controller.NewResponse(c)
	form := proto.PostReq{}
	isValid := v1.BindJsonValid(c, &form)
	if !isValid {
		r.ResponseError(common.ErrorRequestParamsCheck)
		return
	}
	if form.TopicId > 0 {
		exist := db.TopicExist(form.TopicId)
		if exist == false { //话题ID不存在，则重置
			form.TopicId = 0
		}
	}
	//xss过滤
	p := bluemonday.NewPolicy()
	form.Content = p.Sanitize(form.Content)
	is := db.CreatePost(v1.GetUserId(c), form.SeeType, form.TopicId, form.CatId, tools.Replace(form.Content), form.Image)
	if is {
		r.ResponseSuccessNil()
	} else {
		r.ResponseErrorNil()
	}
}

//动态详情
func Detail(c *gin.Context) {
	r := controller.NewResponse(c)
	id := v1.GetQueryIntKey(c, "id")
	if id == 0 {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	data := logic.PostDetail(id, v1.GetUserId(c))
	if data == nil {
		r.ResponseError(common.ErrorDataNotFound)
		return
	}
	r.ResponseSuccess(data)
}

func List(c *gin.Context) {
	r := controller.NewResponse(c)
	cid := v1.GetQueryIntKey(c, "cid")
	list, err := db.PostList("", cid, v1.GetPageOffset(c), v1.PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatPostList(v1.GetUserId(c), list))
}

//某用户动态
func MyList(c *gin.Context) {
	r := controller.NewResponse(c)
	userId := v1.GetUserId(c)
	uid := v1.GetQueryIntKey(c, "uid")
	t := v1.GetQueryIntKey(c, "type")
	if uid > 0 { //参数存在则获取当前用户动态信息
		userId = uid
	}
	list, err := db.MyPostList(userId, t, v1.GetPageOffset(c), v1.PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatPostList(userId, list))
}

//关注列表
func FollowList(c *gin.Context) {
	r := controller.NewResponse(c)
	userId := v1.GetUserId(c)
	list, err := db.FollowPostList(userId, v1.GetPageOffset(c), v1.PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatPostList(userId, list))
}

//话题下动态
func ListByTopic(c *gin.Context) {
	r := controller.NewResponse(c)
	userId := v1.GetUserId(c)

	tid := v1.GetQueryIntKey(c, "tid")
	if tid == 0 {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	order := v1.GetQueryIntKey(c, "order")
	list, err := db.PostListByTopic(tid, order, v1.GetPageOffset(c), v1.PageSize)
	if err != nil {
		logger.Error(err)
		r.ResponseError(common.ErrorDBError)
		return
	}
	r.ResponseSuccess(logic.FormatPostList(userId, list))
}
