package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//话题列表
func TopicList(q string, catId, offset, limit int) (list []models.Topic, err error) {
	err = DB.Model(&models.Topic{}).Scopes(whereTopicQ(q), whereTopicCat(catId)).Offset(offset).Limit(limit).Find(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//活跃话题
func TopicListByTime(limit int) (list []models.Topic, err error) {
	err = DB.Model(&models.Topic{}).Order("updated_at desc").Limit(limit).Find(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//话题详情
func TopicDetail(id int) (info *models.Topic, err error) {
	info = &models.Topic{}
	err = DB.Model(&models.Topic{}).First(info, id).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return info, nil
}

//验证话题是否存在
func TopicExist(topicId int) bool {
	var count int
	err := DB.Model(&models.Topic{}).Where("id = ?", topicId).Count(&count).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//查询分类
func whereTopicCat(cid int) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if cid > 0 {
			return db.Where("cat_id = ?", cid)
		}
		return db
	}
}

//搜索
func whereTopicQ(q string) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if q != "" {
			return db.Where("title LIKE ?", "%"+q+"%")
		}
		return db
	}
}