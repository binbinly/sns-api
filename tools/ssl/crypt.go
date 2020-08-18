package ssl

import "golang.org/x/crypto/bcrypt"

//GeneratePassword 给密码进行加密操作
func GeneratePassword(userPassword string) string {
	password, err := bcrypt.GenerateFromPassword([]byte(userPassword), bcrypt.DefaultCost)
	if err != nil {
		panic(err)
	}
	return string(password)
}

//ValidatePassword 密码比对
func ValidatePassword(userPassword string, hashed string) bool {
	if err := bcrypt.CompareHashAndPassword([]byte(hashed), []byte(userPassword)); err != nil {
		return false
	}
	return true
}
