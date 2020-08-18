package logger

import "github.com/sirupsen/logrus"

const (
	LogLevelDebug LogLevel = iota
	LogLevelTrace
	LogLevelInfo
	LogLevelWarn
	LogLevelError
	LogLevelFatal
	LogLevelPanic
)

type LogLevel uint8

func getLevel(level LogLevel) logrus.Level {
	switch level {
	case LogLevelTrace:
		return logrus.TraceLevel
	case LogLevelDebug:
		return logrus.DebugLevel
	case LogLevelInfo:
		return logrus.InfoLevel
	case LogLevelWarn:
		return logrus.WarnLevel
	case LogLevelError:
		return logrus.ErrorLevel
	case LogLevelFatal:
		return logrus.FatalLevel
	case LogLevelPanic:
		return logrus.PanicLevel
	default:
		return logrus.DebugLevel
	}
}
