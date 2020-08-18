package logic

import (
	"sns-api/app/api/proto"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//格式化评论列表
func FormatCommentList(list []models.CommentList) []*proto.CommentRsp {
	commendIds := getCommentIds(list)
	l := getReplyList(commendIds)
	rp := make([]*proto.CommentRsp, 0)
	for _, v := range list {
		r := &proto.CommentRsp{
			CommentInfo: formatCommentInfo(v),
			Reply:       make([]*proto.CommentInfo, 0),
		}
		if l != nil {
			if c, ok := l[v.ID]; ok {
				r.Reply = c
			}
		}
		rp = append(rp, r)
	}
	return rp
}

//获取列表评论数组
func getCommentIds(list []models.CommentList) []int {
	commentIds := make([]int, 0)
	for _, v := range list {
		commentIds = append(commentIds, v.ID)
	}
	return commentIds
}

//获取回复列表
func getReplyList(commentIds []int) map[int][]*proto.CommentInfo {
	list, err := db.CommentReplyList(commentIds)
	if err != nil {
		logger.Error(err)
		return nil
	}
	if len(list) == 0 {
		return nil
	}

	var l = make(map[int][]*proto.CommentInfo, 0)
	for _, v := range list {
		if _, ok := l[v.ReplyRoot]; ok {
			l[v.ReplyRoot] = append(l[v.ReplyRoot], formatCommentInfo(v))
		} else {
			i := make([]*proto.CommentInfo, 0)
			i = append(i, formatCommentInfo(v))
			l[v.ReplyRoot] = i
		}
	}
	return l
}

//格式化评论信息
func formatCommentInfo(info models.CommentList) *proto.CommentInfo {
	return &proto.CommentInfo{
		Id:        info.ID,
		UserId:    info.UserId,
		Content:   info.Content,
		Username:  info.Username,
		Avatar:    info.Avatar,
		CreatedAt: info.CreatedAt,
	}
}
