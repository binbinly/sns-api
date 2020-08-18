package logic

import (
	"sns-api/app/api/proto"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

//动态详情
func PostDetail(id, userId int) *proto.PostListRsp {
	info, err := db.PostDetail(id)
	if err != nil {
		logger.Error(err)
		return nil
	}
	if info.ID == 0 {
		return nil
	}
	rp := &proto.PostListRsp{
		PostInfo: info,
		State:    &proto.State{},
		Image:    make([]*proto.ImageInfo, 0),
	}
	i, err := db.ImageByPostId(id)
	if err != nil {
		logger.Error(err)
		return nil
	}
	if len(i) > 0 {
		for _, v := range i {
			rp.Image = append(rp.Image, GetThumbInfo(v.Path))
		}
	}
	if userId > 0 {
		if userId == info.UserId {
			rp.State.Follow = true
		} else {
			rp.State.Follow = db.IsFollow(userId, info.UserId)
		}
		rp.State.Type = db.IsPostLike(userId, info.ID)
	}
	return rp
}

func FormatPostList(userId int, list []models.PostInfo) []*proto.PostListRsp {
	l := make([]*proto.PostListRsp, 0)
	if len(list) == 0 {
		return l
	}
	userIds, postIds := getIds(list)
	//获取图片
	images := getPostImages(postIds)
	//赞踩列表
	likes := getPostLikes(userId, postIds)
	for _, v := range list {
		a := v
		rp := &proto.PostListRsp{
			PostInfo: &a,
			State:   &proto.State{},
			Image:   make([]*proto.ImageInfo, 0),
		}
		if p, ok := images[v.ID]; ok {
			rp.Image = p
		}
		//是否关注
		if userId > 0 {
			if userId == v.UserId {
				rp.State.Follow = true
			} else {
				//关注列表
				fUserIds, err:= db.FollowCheckList(userId, userIds)
				if err != nil {
					logger.Error(err)
					continue
				}
				rp.State.Follow = userIsFollow(rp.UserId, fUserIds)
			}
			if t, ok := likes[v.ID]; ok {
				rp.State.Type = t
			}
		}
		l = append(l, rp)
	}
	return l
}

//获取动态图片
func getPostImages(postIds []int) map[int][]*proto.ImageInfo {
	list, err := db.ImageList(postIds)
	if err != nil {
		logger.Error(err)
		return nil
	}
	if len(list) == 0 {
		return nil
	}
	var l = make(map[int][]*proto.ImageInfo, 0)
	for _, v := range list {
		if _, ok := l[v.PostId]; ok {
			l[v.PostId] = append(l[v.PostId], GetThumbInfo(v.Path))
		} else {
			i := make([]*proto.ImageInfo, 0)
			i = append(i, GetThumbInfo(v.Path))
			l[v.PostId] = i
		}
	}
	return l
}

//获取赞踩信息
func getPostLikes(userId int, postIds []int) map[int]int {
	list, err := db.PostLikeCheckList(userId, postIds)
	if err != nil {
		logger.Error(err)
		return nil
	}
	var l = make(map[int]int, 0)
	if len(list) == 0 {
		return nil
	}
	for _, v := range list {
		l[v.PostId] = v.Type
	}
	return l
}

//获取列表用户数组,动态数组
func getIds(list []models.PostInfo) ([]int, []int) {
	mUserIds := make(map[int]bool, 0)
	mPostIds := make(map[int]bool, 0)
	for _, v := range list {
		mUserIds[v.UserId] = true
		mPostIds[v.ID] = true
	}
	userIds := make([]int, 0)
	for k, _ := range mUserIds {
		userIds = append(userIds, k)
	}
	postIds := make([]int, 0)
	for k, _ := range mPostIds {
		postIds = append(postIds, k)
	}
	return userIds, postIds
}

//数值中是否存在
func userIsFollow(id int, ids []int) bool {
	for _, v := range ids {
		if v == id {
			return true
		}
	}
	return false
}
