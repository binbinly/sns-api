package common

const (
	SUCCESS uint16 = 200
	ERROR   uint16 = 500

	ErrorUserNotExist      uint16 = 203
	ErrorUserFreeze        uint16 = 204
	ErrorVerifyCode        uint16 = 205
	ErrorLoginNameNot      uint16 = 206
	ErrorLoginPassword     uint16 = 207
	ErrorRegisterNameExist uint16 = 208

	ErrorRequestParams      uint16 = 400
	ErrorRequestParamsCheck uint16 = 401
	ErrorDataNotFound       uint16 = 404
	ErrorServer             uint16 = 501
	ErrorServerTimeout      uint16 = 502
	ErrorServiceError       uint16 = 505
	ErrorDBError            uint16 = 506

	ErrorNotNewVersion uint16 = 1000
)

var MsgFlags = map[uint16]string{
	SUCCESS: "操作成功",
	ERROR:   "操作失败",

	ErrorUserNotExist:      "请重新登录",
	ErrorUserFreeze:        "账号已被冻结，请联系客服",
	ErrorVerifyCode:        "验证码错误",
	ErrorLoginNameNot:      "用户不存在",
	ErrorLoginPassword:     "密码错误",
	ErrorRegisterNameExist: "用户已存在",

	ErrorRequestParams:      "请求参数不存在",
	ErrorRequestParamsCheck: "请求参数不合法",
	ErrorDataNotFound:       "信息不存在哦",
	ErrorServer:             "服务器错误",
	ErrorServerTimeout:      "服务器超时，清稍后再试",
	ErrorServiceError:       "服务器异常",
	ErrorDBError:            "数据异常",

	ErrorNotNewVersion: "已经是最新版本了哦",
}

func GetMsg(code uint16, customMsg string) string {
	if customMsg != "" {
		return customMsg
	}
	if msg, ok := MsgFlags[code]; ok {
		return msg
	}
	return "未知错误"
}
