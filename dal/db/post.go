package db

import (
	"fmt"
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
	"strings"
)

//添加动态
func CreatePost(userId, seeType, topicId, catId int, content, image string) bool {
	post := &models.Post{
		UserId:  userId,
		SeeType: seeType,
		Content: content,
		TopicId: topicId,
		CatId:   catId,
	}
	c := []rune(content)
	if len(c) > 80 {//截取字符串为标题
		post.Title = string(c[:80])
	} else {
		post.Title = content
	}
	if topicId > 0 {
		post.Type = models.TypeTopicPost
	}
	tx := DB.Begin()
	err := tx.Model(&models.Post{}).Create(post).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	if image == "" {
		tx.Rollback()
		return false
	}
	imageList := strings.Split(image, ",")
	if len(imageList) == 0 { //没有图片，直接返回成功
		tx.Commit()
		return true
	}
	//添加图片
	sql := "INSERT INTO `post_rel_image` (`post_id`,`image_id`) VALUES "
	// 循环data数组,组合sql语句
	for key, value := range imageList {
		if len(imageList)-1 == key { //最后一条数据 以分号结尾
			sql += fmt.Sprintf("(%d,%s);", post.ID, value)
		} else {
			sql += fmt.Sprintf("(%d,%s),", post.ID, value)
		}
	}
	err = tx.Exec(sql).Error
	if err != nil {
		tx.Rollback()
		logger.Error(err)
		return false
	}
	// 话题动态+1
	if topicId > 0 {
		err = tx.Model(&models.Topic{}).Where("id = ?", topicId).Update("post_count", gorm.Expr("post_count + ?", 1)).Error
		if err != nil {
			tx.Rollback()
			logger.Error(err)
			return false
		}
	}
	tx.Commit()
	return true
}

//动态详情
func PostDetail(id int) (info *models.PostInfo, err error) {
	info = &models.PostInfo{}
	err = DB.Scopes(postJoinUser).First(&info, id).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return info, nil
}

// 动态列表
func PostList(q string, cid, offset, limit int) (list []models.PostInfo, err error) {
	err = DB.Scopes(postJoinUser, whereQ(q), whereCat(cid), whereSeeType(models.SeeTypeAll), OffsetPage(offset, limit)).Order(DefaultOrder).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//话题下动态
func PostListByTopic(tid, orderType, offset, limit int) (list []models.PostInfo, err error) {
	order := DefaultOrder
	if orderType == models.PostOrderHot {
		order = "like_count desc, comment_count desc"
	}
	err = DB.Scopes(postJoinUser, whereTopic(tid), whereSeeType(models.SeeTypeAll), OffsetPage(offset, limit)).Order(order).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

// 我的动态列表
func MyPostList(userId, t, offset, limit int) (list []models.PostInfo, err error) {
	err = DB.Scopes(postJoinUser, OffsetPage(offset, limit)).
		Where("user_id = ? && `type` = ? ", userId, t).Order(DefaultOrder).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

// 好友动态列表
func FollowPostList(userId, offset, limit int) (list []models.PostInfo, err error) {
	err = DB.Scopes(postJoinUser, whereSeeType(models.SeeTypeAll), OffsetPage(offset, limit)).
		Where("user_id in (select follow_id from user_follow where user_id = ? )", userId).
		Order(DefaultOrder).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//话题中推荐的动态
func PostRecommendList(topicId int) (list []models.PostRecommend, err error) {
	err = DB.Model(&models.Post{}).Where("topic_id = ? and is_recommend = 1 ", topicId).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//连user表
func postJoinUser(db *gorm.DB) *gorm.DB {
	return db.Table("post").Select("post.*,u.username,u.avatar").Joins("left join `user` as u on post.user_id = u.id")
}

//可见筛选
func whereSeeType(seeType int) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		return db.Where("see_type = ?", seeType)
	}
}

//查询分类
func whereCat(cid int) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if cid > 0 {
			return db.Where("cat_id = ?", cid)
		}
		return db
	}
}

//搜索
func whereQ(q string) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if q != "" {
			return db.Where("content LIKE ?", "%"+q+"%")
		}
		return db
	}
}

//查询话题
func whereTopic(tid int) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if tid > 0 {
			return db.Where("topic_id = ? ", tid)
		}
		return db
	}
}

func PostTotal(userId int) int {
	var c = 0
	err := DB.Model(&models.Post{}).Where("user_id = ?", userId).Count(&c).Error
	if err != nil {
		return 0
	}
	return c
}

//汇总动态，帖子数量
func PostCount(userId int) (int, int) {
	var postC = make([]*models.PostCount, 0)
	err := DB.Model(&models.Post{}).Select("type, count(*) as c").
		Where("user_id = ? ", userId).Group("type").Scan(&postC).Error
	if err != nil {
		return 0, 0
	}
	pc := 0
	tc := 0
	for _, v := range postC {
		switch v.Type {
		case models.TypePost:
			pc = v.C
		case models.TypeTopicPost:
			tc = v.C
		}
	}
	return pc, tc
}
