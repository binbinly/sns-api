package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/api/proto"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//评论数汇总
func CommentCount(userId int) int {
	var c = 0
	err := DB.Model(&models.Comment{}).Where("user_id = ?", userId).Count(&c).Error
	if err != nil {
		logger.Error(err)
		return 0
	}
	return c
}

//发布评论
func CreateComment(userId int, form *proto.CommentReq) bool {
	c := &models.Comment{
		PostId:    form.PostId,
		UserId:    userId,
		ReplyId:   form.ReplyId,
		ReplyRoot: form.ReplyRoot,
		Content:   form.Content,
	}
	tx := DB.Begin()
	err := tx.Model(&models.Comment{}).Create(c).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	//修改动态赞踩数量
	err = tx.Model(&models.Post{}).Where("id = ?", form.PostId).Update("comment_count", gorm.Expr("comment_count + ?", 1)).Error
	if err != nil {
		tx.Rollback()
		logger.Error(err)
		return false
	}
	tx.Commit()
	return true
}

//评论列表
func CommentList(postId, offset, limit int) (list []models.CommentList, err error) {
	err = DB.Scopes(commentJoinUser, OffsetPage(offset, limit)).Where("post_id = ? && reply_id = 0", postId).Order(DefaultOrder).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//回复列表
func CommentReplyList(commentIds []int) (list []models.CommentList, err error) {
	err = DB.Scopes(commentJoinUser).Where("reply_root in (?)", commentIds).Order("id asc").Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//连接 user table
func commentJoinUser(db *gorm.DB) *gorm.DB {
	return db.Table("comment").Select("comment.*,u.username,u.avatar,u.nickname").
		Joins("left join `user` as u on comment.user_id = u.id")
}