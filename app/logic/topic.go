package logic

import (
	"sns-api/app/api/proto"
	"sns-api/app/models"
)

//格式化话题列表
func FormatTopicList(list []models.Topic) []*proto.TopicRsp {
	var r = make([]*proto.TopicRsp, 0)
	if len(list) == 0 {
		return r
	}
	for _, v := range list {
		a := v
		i := &proto.TopicRsp{
			Topic:      &a,
			TodayCount: 0,
		}
		r = append(r, i)
	}
	return r
}
