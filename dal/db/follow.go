package db

import (
	"github.com/jinzhu/gorm"
	"sns-api/app/models"
	"sns-api/tools/logger"
)

//验证用户列表是否关注
func FollowCheckList(myId int, userIds []int) (list []int, err error) {
	err = DB.Model(&models.Follow{}).Where("user_id = ? && follow_id in (?)", myId, userIds).Pluck("follow_id", &list).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return list, nil
}

//是否关注
func IsFollow(myId, userId int) bool {
	if myId == userId {
		return true
	}
	var count = 0
	err := DB.Model(&models.Follow{}).Where("user_id = ? && follow_id = ?", myId, userId).Count(&count).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		logger.Error(err)
		return false
	}
	if count > 0 {
		return true
	}
	return false
}

//粉丝汇总
func FensCount(userId int) int {
	var c = 0
	err := DB.Model(&models.Follow{}).Where("follow_id = ?", userId).Count(&c).Error
	if err != nil {
		logger.Error(err)
		return 0
	}
	return c
}

//关注数
func FollowCount(userId int) int {
	var c = 0
	err := DB.Model(&models.Follow{}).Where("user_id = ?", userId).Count(&c).Error
	if err != nil {
		logger.Error(err)
		return 0
	}
	return c
}

//好友数
func FriendCount(userId int) int {
	var c = 0
	err := DB.Table(models.TableFollow).Joins("inner join user_follow as f on user_follow.user_id = f.follow_id").
		Where("user_follow.follow_id = f.user_id && user_follow.user_id = ?", userId).Count(&c).Error
	if err != nil {
		logger.Error(err)
		return 0
	}
	return c
}

//关注用户
func FollowUser(myId, userId int) bool {
	follow := &models.Follow{}
	err := DB.Model(&models.Follow{}).Where("user_id = ? && follow_id = ?", myId, userId).First(follow).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		logger.Error(err)
		return false
	}
	if follow.ID > 0 { //已关注，返回成功
		return true
	}
	follow.UserId = myId
	follow.FollowId = userId
	err = DB.Save(follow).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//取消关注
func UnFollowUser(myId, userId int) bool {
	err := DB.Where("user_id = ? && follow_id = ?", myId, userId).Delete(&models.Follow{}).Error
	if err != nil {
		logger.Error(err)
		return false
	}
	return true
}

//好友列表
func FriendList(userId int) (user []models.FollowUserInfo, err error) {
	err = DB.Scopes(fensJoinUser).Joins("inner join user_follow as f on user_follow.user_id = f.follow_id").
		Where("user_follow.follow_id = f.user_id && user_follow.user_id = ?", userId).Scan(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//关注列表
func FollowList(userId int) (user []models.FollowUserInfo, err error) {
	err = DB.Scopes(fensJoinUser).
		Where("user_follow.user_id = ?", userId).Scan(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

//粉丝列表
func FensList(userId int) (user []models.FollowUserInfo, err error) {
	err = DB.Scopes(followJoinUser).
		Where("user_follow.follow_id = ?", userId).Scan(&user).Error
	if err != nil && err != gorm.ErrRecordNotFound {
		return
	}
	return user, nil
}

func followJoinUser(db *gorm.DB) *gorm.DB {
	return db.Table(models.TableFollow).Select("`user`.username, `user`.nickname, `user`.avatar, `user`.id as user_id, p.gender, p.hometown, p.birthday").
		Joins("left join `user` on user_follow.user_id = `user`.id").
		Joins("left join user_profile as p on `user`.id = p.user_id")
}

func fensJoinUser(db *gorm.DB) *gorm.DB {
	return db.Table(models.TableFollow).Select("`user`.username, `user`.nickname, `user`.avatar, `user`.id as user_id, p.gender, p.hometown, p.birthday").
		Joins("left join `user` on user_follow.follow_id = `user`.id").
		Joins("left join user_profile as p on `user`.id = p.user_id")
}
