package proto

import (
	"sns-api/app/models"
)

type CommentRsp struct {
	*CommentInfo
	Reply []*CommentInfo `json:"reply"`
}

type CommentInfo struct {
	Id        int    `json:"id"`
	UserId    int    `json:"user_id"`
	CreatedAt int    `json:"created_at"`
	Content   string `json:"content"`
	Username  string `json:"username"`
	Avatar    string `json:"avatar"`
}

type PostListRsp struct {
	*models.PostInfo
	Image []*ImageInfo `json:"image"`
	State *State       `json:"state"`
}

type State struct {
	Follow bool `json:"follow"` //是否关注
	Type   int  `json:"type"`   //类型,1=赞，2=踩
}

type ImageInfo struct {
	Id     int    `json:"id"`
	Thumb  string `json:"thumb"`
	Big    string `json:"big"`
	Source string `json:"source"`
}

type UserCountRsp struct {
	FriendCount int `json:"friend_count"`
	FollowCount int `json:"follow_count"`
	FensCount   int `json:"fens_count"`
}

type UserMyRsp struct {
	Info *UC          `json:"info"`
	Bg   []models.Ads `json:"bg"`
}

type UC struct {
	TCount       int `json:"t_count"`       //总动态数
	PostCount    int `json:"post_count"`    //动态数
	TPostCount   int `json:"t_post_count"`  //帖子数
	CommentCount int `json:"comment_count"` //评论数
	FensCount    int `json:"fens_count"`    //粉丝数
}

type US struct {
	IsFollow    bool             `json:"is_follow"`    //是否关注
	IsBlack     bool             `json:"is_black"`     //是否加入黑名单
	PostCount   int              `json:"post_count"`   //帖子数
	FollowCount int              `json:"follow_count"` //关注数
	FensCount   int              `json:"Fens_count"`   //粉丝数
	Info        *models.UserInfo `json:"info"`         //用户详情
}

type TopicRsp struct {
	*models.Topic

	TodayCount int `json:"today_count"` //当日动态数
}

type TopicDetailRsp struct {
	TopicRsp
	Recommend []models.PostRecommend `json:"recommend"`
}
