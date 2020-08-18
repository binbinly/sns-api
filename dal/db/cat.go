package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
)

//所有分类
func CatAll() (cat []models.Cat, err error) {
	err = DB.Model(&models.Cat{}).Order("sort desc").Find(&cat).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return cat, nil
}