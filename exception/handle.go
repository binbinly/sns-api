package exception

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"net/http"
	"sns-api/app/common"
	"sns-api/tools/logger"
)

func HandleErrors() gin.HandlerFunc {
	return func(c *gin.Context) {
		defer func() {
			if err := recover(); err != nil {
				logger.ErrorR(fmt.Errorf("gin:%v", err))

				c.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{
					"code": common.ErrorServer,
					"msg":  common.MsgFlags[common.ErrorServer],
				})
			}
		}()
		c.Next()
	}
}
