package ssl

import (
	"encoding/json"
	"fmt"
	"time"

	"github.com/dgrijalva/jwt-go"
)

const Expire = time.Hour * 2 //有效期两小时

// Claims custom token
type Claims struct {
	Data json.RawMessage `json:"data,omitempty"`
	jwt.StandardClaims
}

func NewJwt(data json.RawMessage) *Jwt {
	return &Jwt{
		C: &Claims{
			Data: data,
		},
		secret: "",
		expire: Expire,
	}
}

type Jwt struct {
	C      *Claims
	secret string
	expire time.Duration
}

func (j *Jwt) SetSecret(secret string) {
	j.secret = secret
}

// CreateToken create token
func (j *Jwt) Enable() (signedToken string, err error) {
	j.C.ExpiresAt = time.Now().Add(Expire).Unix()
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, j.C)
	signedToken, err = token.SignedString([]byte(j.secret))
	return
}

// ValidateToken validate token
func (j *Jwt) Disable(signedToken string) (claims *Claims, success bool) {
	token, err := jwt.ParseWithClaims(signedToken, &Claims{},
		func(token *jwt.Token) (interface{}, error) {
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("unexpected login method %v", token.Header["alg"])
			}
			return []byte(j.secret), nil
		})
	if err != nil {
		return
	}
	claims, ok := token.Claims.(*Claims)
	if ok && token.Valid {
		success = true
		return
	}
	return
}
