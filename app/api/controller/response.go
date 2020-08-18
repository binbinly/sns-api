package controller

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"sns-api/app/common"
)

type Gin struct {
	C *gin.Context
}

type Response struct {
	Code uint16      `json:"code"`
	Msg  string      `json:"msg"`
	Data interface{} `json:"data"`
}

func NewResponse(c *gin.Context) *Gin {
	return &Gin{C:c}
}

func (g *Gin) ResponseSuccessMsg(customMsg string) {
	g.response(common.SUCCESS, customMsg, nil)
}

func (g *Gin) ResponseSuccess(data interface{}) {
	g.response(common.SUCCESS, "", data)
}

func (g *Gin) ResponseSuccessNil() {
	g.response(common.SUCCESS, "", nil)
}

func (g *Gin) ResponseError(errCode uint16) {
	g.response(errCode, "", nil)
}

func (g *Gin) ResponseErrorData(errCode uint16, data interface{}) {
	g.response(errCode, "", data)
}

func (g *Gin) ResponseErrorMsg(customMsg string) {
	g.response(common.ERROR, customMsg, nil)
}

func (g *Gin) ResponseErrorMsgData(customMsg string, data interface{}) {
	g.response(common.ERROR, customMsg, data)
}

func (g *Gin) ResponseErrorNil() {
	g.response(common.ERROR, "", nil)
}

func (g *Gin) response(code uint16, customMsg string, data interface{}) {
	if data == nil {
		data = make(map[string]string)
	}
	g.C.AbortWithStatusJSON(http.StatusOK, Response{
		Code: code,
		Msg:  common.GetMsg(code, customMsg),
		Data: data,
	})
}
