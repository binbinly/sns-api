package logger

import (
	"context"
	"testing"
)

func TestLog(t *testing.T) {
	err := Init("Gin", "logs/info.log", LogLevelInfo)
	if err != nil {
		t.Logf("err:%v", err)
	}
	Info(context.Background(), "this test %v", "123")
}
