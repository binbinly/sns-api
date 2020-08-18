package logic

import (
	"sns-api/app/config"
	"sns-api/app/models"
)

//格式化图片url
func FormatImageUrl(list []models.Ads) (new []models.Ads) {
	new = make([]models.Ads, 0)
	host := config.C.Api.Host
	for _, v := range list {
		v.Image = host + v.Image
		new = append(new, v)
	}
	return
}