package logic

import (
	"sns-api/app/api/proto"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//我的信息
func UserMyInfo(userId int) *proto.UC {
	c := &proto.UC{}
	c.FensCount = db.FensCount(userId)
	c.CommentCount = db.CommentCount(userId)
	c.PostCount, c.TPostCount = db.PostCount(userId)
	c.TCount = c.PostCount + c.TPostCount
	return c
}

//用户空间信息
func UserProfile(myId, userId int) *proto.US {
	c := &proto.US{}
	c.FensCount = db.FensCount(userId)
	c.FollowCount = db.FollowCount(userId)
	c.PostCount = db.PostTotal(userId)
	c.IsFollow = db.IsFollow(myId, userId)
	info, err := db.UserInfo(userId)
	if err != nil{
		logger.Error(err)
		c.Info = nil
	}
	c.Info = info
	return c
}
