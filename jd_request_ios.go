package main

import (
	"bytes"
	"crypto/tls"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"time"
)

func main() {
	// iOS TLS配置
	tlsConfig := &tls.Config{
		MinVersion: tls.VersionTLS12,
		MaxVersion: tls.VersionTLS13,
		CipherSuites: []uint16{
			tls.TLS_AES_128_GCM_SHA256,
			tls.TLS_AES_256_GCM_SHA384,
			tls.TLS_CHACHA20_POLY1305_SHA256,
			tls.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
			tls.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
			tls.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
			tls.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
			tls.TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,
			tls.TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,
		},
		PreferServerCipherSuites: false,
		CurvePreferences: []tls.CurveID{
			tls.X25519,
			tls.CurveP256,
			tls.CurveP384,
		},
	}

	// 创建HTTP客户端，模拟iOS行为
	transport := &http.Transport{
		TLSClientConfig:       tlsConfig,
		ForceAttemptHTTP2:     true,
		MaxIdleConns:          100,
		IdleConnTimeout:       90 * time.Second,
		TLSHandshakeTimeout:   10 * time.Second,
		ExpectContinueTimeout: 1 * time.Second,
	}

	client := &http.Client{
		Transport: transport,
		Timeout:   30 * time.Second,
	}

	// 构造请求
	apiURL := "https://api.m.jd.com/client.action?functionId=platPayChannel"
	
	// Body参数
	bodyData := url.Values{}
	bodyData.Set("avifSupport", "0")
	bodyData.Set("body", `{"hasAliPay":"1","fk_latitude":"R8iwgdWURQj6+Osm0RDYgg==","hasQQPay":"1","hasPayMe":"0","fk_appId":"com.360buy.jdmobile","fk_terminalType":"02","hasCyberMoneyPay":"0","supportNFC":"0","orderPrice":"35.00","source":"jdapp","isDegradeToZh":"0","style":"popUp","applePayStatus":"2","hasOCPay":"0","fk_traceIp":"192.168.1.1","orderType":"0","origin":"native","isPushOpen":"1","hasUPPay":"0","quitNotificationName":"JDOrderPaymentCashierQuitNotificationName","sdkToken":"jdd01R7UGKJKXRX6W4P5CNSNVSNTJLHNJNMSJODFNX4Y3FWPB2ZNZ6I6NSJAZCXWILUURADKQL4MAMHRNZVCOW74YIEHU5QRW7K7MJAHKJNY01234567","orderTypeCode":"0","appId":"jd_iphone_app4","fk_longtitude":"R8iwgdWURQj6+Osm0RDYgg==","paySourceId":"2","jdPaySdkVersion":"4.01.78.00","platPayCashierType":"0","paySign":"2ab2ba2064c728329ffb0c33ab9f5957","orderId":"3449266010186072"}`)
	bodyData.Set("build", "170088")
	bodyData.Set("client", "apple")
	bodyData.Set("clientVersion", "15.2.70")
	bodyData.Set("d_brand", "apple")
	bodyData.Set("d_model", "iPhone14,2")
	bodyData.Set("ef", "1")
	bodyData.Set("eid", "eidIf0fe8122dfs1GBTa5cAmQZeVtERbCtiSdxgU3HJo8nHGW+9qEuVARhRJyvjKXambazFNJHclvgj5qU32DU4aJHGi8GNMqxKWpnN25fUlkmUchltR")
	bodyData.Set("ep", `{"ciphertype":5,"cipher":{"screen":"ENS4AtO3EJS=","osVersion":"CJGkDK==","openudid":"ENY0ZtS1EWCnCJC1DWY2CWHrZwU2DQTtYzK2EQYnYwO5CJGmCzvvEK==","area":"CJvpCJYmCV8zDtC1XzYzCJS3","uuid":"aQf1ZRdxb2r4ovZ1EJZhcxYlVNZSZz09"},"ts":1774538339,"hdid":"JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=","version":"1.0.3","appname":"com.360buy.jdmobile","ridx":-1}`)
	bodyData.Set("ext", `{"prstate":"0","pvcStu":"1"}`)
	bodyData.Set("isBackground", "N")
	bodyData.Set("joycious", "120")
	bodyData.Set("lang", "zh_CN")
	bodyData.Set("networkType", "wifi")
	bodyData.Set("networklibtype", "JDNetworkBaseAF")
	bodyData.Set("partner", "apple")
	bodyData.Set("rfs", "0000")
	bodyData.Set("scope", "01")
	bodyData.Set("sign", "e4f9c5b7b932f1f5a8c6d4e3b2a1f9e8")
	bodyData.Set("st", fmt.Sprintf("%d", time.Now().Unix()))
	bodyData.Set("sv", "111")
	bodyData.Set("uemps", "0-0-0")
	bodyData.Set("uts", "0f31TVRjBSsqndu4/jgUPz6uymy50VJnlQBy4y5O1g6pPtzHu2C6+Dv1G8MhCQNdx/1Gcd/6Q3K8KLIeMQ==")

	req, err := http.NewRequest("POST", apiURL, bytes.NewBufferString(bodyData.Encode()))
	if err != nil {
		fmt.Printf("[-] 创建请求失败: %v\n", err)
		return
	}

	// 设置Headers（按顺序）
	req.Header.Set("Host", "api.m.jd.com")
	req.Header.Set("Accept", "*/*")
	req.Header.Set("Accept-Language", "zh-Hans-CN;q=1")
	req.Header.Set("Accept-Encoding", "gzip, deflate, br")
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
	req.Header.Set("Connection", "keep-alive")
	req.Header.Set("User-Agent", "JD4iPhone/170088 (iPhone; iOS; Scale/2.00);jdmall;iphone;version/15.2.70;build/170088;network/wifi;screen/828x1792;os/14.4;lang/zh_CN")
	req.Header.Set("X-Rp-Client", "ios_4.0.0")
	req.Header.Set("X-Referer-Package", "com.360buy.jdmobile")
	req.Header.Set("x-pp-aew", "4")
	req.Header.Set("J-E-H", fmt.Sprintf("%%7B%%22ciphertype%%22:5,%%22cipher%%22:%%7B%%22User-Agent%%22:%%22IuG0aVLeb25vBzO3CNK4EMUyCMrfUQrlbwU7TJSmaU9JTJSmCJGkDNivCtLJY2PiZI8yBtKmAJjiYW5xB3feX0DE%%22%%7D,%%22ts%%22:%d,%%22hdid%%22:%%22JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=%%22,%%22version%%22:%%221.0.3%%22,%%22appname%%22:%%22com.360buy.jdmobile%%22,%%22ridx%%22:-1%%7D", time.Now().Unix()))
	req.Header.Set("J-E-C", "%7B%22ciphertype%22:5,%22cipher%22:%7B%22pin%22:%22d2HRGWdCbUfUbwdjIRK=%22%7D,%22ts%22:1774538360,%22hdid%22:%22JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=%22,%22version%22:%221.0.3%22,%22appname%22:%22com.360buy.jdmobile%22,%22ridx%22:-1%7D")
	req.Header.Set("jdgs", `{"b1":"9a8fc377-4a62-4500-b506-4fd9e8847e47","b2":"3.0.45_1","b3":"3.0","b4":"eTKekHttHBa/ePgCCqPVxLzVmW//OOGVTfKm2krjK3GNx0sy7RAg6g3Dty93+Ke24MnVOOrdkWhp0a6DYuHN860zmje6C6ZCOjkUGjT9EgtCGuxQ6dMt5T5mAuSQPDIf1ZNnGSv0aQHgKTSgQuPTs9fqRPNf3j76XijpdiKodfp7ofpxk+yFdsYp741w3d1dj/GJkdlbxL5NfqVnA+fx49gEbzakNGhdpx5ZN5ZZSjEX4iLm3DAR/tX26884g5hVnGgJqsHeLxFR5fWYK+ltQyLEvsjpT3mQ/+aZMdBAhxRpcNvKeAwfPFJD4R32+uIM+noDS1FlKUqAsgtfjdfZ9lL9TiiTcZ4vhm17RDpBMH5bQcnRuo1Nkm02ynXNT82XaQ0nnmANlQDPYHj7Pqs71Zkl+N0Xw1x4/81GRayZrBnkPt98Rb7JI9tnkWkJy/cwnU2/gGDV41qwZC2Ilrhaygn7Uc2dynfO735cDqHWokay7XO2LtnLJpZiO8num8wyeq8cLirfGFLvJsBpZ8YHLJQEYnGPC/JqmmlGKv5pH9pgh20BiyeN42OBRCcE8cyIoepjZbZLcjwRYajwmqe9h+wTyI9nbnLKNJ/bT+G7P2n1sQ6IzzEpfTq4+Sn83OU54obX2jJyoFB+EWdMBfDzKvg50RX4LcgArZyYCgWaIIMNvZBCXqUh+cVbXhsH00tJKVxQpfPLqZGGkDf8fjQmke79XcGhA5yB6Putiw==","b5":"33cd23694e5b07c283ad98e3a0d8675c62a5e202f2aaf3be8b14416cf4d84a9e","b7":"1774538360971","b6":"efef2f9764178192bd0d3cf8d3531ad93334b98c2d447d7f687cf2cafab56d20"}`)
	req.Header.Set("Cookie", "wskey=AAJpxPSvAECsw1QPNkuyeBUaH1sNrpK2fMPs0-HJT9cfGAgFzsRcsekJ0L4INn--bqVSZOUavQZPVRb6J58e_Bh-bYRAsj2C;whwswswws=JD0111d47dWbCw4jgPZP177453833886602Oj_ZSmJ9A6PTvmE1ZaoDbOsskyeGoOJtyj3PJ_MPC6C1MVetInRN9qAeJXkype5Bqe3PPONnK7GXtwOWTWwvn14PCxev_7qP3i9-IXiihf00eqfrib~BApXW_aKyKfhDcOE1blbb69MTlxMHBtkrq9MBPsdX9xJ1PMtfWqfRvhfBuCX9Pq5jhIyTs0OmtqFbJepgv6gI5I8pOl7rrjUI-sFe;unionwsws={\"jmafinger\":\"JD0111d47dWbCw4jgPZP177453833886602Oj_ZSmJ9A6PTvmE1ZaoDbOsskyeGoOJtyj3PJ_MPC6C1MVetInRN9qAeJXkype5Bqe3PPONnK7GXtwOWTWwvn14PCxev_7qP3i9-IXiihf00eqfrib~BApXW_aKyKfhDcOE1blbb69MTlxMHBtkrq9MBPsdX9xJ1PMtfWqfRvhfBuCX9Pq5jhIyTs0OmtqFbJepgv6gI5I8pOl7rrjUI-sFe\",\"devicefinger\":\"eidIf0fe8122dfs1GBTa5cAmQZeVtERbCtiSdxgU3HJo8nHGW+9qEuVARhRJyvjKXambazFNJHclvgj5qU32DU4aJHGi8GNMqxKWpnN25fUlkmUchltR\"};pin_hash=1899576657;x-rp-evtoken=mGW9U4qbzsaBdCMe70m9pGfhbdsYltfhxZc3LMHunig8SKiiI7GV6Du-3DP2RxRjzQOHlmNdJbXUsUSFp6lWGg==;sdtoken=AAbEsBpEIOVjqTAKCQtvQu177MZhI2dRi8Caou4yLnx-guzvAMBX-rk_qUIq3lu9PiP1FiHg0YEeWAlZMK-Ql000XWcRLG1lhDPJCmXSySDAWhB32K_Fkcc9J5s")

	fmt.Println("[*] 使用Go发送请求...")
	fmt.Println("[*] URL:", apiURL)
	fmt.Println("[*] 使用自定义TLS配置模拟iOS")

	resp, err := client.Do(req)
	if err != nil {
		fmt.Printf("[-] 请求失败: %v\n", err)
		return
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("[-] 读取响应失败: %v\n", err)
		return
	}

	fmt.Printf("[+] 状态码: %d\n", resp.StatusCode)
	fmt.Printf("[+] 响应头: %v\n", resp.Header)
	fmt.Printf("[+] 响应体: %s\n", string(body))

	if resp.StatusCode == 200 {
		if bytes.Contains(body, []byte(`"code":"601"`)) {
			fmt.Println("[-] 触发风控601")
		} else if bytes.Contains(body, []byte(`"code":"0"`)) {
			fmt.Println("[✓] 成功绕过风控！")
		}
	}
}
