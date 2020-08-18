package config

import (
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"sns-api/tools"
)

var C *Config

func SetUp() error {
	var confPath string
	if tools.IsDev() {
		confPath = "./conf/dev.yaml"
	} else {
		confPath = tools.GetRootDir() + "/" + "conf/" + tools.GetEnv() + ".yaml"
	}
	data, err := ioutil.ReadFile(confPath)
	if err != nil {
		return err
	}

	C = &Config{}
	err = yaml.Unmarshal(data, C)
	if err != nil {
		return err
	}
	return nil
}

type Config struct {
	Api    ApiConfig    `yaml:"api"`
	Ws     WsConfig     `yaml:"ws"`
	Mysql  MysqlConfig  `yaml:"mysql"`
	Redis  RedisConfig  `yaml:"redis"`
	Log    LogConfig    `yaml:"log"`
	Sentry SentryConfig `yaml:"sentry"`
	Slack  SlackConfig  `yaml:"slack"`
}

//api配置
type ApiConfig struct {
	Port    int    `yaml:"port"`
	AppName string `yaml:"app_name"`
	RunMode string `yaml:"run_mode"`
	Host    string `yaml:"host"`
}

//第三方接口服务配置
type WsConfig struct {
	Port int `yaml:"port"`
}

type MysqlConfig struct {
	IdleConn int    `yaml:"idle_conn"`
	MaxConn  int    `yaml:"max_conn"`
	Host     string `yaml:"host"`
	User     string `yaml:"user"`
	Pwd      string `yaml:"pwd"`
	Db       string `yaml:"db"`
	Prefix   string `yaml:"prefix"`
}

type RedisConfig struct {
	Db       int    `yaml:"db"`
	PoolSize int    `yaml:"pool_size"`
	MinConn  int    `yaml:"min_conn"`
	Host     string `yaml:"host"`
	Auth     string `yaml:"auth"`
}

type LogConfig struct {
	Console bool   `yaml:"console"` //是否打印到控制台
	Level   uint8  `yaml:"level"`
	Dir     string `yaml:"dir"`
}

type SentryConfig struct {
	Enable bool   `yaml:"enable"`
	Dsn    string `yaml:"dsn"`
}

type SlackConfig struct {
	Enable  bool   `yaml:"enable"`
	HookUrl string `yaml:"hook_url"`
}
