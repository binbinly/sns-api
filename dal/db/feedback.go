package db

import (
	"sns-api/app/models"
	"sns-api/tools/logger"
)

func AddFeedback(userId int, content string) bool {
	f := &models.Feedback{
		UserId:      userId,
		Content:     content,
	}
	err := DB.Model(&models.Feedback{}).Create(f).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}