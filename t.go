package main

import (
	"fmt"
	"path/filepath"
)

func init() {
	fmt.Println("init")
}

func main()  {
	s , err:= filepath.Abs("t.go")
	if err != nil {
		fmt.Printf("err:%v", err)
	}
	fmt.Printf("s:%v", s)
}
