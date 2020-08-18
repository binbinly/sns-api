package middleware

import (
	"github.com/gin-gonic/gin"
	"sns-api/app"
	"sns-api/app/api/controller"
	"sns-api/app/api/middleware/auth"
	"sns-api/app/common"
)

//强制登录验证
func AuthCheck() gin.HandlerFunc {
	return func(c *gin.Context) {
		user := &app.User{}
		if !auth.Check(c) { //检测token是否存在
			appG := controller.Gin{C: c}
			appG.ResponseError(common.ErrorUserNotExist)
			return
		} else {
			user = auth.User(c)
			if user == nil {
				appG := controller.Gin{C: c}
				appG.ResponseError(common.ErrorUserNotExist)
				return
			}
		}
		c.Set("user_id", user.UserId)
		c.Next()
	}
}

//非强制登录验证
func AuthNoCheck() gin.HandlerFunc {
	return func(c *gin.Context) {
		user := &app.User{}
		if auth.Check(c) { //检测token是否存在
			user = auth.User(c)
			if user != nil {
				c.Set("user_id", user.UserId)
			}
		}
		c.Next()
	}
}