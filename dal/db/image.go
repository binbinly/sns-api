package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//图片是否已存在
func ImageCheckExist(md5 string) (image *models.Image, err error) {
	image = &models.Image{}
	err = DB.Model(&models.Image{}).Where("file_md5 = ? ", md5).First(image).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return image, nil
}

func AddImage(userId, t int, size int64, filename, mimeType, fileMd5, path string) int {
	image := &models.Image{
		UserId:   userId,
		Size:     size,
		Filename: filename,
		MimeType: mimeType,
		FileMd5:  fileMd5,
		Path:     path,
		Type:     t,
	}
	err := DB.Model(&models.Image{}).Create(image).Error
	if err != nil {
		logger.Error(err)
		return 0
	}
	return image.ID
}

//获取动态图片
func ImageList(postIds []int) (list []models.ImageList, err error) {
	err = DB.Scopes(joinRel).Where("post_id in (?)", postIds).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//获取一个动态图片
func ImageByPostId(postId int) (list []models.ImageList, err error) {
	err = DB.Scopes(joinRel).Where("post_id = ?", postId).Scan(&list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//连接关系表
func joinRel(db *gorm.DB) *gorm.DB {
	return db.Model(&models.Image{}).Select("path, post_id").Joins("right join post_rel_image as r on image.id = r.image_id")
}
