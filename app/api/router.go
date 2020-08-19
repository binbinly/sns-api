package api

import (
	"github.com/gin-contrib/pprof"
	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"gopkg.in/go-playground/validator.v9"
	"net/http"
	"path/filepath"
	"sns-api/app/api/controller/v1"
	"sns-api/app/api/controller/v1/post"
	"sns-api/app/api/controller/v1/user"
	"sns-api/app/api/middleware"
	"sns-api/exception"
	"sns-api/tools"
)

func InitRouter() *gin.Engine {
	router := gin.New()
	dir, err := filepath.Abs("uploads")
	if err != nil {
		panic(err)
	}
	router.StaticFS("/uploads", http.Dir(dir))

	if tools.IsDev() {
		pprof.Register(router) // 性能分析工具
	}
	router.MaxMultipartMemory = 8 << 20 // 8 MiB

	router.Use(gin.Logger())
	router.Use(middleware.Cors())        //跨域
	router.Use(exception.HandleErrors()) // 错误处理

	router.NoRoute(func(c *gin.Context) {
		c.JSON(http.StatusNotFound, gin.H{
			"code": 404,
			"msg":  "找不到该路由",
		})
	})

	router.NoMethod(func(c *gin.Context) {
		c.JSON(http.StatusNotFound, gin.H{
			"code": 404,
			"msg":  "找不到该操作",
		})
	})

	registerValidate()
	registerApiRouter(router)

	return router
}

//注册自定义验证器
func registerValidate() {
	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		_ = v.RegisterValidation("mobile", tools.Mobile)
	}
	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		_ = v.RegisterValidation("v_num", tools.VersionNum)
	}
}

func registerApiRouter(router *gin.Engine) {
	api := router.Group("/v1")

	notAuth(api)
	authCheck(api)
	authNoCheck(api)
}

//不需要登录验证
func notAuth(api *gin.RouterGroup) {
	api.POST("/upgrade", v1.VersionUpgrade)
	api.POST("/register", user.Register)
	api.POST("/login", user.LoginByPassword)
	api.GET("/cat", post.Cat)
	api.GET("/ads", v1.AdsList)
	api.POST("/send_code", v1.SendCode)

	topicUser := api.Group("/topic")
	topicUser.GET("/newest", v1.TopicByTime)
	topicUser.GET("/list", v1.Topic)
	topicUser.GET("/detail", v1.TopicDetail)
}

//强制登录
func authCheck(api *gin.RouterGroup) {
	apiPost := api.Group("/post")
	apiPost.Use(middleware.AuthCheck())
	{
		apiPost.POST("/create", post.Create)
		apiPost.POST("/comment", post.CreateComment)
		apiPost.GET("/follow", post.FollowList)
		apiPost.GET("/my", post.MyList)
	}

	apiUser := api.Group("/user")
	apiUser.Use(middleware.AuthCheck())
	{
		apiUser.POST("/follow", user.Follow)
		apiUser.POST("/unfollow", user.UnFollow)
		apiUser.POST("/like", user.Like)
		apiUser.GET("/profile", user.ProfileInfo)
		apiUser.POST("/profile_save", user.ProfileSave)
		apiUser.GET("/my", user.MyInfo)
		apiUser.GET("/space", user.Space)
		apiUser.GET("/friend", user.FriendList)
		apiUser.GET("/follow", user.FollowList)
		apiUser.GET("/fens", user.FensList)
		apiUser.GET("/count", user.Count)
		apiUser.POST("/bind_phone", user.BindPhone)
		apiUser.POST("/add_black", user.AddBlack)
		apiUser.POST("/remove_black", user.RemoveBlack)
		apiUser.POST("/feedback", user.Feedback)
	}

	upload := api.Group("/upload")
	upload.Use(middleware.AuthCheck())
	{
		upload.POST("/image", v1.UploadImage)
		upload.POST("/avatar", v1.UploadAvatar)
	}
}

//校验用户信息
func authNoCheck(api *gin.RouterGroup) {
	notAuth := api.Group("/")
	notAuth.Use(middleware.AuthNoCheck())
	{
		notAuth.GET("post_list", post.List)
		notAuth.GET("topic/post_list", post.ListByTopic)
		notAuth.GET("post_detail", post.Detail)
		notAuth.GET("comment_list", post.CommentList)
		notAuth.POST("search", v1.Search)
	}
}
