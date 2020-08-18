package auth

import (
	"encoding/json"
	"fmt"
	"github.com/gin-gonic/gin"
	"sns-api/app"
	"sns-api/app/common"
	"sns-api/dal/redis"
	"sns-api/tools"
	"sns-api/tools/logger"
	"strings"
	"time"
)

const (
	authToken = "auth_token"
)

func Check(c *gin.Context) bool {
	token := strings.TrimSpace(strings.Replace(c.Request.Header.Get("Authorization"), "Bearer ", "", -1))
	if token == "" {
		return false
	}
	c.Set(authToken, token)
	if !redis.Client.IsExist(common.UserTokenPrefix + token) { //不存在
		return false
	}
	return true
}

func User(c *gin.Context) *app.User {
	token := c.GetString(authToken)
	data, err := redis.Client.Get(common.UserTokenPrefix + token)
	if token == "" {
		return nil
	}
	if err != nil {
		logger.Warn(err)
		return nil
	}
	var user app.User
	if err := json.Unmarshal([]byte(data), &user); err != nil {
		logger.Warn(err)
	}
	return &user
}

func Login(user *app.User) string {
	userJson, err := json.Marshal(user)
	if err != nil {
		logger.Warn(err)
		return ""
	}
	token := tools.EncodeMD5(fmt.Sprintf("%v%v", time.Now().UnixNano(), userJson))
	//token有效期7天
	redis.Client.Set(common.UserTokenPrefix + token, userJson, time.Hour * 24 * 7)
	return token
}

func Logout(c *gin.Context) error {
	token := c.GetString(authToken)
	exist := redis.Client.IsExist(common.UserTokenPrefix + token)
	if !exist {
		return nil
	}
	redis.Client.Del(common.UserTokenPrefix + token)
	return nil
}
