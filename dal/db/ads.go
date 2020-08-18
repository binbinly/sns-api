package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
)

//获取广告位下的广告
func AdsList(position int) (ads []models.Ads, err error) {
	err = DB.Model(&models.Ads{}).Where("position = ?", position).Find(&ads).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return ads, nil
}
