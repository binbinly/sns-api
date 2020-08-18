package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//创建一个用户
func CreateUser(username, password, phone string) bool {
	var user = &models.User{
		Username: username,
		Password: password,
		Phone:    phone,
	}
	err := DB.Model(&models.User{}).Create(user).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//通过手机获取信息
func UserByPhone(phone string) (user *models.User, err error) {
	user = &models.User{}
	err = DB.Model(&models.User{}).Where("phone = ? ", phone).First(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//通过用户名获取信息
func UserByName(username string) (user *models.User, err error) {
	user = &models.User{}
	err = DB.Model(&models.User{}).Where("username = ? ", username).First(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//用户信息
func UserInfo(userId int) (user *models.UserInfo, err error) {
	user = &models.UserInfo{}
	err = DB.Model(&models.UserInfo{}).Select("user.avatar, user.nickname, user.username, p.*").
		Joins("left join user_profile as p on user.id=p.user_id").
		Where("user.id = ?", userId).First(user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//用户列表
func UserList(q string) (user []models.FollowUserInfo, err error) {
	err = DB.Scopes(userJoinProfile, whereUserQ(q)).Scan(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//修改手机号
func EditPhone(userId int, phone string) bool {
	user := &models.User{}
	err := DB.Model(&models.User{}).Where("id = ?", userId).Find(&user).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	user.Phone = phone
	err = DB.Save(user).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//搜索
func whereUserQ(q string) func(db *gorm.DB) *gorm.DB {
	return func(db *gorm.DB) *gorm.DB {
		if q != "" {
			return db.Where("username LIKE ? or nickname like ?", "%"+q+"%", "%"+q+"%")
		}
		return db
	}
}

func userJoinProfile(db *gorm.DB) *gorm.DB {
	return db.Table("user").Select("`user`.username, `user`.nickname, `user`.avatar, `user`.id, p.gender, p.hometown, p.birthday").
		Joins("left join user_profile as p on `user`.id = p.user_id")
}