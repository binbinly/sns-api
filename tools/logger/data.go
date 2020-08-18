package logger

import "github.com/sirupsen/logrus"

type LogData struct {
	message     string
	filename    string
	lineNo      int
	traceId     string
	serviceName string
	fields      logrus.Fields
}

func (l *LogData) toFields() logrus.Fields {
	f := map[string]interface{}{
		"name":     l.serviceName,
		"message":  l.message,
		"filename": l.filename,
		"line":     l.lineNo,
		"trace":    l.traceId,
	}
	for k, v := range l.fields {
		f[k] = v
	}
	return f
}
