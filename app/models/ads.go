package models

const (
	AdsPostBanner = 1 //动态页banner广告位
	AdsMyBanner   = 2 //我的banner广告位
)

type Ads struct {
	ModelId

	Title string `json:"title"`
	Url   string `json:"url"`
	Image string `json:"image"`
}
