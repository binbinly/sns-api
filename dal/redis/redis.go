package redis

import (
	"github.com/go-redis/redis"
	"sns-api/app/config"
	"time"
)

const success = 1

type Manager struct {
	Conn *redis.Client
}

var Client Manager

func Setup() {
	Client.Conn = redis.NewClient(&redis.Options{
		Addr:         config.C.Redis.Host,
		Password:     config.C.Redis.Auth,
		DB:           config.C.Redis.Db,
		PoolSize:     config.C.Redis.PoolSize,
		MinIdleConns: config.C.Redis.MinConn,
	})
}

func Close() error {
	return Client.Conn.Close()
}

func (client *Manager) Set(key string, value interface{}, expiration time.Duration) bool {
	err := client.Conn.Set(key, value, expiration).Err()
	if err != nil {
		return false
	}
	return true
}

func (client *Manager) Incr(key string) (res int64, err error) {
	res, err = client.Conn.Incr(key).Result()
	return
}

func (client *Manager) Pipeline() redis.Pipeliner {
	return client.Conn.Pipeline()
}

func (client *Manager) Decr(key string) (res int64, err error) {
	res, err = client.Conn.Decr(key).Result()
	return
}

func (client *Manager) DecrBy(key string, de int64) (res int64, err error) {
	res, err = client.Conn.DecrBy(key, de).Result()
	return
}

func (client *Manager) Expire(key string, expiration time.Duration) bool {
	res, err := client.Conn.Expire(key, expiration).Result()
	if err != nil {
		return false
	}
	return res
}

func (client *Manager) Get(key string) (string, error) {
	res, err := client.Conn.Get(key).Result()
	if err == redis.Nil {
		return "", nil
	}
	if err != nil {
		return "", err
	}
	return res, nil
}

func (client *Manager) IsExist(key string) bool {
	exist, err := client.Conn.Exists(key).Result()
	if err != nil {
		return false
	}
	return exist == success
}

func (client *Manager) LPop(key string) (string, error) {
	res, err := client.Conn.LPop(key).Result()
	if err == redis.Nil {
		return "", nil
	}
	if err != nil {
		return "", err
	}
	return res, nil
}

func (client *Manager) LPush(key string, values ...interface{}) bool {
	_, err := client.Conn.LPush(key, values...).Result()
	return err == nil
}

func (client *Manager) LRange(key string, start, stop int64) ([]string, error) {
	res, err := client.Conn.LRange(key, start, stop).Result()

	if err != nil {
		return nil, err
	}

	return res, nil
}

func (client *Manager) Del(key ...string) bool {
	res, err := client.Conn.Del(key...).Result()
	if err != nil {
		return false
	}
	return res == success
}

func (client *Manager) SetIfNotExist(key string, value interface{}, expiration time.Duration) bool {
	result, err := client.Conn.SetNX(key, value, expiration).Result()
	if err != nil {
		return false
	}
	return result
}

func (client *Manager) PSubscribe(channels ...string) *redis.PubSub {
	ps := client.Conn.PSubscribe(channels...)
	return ps
}
