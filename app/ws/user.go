package ws

import (
	"encoding/json"
	"sns-api/app/common"
	"sns-api/dal/redis"
)

type User struct {
	UserId   int    `json:"user_id"`
}

//验证用户token
func CheckToken(token string) (*User, error) {
	data, err := redis.Client.Get(common.UserTokenPrefix + token)
	if err != nil {
		return nil, err
	}
	var user = &User{}
	if err := json.Unmarshal([]byte(data), user); err != nil {
		return nil, err
	}
	return user, nil
}