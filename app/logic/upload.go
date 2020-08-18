package logic

import (
	"bytes"
	"crypto/md5"
	"encoding/hex"
	"errors"
	"fmt"
	"github.com/disintegration/imaging"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"image"
	"io"
	"io/ioutil"
	"mime/multipart"
	"os"
	"path/filepath"
	"sns-api/app/api/proto"
	"sns-api/app/config"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools"
	"strings"
	"time"
)

const (
	ImageMaxSize = 4 << 20  //最大上传4MB
	ThumbSubDir  = "thumb/" //缩略图子目录
	ThumbBigTag  = "_big"   //大图标签
)

//保存图片
func SaveImage(file *multipart.FileHeader, c *gin.Context, userId int, newFilename string , t int) (id int, newFilepath string, err error) {
	filename := filepath.Base(file.Filename)
	uploadDir := getUploadDir()
	if uploadDir == "" {
		return 0, "", errors.New("目录错误")
	}
	if file.Size > ImageMaxSize {
		return 0, "", errors.New("单图片最大1MB")
	}
	mimeType := imageType(file)
	if mimeType == "" {
		return 0, "", errors.New("请上传图片")
	}
	ext := getFileExt(filename)
	newFilepath = uploadDir + newFilename + ext
	if err := c.SaveUploadedFile(file, tools.GetRootDir()+newFilepath); err != nil {
		logrus.Error("upload file err:", err)
		return 0, "", errors.New("上传失败了")
	}
	err = thumb(newFilepath, uploadDir, newFilename, ext, t)
	if err != nil {
		logrus.Error("image thumb err:", err)
		return 0, "", errors.New("上传异常")
	}
	id = db.AddImage(userId, t, file.Size, filename, mimeType, newFilename, newFilepath)
	return id, newFilepath, nil
}

//获取文件md5值
func GetFileMd5(file *multipart.FileHeader) string {
	read, err := file.Open()
	if err != nil {
		logrus.Error("Create File Md5 By Open Err: ", err)
		return ""
	}
	hash := md5.New()
	_, err = io.Copy(hash, read)
	if err != nil {
		logrus.Error("Create File Md5 Err: ", err)
		return ""
	}
	return hex.EncodeToString(hash.Sum(nil))
}

//获取图片信息
func GetThumbInfo(path string) *proto.ImageInfo {
	index := strings.LastIndex(path, "/")
	dir := path[:index]
	filename := path[index+1:]
	extIndex := strings.LastIndex(filename, ".")

	host := config.C.Api.Host
	return &proto.ImageInfo{
		Thumb:  host + dir + "/" + ThumbSubDir + filename,
		Big:    host + dir + "/" + ThumbSubDir + filename[:extIndex] + ThumbBigTag + filename[extIndex:],
		Source: host + path,
	}
}

//获取缩略图
func GetThumbPath(path string) string {
	index := strings.LastIndex(path, "/")
	dir := path[:index]
	filename := path[index+1:]

	host := config.C.Api.Host
	return host + dir + "/" + ThumbSubDir + filename
}

//获取图片类型
func imageType(file *multipart.FileHeader) string {
	f, err := file.Open()
	if err != nil {
		return ""
	}
	src, err := ioutil.ReadAll(f)
	if err != nil {
		return ""
	}
	reader := bytes.NewReader(src)
	_, imgType, err := image.Decode(reader)
	if err != nil {
		return ""
	}
	return imgType
}

//生成缩略图
func thumb(newFilepath, uploadDir, newFilename, ext string, t int) error {
	src, err := imaging.Open(tools.GetRootDir() + newFilepath)
	if err != nil {
		return err
	}
	thumbDir := uploadDir + ThumbSubDir
	dstImageFill := imaging.Fit(src, 200, 200, imaging.Lanczos)
	err = imaging.Save(dstImageFill, tools.GetRootDir()+thumbDir+newFilename+ext)

	if t == models.TypeUploadImage {
		dstImageFit := imaging.Fit(src, 750, 750, imaging.Lanczos)
		err = imaging.Save(dstImageFit, tools.GetRootDir()+thumbDir+newFilename+"_big"+ext)
	}
	return err
}

//获取文件后缀名
func getFileExt(filename string) string {
	index := strings.LastIndex(filename, ".")
	//comma的意思是从字符串tracer查找第一个逗号，然后返回他的位置，这里的每个中文是占3个字符，从0开始计算，那么逗号的位置就是12
	return filename[index:]
}

//获取文件上传目录
func getUploadDir() string {
	subDir := fmt.Sprintf("%d%d/%d/", time.Now().Year(), time.Now().Month(), time.Now().Day())
	dirPath := "uploads/" + subDir
	dir := filepath.Dir(dirPath + ThumbSubDir)
	_, err := os.Stat(dir)
	if os.IsNotExist(err) {
		err = os.MkdirAll(dir, os.ModePerm)
	}
	if err != nil {
		logrus.Error("Create Upload Dir Err: ", err)
		return ""
	}
	return dirPath
}