package tools

import "time"

const (
	DateTimeFormatString    = "2006-01-02 15:04:05"
	DateTimeFormatStringSec = "2006-01-02 15:04"
	DateFormatString        = "2006-01-02"
)

//格式化当前时间
func DateFormat(layout string) string {
	return time.Now().Format(layout)
}

//格式化指定时间
func DateUnixFormat(ux int64, layout string) string {
	return time.Unix(ux, 0).Format(layout)
}

//时间字符串转化为时间戳 类型是int64
func FormatToTime(dateTime string) (int64, error) {
	loc, err := time.LoadLocation("Local") //获取时区
	if err != nil {
		return 0, err
	}
	tmp, err := time.ParseInLocation(DateTimeFormatString, dateTime, loc)
	if err != nil {
		return 0, err
	}
	return tmp.Unix(), nil
}
