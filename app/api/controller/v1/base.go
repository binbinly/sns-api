package v1

import (
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"github.com/unknwon/com"
	"strconv"
	"strings"
)

const (
	PageSize  = 10
	SmsCodeKey = "sms_code:"
)

//获取登录用户ID
func GetUserId(c *gin.Context) int {
	return c.GetInt("user_id")
}

//用户get参数值
func GetQueryIntKey(c *gin.Context, key string) int {
	return com.StrTo(c.Query(key)).MustInt()
}

//获取分页起始偏移量
func GetPageOffset(c *gin.Context) int {
	offset := 0
	page := com.StrTo(c.Query("p")).MustInt()
	if page > 0 {
		offset = (page - 1) * PageSize
	}

	return offset
}

//绑定请求参数
func BindJsonValid(c *gin.Context, form interface{}) bool {
	if err := c.ShouldBindJSON(form); err != nil {
		logrus.Debug("form json bind err:", err.Error())
		return false
	}
	return true
}

/**
版本号比较
return 0 异常
return -1 已经是最新版本
return 1 可以更新
*/
func versionCompare(curStr, newStr string) int8 {
	curStr = strings.TrimSpace(strings.Replace(curStr, ".", "", -1))
	newStr = strings.TrimSpace(strings.Replace(newStr, ".", "", -1))
	diff := len(curStr) - len(newStr) //版本号长度差
	if diff > 0 {
		newStr += strings.Repeat("0", diff)
	} else if diff < 0 {
		curStr += strings.Repeat("0", -diff)
	}
	cur, err := strconv.Atoi(curStr)
	if err != nil {
		return 0
	}
	news, err := strconv.Atoi(newStr)
	if err != nil {
		return 0
	}
	if cur >= news {
		return -1
	} else {
		return 1
	}
}