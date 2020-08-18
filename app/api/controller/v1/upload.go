package v1

import (
	"errors"
	"github.com/gin-gonic/gin"
	"mime/multipart"
	"sns-api/app/api/controller"
	"sns-api/app/api/proto"
	"sns-api/app/common"
	"sns-api/app/logic"
	"sns-api/app/models"
	"sns-api/dal/db"
	"sns-api/tools/logger"
)

func UploadImage(c *gin.Context) {
	r := controller.NewResponse(c)
	var images []*proto.ImageInfo
	var err error
	var form *multipart.Form

	form, err = c.MultipartForm()
	if err != nil {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	files := form.File["files[]"]

	for _, file := range files {
		newFilename := logic.GetFileMd5(file)
		if newFilename == "" {
			err = errors.New("文件非法")
			continue
		}
		image, err := db.ImageCheckExist(newFilename)
		if err != nil {
			logger.Error(err)
			err = errors.New("验证出错")
			continue
		}
		if image.ID > 0 {
			imageData := logic.GetThumbInfo(image.Path)
			imageData.Id = image.ID
			images = append(images, imageData)
			continue
		}
		//保存图片
		id, newFilepath, err := logic.SaveImage(file, c, GetUserId(c), newFilename, models.TypeUploadImage)
		if err != nil {
			continue
		}
		imageData := logic.GetThumbInfo(newFilepath)
		imageData.Id = id
		images = append(images, imageData)
	}
	if err != nil {
		r.ResponseErrorMsgData(err.Error(), images)
	} else {
		r.ResponseSuccess(images)
	}
}

func UploadAvatar(c *gin.Context) {
	r := controller.NewResponse(c)
	avatar, err := c.FormFile("avatar")
	if err != nil {
		r.ResponseError(common.ErrorRequestParams)
		return
	}
	newFilename := logic.GetFileMd5(avatar)
	if newFilename == "" {
		r.ResponseError(common.ErrorRequestParamsCheck)
		return
	}
	image, err := db.ImageCheckExist(newFilename)
	if err != nil {
		r.ResponseError(common.ErrorDBError)
		return
	}
	var path = ""
	if image.ID > 0 {
		path = logic.GetThumbPath(image.Path)
	} else {
		//保存图片
		_, newFilepath, err := logic.SaveImage(avatar, c, GetUserId(c), newFilename, models.TypeUploadAvatar)
		if err != nil {
			r.ResponseErrorMsg(err.Error())
			return
		}
		path = logic.GetThumbPath(newFilepath)
	}
	r.ResponseSuccess(path)
}