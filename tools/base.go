/**
 * Created by lock
 * Date: 2019-08-18
 * Time: 18:03
 */
package tools

import (
	"crypto/md5"
	"crypto/rand"
	"crypto/sha1"
	"encoding/base64"
	"encoding/hex"
	"github.com/bwmarrin/snowflake"
	"io"
	"os"
	"path/filepath"
)

const SessionPrefix = "sess_"

//获取雪花算法ID
func GenSnowflakeId() string {
	//default node id eq 1,this can modify to different serverId node
	node, _ := snowflake.NewNode(1)
	// Generate a snowflake ID.
	id := node.Generate().String()
	return id
}

//生成字符串token
func GenRandomToken(length int) (string, error) {
	r := make([]byte, length)
	if _, err := io.ReadFull(rand.Reader, r); err != nil {
		return "", err
	}
	return base64.URLEncoding.EncodeToString(r), nil
}

//sha1加密
func EncodeSha1(s string) (str string) {
	h := sha1.New()
	h.Write([]byte(s))
	return hex.EncodeToString(h.Sum(nil))
}

//md5加密
func EncodeMD5(value string) string {
	m := md5.New()
	m.Write([]byte(value))

	return hex.EncodeToString(m.Sum(nil))
}

//运行根目录
func GetRootDir() (rootPath string) {
	exePath := os.Args[0]
	rootPath = filepath.Dir(exePath)
	return rootPath
}
