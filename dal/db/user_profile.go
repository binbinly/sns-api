package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/api/proto"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//获取用户详情
func UserProfileInfo(userId int) (user *models.UserProfileInfo, err error) {
	user = &models.UserProfileInfo{}
	err = DB.Model(&models.UserProfileInfo{}).Where("user_id = ?", userId).First(user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//保存详情
func UserProfileSave(userId int, form proto.UserProfileReq) bool {
	pro := &models.UserProfile{}
	err := DB.Model(&models.UserProfile{}).Where("user_id = ?", userId).First(pro).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		logger.Error(err)
		return false
	}
	if pro.ID == 0 {
		pro.UserId = userId
	}
	pro.Gender = form.Gender
	pro.Emotion = form.Emotion
	pro.Job = form.Job
	pro.Hometown = form.Hometown
	pro.Birthday = form.Birthday
	pro.Sign = form.Sign
	pro.Background = form.Background

	tx := DB.Begin()
	err = tx.Save(pro).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	user := &models.User{}
	err = tx.Model(&models.User{}).Where("id = ?", userId).First(user).Error
	if err != nil {
		tx.Rollback()
		logger.Error(err)
		return false
	}
	if user.Nickname != form.Nickname || user.Avatar != form.Avatar { //有修改才更新
		user.Nickname = form.Nickname
		user.Avatar = form.Avatar
		err = tx.Save(user).Error
		if err != nil {
			tx.Rollback()
			logger.Error(err)
			return false
		}
	}
	tx.Commit()
	return true
}
