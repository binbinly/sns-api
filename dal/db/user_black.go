package db

import (
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//是否已经存在
func BlackExist(userId, blackId int) bool {
	var c int
	err := DB.Model(&models.UserBlack{}).Where("user_id = ? && black_id = ?", userId, blackId).Count(&c).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	if c > 0 {
		return true
	}
	return false
}

//加入黑名单
func AddBlack(userId, blackId int) bool {
	exist := BlackExist(userId, blackId)
	if exist {
		return false
	}
	black := &models.UserBlack{
		UserId:      userId,
		BlackId:     blackId,
	}
	err := DB.Model(&models.UserBlack{}).Create(black).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//移除黑名单
func RemoveBlack(userId, blackId int) bool {
	exist := BlackExist(userId, blackId)
	if !exist {
		return false
	}
	err := DB.Where("user_id = ? && black_id = ?", userId, blackId).Delete(&models.UserBlack{}).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}