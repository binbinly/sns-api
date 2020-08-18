package logger

import (
	"context"
	"fmt"
	"github.com/getsentry/sentry-go"
	"github.com/go-sql-driver/mysql"
	"github.com/sirupsen/logrus"
	"os"
	"path"
	"path/filepath"
	"runtime"
	"sns-api/tools"
	"sns-api/tools/slack"
)

const (
	FilenameInfo   = "info.log"  // debug | trace | info
	FilenameError  = "error.log" // warn | error | fatal | panic
	FilenameAccess = "access.log"
)

var (
	log *logrus.Logger
	m   *Manager
)

type Manager struct {
	serviceName string   //服务名
	dir         string   //日志目录
	infoFile    *os.File //信息日志文件
	errorFile   *os.File //错误日志文件
	accessFile  *os.File //访问日志
	errChan     chan interface{}
	config      map[string]interface{}
}

func Setup(c map[string]interface{}, serviceName, dir string, level LogLevel) (err error) {
	m = &Manager{
		serviceName: serviceName,
		dir:         dir,
		errChan:     make(chan interface{}, 32),
		config:      c,
	}
	log = logrus.New()
	log.SetFormatter(&logrus.TextFormatter{
		TimestampFormat: tools.DateTimeFormatString,
	})
	//log.SetReportCaller(true)

	log.SetLevel(getLevel(level))

	err = initDir(dir)
	if err != nil {
		return
	}
	m.infoFile, err = initFile(FilenameInfo)
	if err != nil {
		return
	}
	m.errorFile, err = initFile(FilenameError)
	if err != nil {
		return
	}
	m.accessFile, err = initFile(FilenameAccess)
	if err != nil {
		return
	}
	go run()
	return
}

func Close() (err error) {
	err = m.infoFile.Close()
	err = m.errorFile.Close()
	return
}

func initDir(dir string) (err error) {
	dir, err = filepath.Abs(dir)
	if err != nil {
		return err
	}
	if !tools.IsFileExist(dir) {
		err = os.MkdirAll(dir, 0755)
		if err != nil {
			return err
		}
	}
	return
}

func initFile(filename string) (file *os.File, err error) {
	file, err = os.OpenFile(m.dir+"/"+filename, os.O_CREATE|os.O_APPEND|os.O_WRONLY, 0755)
	return
}

func Trace(format string, args ...interface{}) {
	writeLog(context.Background(), LogLevelTrace, format, args...)
}

func Debug(format string, args ...interface{}) {
	writeLog(context.Background(), LogLevelDebug, format, args...)
}

func Info(format string, args ...interface{}) {
	writeLog(context.Background(), LogLevelInfo, format, args...)
}

func Warn(err interface{}) {
	writeErrLog(context.Background(), LogLevelWarn, err, 2)
}

func Error(err interface{}) {
	writeErrLog(context.Background(), LogLevelError, err, 2)
}

//recover捕获异常
func ErrorR(err interface{}) {
	writeErrLog(context.Background(), LogLevelError, err, 3)
}

func Fatal(format string, args ...interface{}) {
	writeLog(context.Background(), LogLevelFatal, format, args...)
}

func Panic(format string, args ...interface{}) {
	writeLog(context.Background(), LogLevelPanic, format, args...)
}

//访问日志
func Access(data map[string]interface{}) {
	log.SetOutput(m.accessFile)
	log.WithFields(data).Log(logrus.InfoLevel)
}

func writeLog(ctx context.Context, level LogLevel, format string, args ...interface{}) {

	_, fileName, lineNo, _ := runtime.Caller(2)
	fileName = path.Base(fileName)
	msg := fmt.Sprintf(format, args...)

	logData := &LogData{
		message:     msg,
		filename:    fileName,
		lineNo:      lineNo,
		traceId:     GetTraceId(ctx),
		serviceName: m.serviceName,
	}
	log.SetOutput(m.infoFile)
	log.WithFields(logData.toFields()).Log(getLevel(level))
}

func writeErrLog(ctx context.Context, level LogLevel, err interface{}, skip int) {

	_, fileName, lineNo, _ := runtime.Caller(skip)
	fileName = path.Base(fileName)

	logData := &LogData{
		message:     getErrMsg(err),
		filename:    fileName,
		lineNo:      lineNo,
		traceId:     GetTraceId(ctx),
		serviceName: m.serviceName,
	}
	log.SetOutput(m.errorFile)
	log.WithFields(logData.toFields()).Log(getLevel(level))
	m.errChan <- err
}

func run() {
outer:
	for {
		select {
		case err, ok := <-m.errChan:
			if !ok {
				break outer
			}
			errorToSentry(err)
			errorToSlack(err)
		}
	}
}

func errorToSentry(err interface{}) {
	switch t := err.(type) {
	case string:
		sentry.CaptureMessage(t)
	case *mysql.MySQLError:
		sentry.CaptureMessage(t.Message)
	case error:
		sentry.CaptureException(t)
	}
}

func errorToSlack(err interface{}) {
	url, ok := m.config["slack_url"]
	if !ok {
		return
	}
	attachment1 := slack.Attachment{}
	attachment1.AddField(slack.Field{Title: "Env", Value: tools.GetEnv()})
	payload := slack.Payload{
		Text:        getErrMsg(err),
		Username:    "robot",
		Channel:     "#api",
		IconEmoji:   ":cupid:",
		Attachments: []slack.Attachment{attachment1},
	}
	slack.Send(url.(string), "", payload)
}

func getErrMsg(err interface{}) string {
	errMsg := ""
	switch m := err.(type) {
	case string:
		errMsg = m
	case *mysql.MySQLError:
		errMsg = m.Message
	case error:
		errMsg = m.Error()
	}
	return errMsg
}
