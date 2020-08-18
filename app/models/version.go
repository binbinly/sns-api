package models

type AppVersion struct {
	ModelId

	VersionNumber string `json:"version_number"`
	VersionName   string `json:"version_name"`
	Desc          string `json:"desc"`
	DownloadUrl   string `json:"download_url"`
}
