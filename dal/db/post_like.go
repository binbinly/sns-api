package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//验证用户列表是否赞踩
func PostLikeCheckList(myId int, postIds []int) (list []models.PostLike, err error) {
	err = DB.Model(&models.PostLike{}).Where("user_id = ? && post_id in (?)", myId, postIds).Find(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//是否点赞
func IsPostLike(myId, postId int) int {
	var like = &models.PostLike{}
	err := DB.Model(&models.PostLike{}).Where("user_id = ? && post_id = ?", myId, postId).First(&like).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		logger.Error(err)
		return 0
	}
	if like.ID > 0 {
		return like.Type
	}
	return 0
}

//赞踩操作
func PostLikeUser(userId, postId, t int) bool {
	f := &models.PostLike{}
	err := DB.Model(&models.PostLike{}).Where("user_id = ? && post_id = ?", userId, postId).First(f).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		logger.Error(err)
		return false
	}
	pu := make(map[string]interface{}, 0)
	if t == models.TypeLike {
		pu["like_count"] = gorm.Expr("`like_count` + 1")
	} else {
		pu["unlike_count"] = gorm.Expr("`unlike_count` + 1")
	}
	if f.ID > 0 {
		if f.Type == t {//重复操作
			return true
		}
		if t == models.TypeLike {
			pu["unlike_count"] = gorm.Expr("`unlike_count` - 1")
		} else {
			pu["like_count"] = gorm.Expr("`like_count` - 1")
		}
	}
	f.UserId = userId
	f.PostId = postId
	f.Type = t
	tx := DB.Begin()
	err = tx.Save(f).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	//修改动态赞踩数量
	err = tx.Model(&models.Post{}).Where("id = ?", postId).Updates(pu).Error
	if err != nil {
		tx.Rollback()
		logger.Error(err)
		return false
	}
	tx.Commit()
	return true
}
