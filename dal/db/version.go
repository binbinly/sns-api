package db

import (
	"encoding/json"
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/dal/redis"
)

const cacheKey  =  "app_version_info"

//获取最新版本
func Newest() (version *models.AppVersion, err error) {
	version = &models.AppVersion{}
	if !redis.Client.IsExist(cacheKey) { //不存在，从数据库中获取
		err = DB.Model(&models.AppVersion{}).Where("is_release = ?", ReleaseYes).
			Select("version_number, version_name, download_url, `desc`").Last(version).Error
		if err != nil && err != gorm.ErrRecordNotFound{
			return
		}
		str, err := json.Marshal(version)
		if err != nil {
			return nil, err
		} else {
			//加入缓存
			redis.Client.Set(cacheKey, str, CacheTime)
		}
	} else {
		str, err := redis.Client.Get(cacheKey)
		if err != nil {
			redis.Client.Del(cacheKey)
			return nil, err
		}
		err = json.Unmarshal([]byte(str), &version)
		if err != nil {
			redis.Client.Del(cacheKey)
			return nil, err
		}
	}
	return version, nil
}
