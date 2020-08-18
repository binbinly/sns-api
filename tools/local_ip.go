package tools

import (
	"fmt"
	"net"
	"sync/atomic"
)

var ipAuto atomic.Value

//获取本地ip
func GetLocalIP() (ip string, err error) {

	ip, ok := ipAuto.Load().(string)
	if ok && len(ip) > 0 {
		return
	}

	netInterfaces, err := net.Interfaces()
	if err != nil {
		return
	}

	for _, interfaces := range netInterfaces {
		if (interfaces.Flags & net.FlagUp) != 0 {
			addressAll, _ := interfaces.Addrs()
			for _, address := range addressAll {
				// 检查ip地址判断是否回环地址
				if ipNet, ok := address.(*net.IPNet); ok && !ipNet.IP.IsLoopback() {
					if ipNet.IP.To4() != nil {
						ip = ipNet.IP.String()
						ipAuto.Store(ip)
						return
					}
				}
			}
		}
	}

	err = fmt.Errorf("get local ip failed")
	return
}
