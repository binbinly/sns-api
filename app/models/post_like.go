package models

const(
	TypeLike = 1	//赞
	TypeUnlike = 2	//踩
)

type PostLike struct {
	ModelId

	UserId int
	PostId int
	Type   int
}
