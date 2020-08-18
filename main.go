package main

import (
	"context"
	"fmt"
	"github.com/getsentry/sentry-go"
	"github.com/gin-gonic/gin"
	"io"
	"net/http"
	"os"
	"os/signal"
	"sns-api/app/api"
	"sns-api/app/config"
	"sns-api/app/ws"
	"sns-api/dal/db"
	"sns-api/dal/redis"
	"sns-api/tools"
	"sns-api/tools/logger"
	"syscall"
	"time"
)

func init() {
	err := config.SetUp()
	if err != nil {
		fmt.Printf("config setup err:%v\n", err)
		panic(err)
	}
	err = db.Setup()
	if err != nil {
		fmt.Printf("db setup err:%v\n", err)
		panic(err)
	}
	redis.Setup()
	err = logger.Setup(map[string]interface{}{
		"slack_url":config.C.Slack.HookUrl,
	}, config.C.Api.AppName, config.C.Log.Dir, logger.LogLevel(config.C.Log.Level))
	if err != nil {
		fmt.Printf("log setup err:%v\n", err)
		panic(err)
	}
	if err := sentry.Init(sentry.ClientOptions{
		Dsn: config.C.Sentry.Dsn,
	}); err != nil {
		logger.Panic("sentry init err:%v", err)
	}
}

func main() {
	gin.SetMode(config.C.Api.RunMode)

	//日志
	if tools.IsDev() {
		gin.DefaultWriter = io.MultiWriter(os.Stdout)
	} else {
		// 创建记录日志的文件
		f, err := os.Create(tools.GetRootDir() + "/logs/gin.log")
		if err != nil {
			logger.Panic("gin log file create fatal:%v", err)
		}
		gin.DefaultWriter = io.MultiWriter(f)
	}

	s := &http.Server{
		Addr:           fmt.Sprintf(":%d", config.C.Api.Port),
		Handler:        api.InitRouter(),
		ReadTimeout:    30 * time.Second,
		WriteTimeout:   30 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	go func() {
		if err := s.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			logger.Panic("http server start fatal:%v", err)
		}
	}()
	go func() {
		http.HandleFunc("/ws", ws.ServeWs)
		err := http.ListenAndServe(fmt.Sprintf(":%d", config.C.Ws.Port), nil)
		if err != nil && err != http.ErrServerClosed {
			logger.Panic("ListenAndServe to ws: ", err)
		}
	}()

	// Wait for interrupt signal to gracefully shutdown the server with
	// a timeout of 5 seconds.
	quit := make(chan os.Signal)
	// kill (no param) default send syscall.SIGTERM
	// kill -2 is syscall.SIGINT
	// kill -9 is syscall.SIGKILL but can't be catch, so don't need add it
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	fmt.Println("Shutdown Server ...")

	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel()
	if err := s.Shutdown(ctx); err != nil {
		fmt.Println("Server Https Shutdown:", err)
	}
	shutdown()
	// catching ctx.Done(). timeout of 2 seconds.
	select {
	case <-ctx.Done():
		fmt.Println("timeout of 2 seconds.")
	}
	fmt.Println("Server exiting success!!!")
}

func shutdown() {
	err := db.CloseDB()
	if err != nil {
		logger.Panic("db close err:%v", err)
	}
	err = redis.Close()
	if err != nil {
		logger.Panic("redis close err:%v", err)
	}
	sentry.Flush(time.Second)
}
