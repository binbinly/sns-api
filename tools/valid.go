package tools

import (
	"gopkg.in/go-playground/validator.v9"
	"regexp"
)

//手机号校验规则
var Mobile validator.Func = func(fl validator.FieldLevel) bool {
	param, ok := fl.Field().Interface().(string)
	if ok {
		regular := "^(((13[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0,3-8]{1})|(18[0-9]{1})|(19[0-9]{1})|(14[5-7]{1}))+\\d{8})$"

		reg := regexp.MustCompile(regular)
		return reg.MatchString(param)
	}
	return false
}

//包版本号校验规则
var VersionNum validator.Func = func(fl validator.FieldLevel) bool {
	param, ok := fl.Field().Interface().(string)
	if ok {
		regular := "^\\d+(.(\\d+))*$"

		reg := regexp.MustCompile(regular)
		return reg.MatchString(param)
	}
	return false
}
