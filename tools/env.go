package tools

import (
	"os"
	"strings"
)

const (
	Env        = "API_SNS_ENV"
	EnvDev     = "dev"
	EnvTest    = "test"
	EnvProduct = "product"
)

var CurEnv = EnvDev

func init() {
	CurEnv = strings.ToLower(os.Getenv(Env))
	CurEnv = strings.TrimSpace(CurEnv)

	if len(CurEnv) == 0 {
		CurEnv = EnvDev
	}
}

func IsProduct() bool {
	return CurEnv == EnvProduct
}

func IsTest() bool {
	return CurEnv == EnvTest
}

func IsDev() bool {
	return CurEnv == EnvDev
}

func GetEnv() string {
	return CurEnv
}
