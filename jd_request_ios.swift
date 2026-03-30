#!/usr/bin/env swift
// 京东支付渠道请求 - 使用Swift URLSession (iOS同款网络栈)
// 编译: swiftc jd_request_ios.swift -o jd_request_ios
// 运行: ./jd_request_ios

import Foundation

// 配置请求
let url = URL(string: "https://api.m.jd.com/client.action?functionId=platPayChannel")!
let iosVersion = "17.1.2"
let appVersion = "15.2.70"
let buildVersion = "170088"
let deviceModel = "iPhone14,2"
let currentTime = Int(Date().timeIntervalSince1970)
let eid = "eidIf0fe8122dfs1GBTa5cAmQZeVtERbCtiSdxgU3HJo8nHGW+9qEuVARhRJyvjKXambazFNJHclvgj5qU32DU4aJHGi8GNMqxKWpnN25fUlkmUchltR"

// 构造Body
let bodyObj: [String: String] = [
    "hasAliPay": "1",
    "fk_latitude": "R8iwgdWURQj6+Osm0RDYgg==",
    "hasQQPay": "1",
    "hasPayMe": "0",
    "fk_appId": "com.360buy.jdmobile",
    "fk_terminalType": "02",
    "hasCyberMoneyPay": "0",
    "supportNFC": "0",
    "orderPrice": "35.00",
    "source": "jdapp",
    "isDegradeToZh": "0",
    "style": "popUp",
    "applePayStatus": "2",
    "hasOCPay": "0",
    "fk_traceIp": "192.168.1.1",
    "orderType": "0",
    "origin": "native",
    "isPushOpen": "1",
    "hasUPPay": "0",
    "quitNotificationName": "JDOrderPaymentCashierQuitNotificationName",
    "sdkToken": "jdd01R7UGKJKXRX6W4P5CNSNVSNTJLHNJNMSJODFNX4Y3FWPB2ZNZ6I6NSJAZCXWILUURADKQL4MAMHRNZVCOW74YIEHU5QRW7K7MJAHKJNY01234567",
    "orderTypeCode": "0",
    "appId": "jd_iphone_app4",
    "fk_longtitude": "R8iwgdWURQj6+Osm0RDYgg==",
    "paySourceId": "2",
    "jdPaySdkVersion": "4.01.78.00",
    "platPayCashierType": "0",
    "paySign": "2ab2ba2064c728329ffb0c33ab9f5957",
    "orderId": "3449266010186072"
]

let epObj: [String: Any] = [
    "ciphertype": 5,
    "cipher": [
        "screen": "ENS4AtO3EJS=",
        "osVersion": "CJGkDK==",
        "openudid": "ENY0ZtS1EWCnCJC1DWY2CWHrZwU2DQTtYzK2EQYnYwO5CJGmCzvvEK==",
        "area": "CJvpCJYmCV8zDtC1XzYzCJS3",
        "uuid": "aQf1ZRdxb2r4ovZ1EJZhcxYlVNZSZz09"
    ],
    "ts": 1774538339,
    "hdid": "JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=",
    "version": "1.0.3",
    "appname": "com.360buy.jdmobile",
    "ridx": -1
]

let extObj: [String: String] = [
    "prstate": "0",
    "pvcStu": "1"
]

// JSON编码
func jsonString(_ obj: Any) -> String {
    let data = try! JSONSerialization.data(withJSONObject: obj, options: [])
    return String(data: data, encoding: .utf8)!
}

// 构造body参数
var bodyParams: [String: String] = [
    "avifSupport": "0",
    "body": jsonString(bodyObj),
    "build": buildVersion,
    "client": "apple",
    "clientVersion": appVersion,
    "d_brand": "apple",
    "d_model": deviceModel,
    "ef": "1",
    "eid": eid,
    "ep": jsonString(epObj),
    "ext": jsonString(extObj),
    "isBackground": "N",
    "joycious": "120",
    "lang": "zh_CN",
    "networkType": "wifi",
    "networklibtype": "JDNetworkBaseAF",
    "partner": "apple",
    "rfs": "0000",
    "scope": "01",
    "sign": "e4f9c5b7b932f1f5a8c6d4e3b2a1f9e8",
    "st": String(currentTime),
    "sv": "111",
    "uemps": "0-0-0",
    "uts": "0f31TVRjBSsqndu4/jgUPz6uymy50VJnlQBy4y5O1g6pPtzHu2C6+Dv1G8MhCQNdx/1Gcd/6Q3K8KLIeMQ=="
]

// URL编码body
let bodyString = bodyParams.map { "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)" }.joined(separator: "&")
let bodyData = bodyString.data(using: .utf8)!

// 创建请求
var request = URLRequest(url: url)
request.httpMethod = "POST"
request.httpBody = bodyData

// 设置Headers（保持顺序）
request.setValue("api.m.jd.com", forHTTPHeaderField: "Host")
request.setValue("*/*", forHTTPHeaderField: "Accept")
request.setValue("zh-Hans-CN;q=1", forHTTPHeaderField: "Accept-Language")
request.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
request.setValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content-Type")
request.setValue("keep-alive", forHTTPHeaderField: "Connection")
request.setValue("JD4iPhone/\(buildVersion) (iPhone; iOS; Scale/2.00);jdmall;iphone;version/\(appVersion);build/\(buildVersion);network/wifi;screen/828x1792;os/14.4;lang/zh_CN", forHTTPHeaderField: "User-Agent")
request.setValue("ios_4.0.0", forHTTPHeaderField: "X-Rp-Client")
request.setValue("com.360buy.jdmobile", forHTTPHeaderField: "X-Referer-Package")
request.setValue("4", forHTTPHeaderField: "x-pp-aew")

let j_e_h = "%7B%22ciphertype%22:5,%22cipher%22:%7B%22User-Agent%22:%22IuG0aVLeb25vBzO3CNK4EMUyCMrfUQrlbwU7TJSmaU9JTJSmCJGkDNivCtLJY2PiZI8yBtKmAJjiYW5xB3feX0DE%22%7D,%22ts%22:\(currentTime),%22hdid%22:%22JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=%22,%22version%22:%221.0.3%22,%22appname%22:%22com.360buy.jdmobile%22,%22ridx%22:-1%7D"
request.setValue(j_e_h, forHTTPHeaderField: "J-E-H")

let j_e_c = "%7B%22ciphertype%22:5,%22cipher%22:%7B%22pin%22:%22d2HRGWdCbUfUbwdjIRK=%22%7D,%22ts%22:1774538360,%22hdid%22:%22JM9F1ywUPwflvMIpYPok0tt5k9kW4ArJEU3lfLhxBqw=%22,%22version%22:%221.0.3%22,%22appname%22:%22com.360buy.jdmobile%22,%22ridx%22:-1%7D"
request.setValue(j_e_c, forHTTPHeaderField: "J-E-C")

let jdgs = "{\"b1\":\"9a8fc377-4a62-4500-b506-4fd9e8847e47\",\"b2\":\"3.0.45_1\",\"b3\":\"3.0\",\"b4\":\"eTKekHttHBa/ePgCCqPVxLzVmW//OOGVTfKm2krjK3GNx0sy7RAg6g3Dty93+Ke24MnVOOrdkWhp0a6DYuHN860zmje6C6ZCOjkUGjT9EgtCGuxQ6dMt5T5mAuSQPDIf1ZNnGSv0aQHgKTSgQuPTs9fqRPNf3j76XijpdiKodfp7ofpxk+yFdsYp741w3d1dj/GJkdlbxL5NfqVnA+fx49gEbzakNGhdpx5ZN5ZZSjEX4iLm3DAR/tX26884g5hVnGgJqsHeLxFR5fWYK+ltQyLEvsjpT3mQ/+aZMdBAhxRpcNvKeAwfPFJD4R32+uIM+noDS1FlKUqAsgtfjdfZ9lL9TiiTcZ4vhm17RDpBMH5bQcnRuo1Nkm02ynXNT82XaQ0nnmANlQDPYHj7Pqs71Zkl+N0Xw1x4/81GRayZrBnkPt98Rb7JI9tnkWkJy/cwnU2/gGDV41qwZC2Ilrhaygn7Uc2dynfO735cDqHWokay7XO2LtnLJpZiO8num8wyeq8cLirfGFLvJsBpZ8YHLJQEYnGPC/JqmmlGKv5pH9pgh20BiyeN42OBRCcE8cyIoepjZbZLcjwRYajwmqe9h+wTyI9nbnLKNJ/bT+G7P2n1sQ6IzzEpfTq4+Sn83OU54obX2jJyoFB+EWdMBfDzKvg50RX4LcgArZyYCgWaIIMNvZBCXqUh+cVbXhsH00tJKVxQpfPLqZGGkDf8fjQmke79XcGhA5yB6Putiw==\",\"b5\":\"33cd23694e5b07c283ad98e3a0d8675c62a5e202f2aaf3be8b14416cf4d84a9e\",\"b7\":\"1774538360971\",\"b6\":\"efef2f9764178192bd0d3cf8d3531ad93334b98c2d447d7f687cf2cafab56d20\"}"
request.setValue(jdgs, forHTTPHeaderField: "jdgs")

let cookie = "wskey=AAJpxPSvAECsw1QPNkuyeBUaH1sNrpK2fMPs0-HJT9cfGAgFzsRcsekJ0L4INn--bqVSZOUavQZPVRb6J58e_Bh-bYRAsj2C;whwswswws=JD0111d47dWbCw4jgPZP177453833886602Oj_ZSmJ9A6PTvmE1ZaoDbOsskyeGoOJtyj3PJ_MPC6C1MVetInRN9qAeJXkype5Bqe3PPONnK7GXtwOWTWwvn14PCxev_7qP3i9-IXiihf00eqfrib~BApXW_aKyKfhDcOE1blbb69MTlxMHBtkrq9MBPsdX9xJ1PMtfWqfRvhfBuCX9Pq5jhIyTs0OmtqFbJepgv6gI5I8pOl7rrjUI-sFe;unionwsws={\"jmafinger\":\"JD0111d47dWbCw4jgPZP177453833886602Oj_ZSmJ9A6PTvmE1ZaoDbOsskyeGoOJtyj3PJ_MPC6C1MVetInRN9qAeJXkype5Bqe3PPONnK7GXtwOWTWwvn14PCxev_7qP3i9-IXiihf00eqfrib~BApXW_aKyKfhDcOE1blbb69MTlxMHBtkrq9MBPsdX9xJ1PMtfWqfRvhfBuCX9Pq5jhIyTs0OmtqFbJepgv6gI5I8pOl7rrjUI-sFe\",\"devicefinger\":\"eidIf0fe8122dfs1GBTa5cAmQZeVtERbCtiSdxgU3HJo8nHGW+9qEuVARhRJyvjKXambazFNJHclvgj5qU32DU4aJHGi8GNMqxKWpnN25fUlkmUchltR\"};pin_hash=1899576657;x-rp-evtoken=mGW9U4qbzsaBdCMe70m9pGfhbdsYltfhxZc3LMHunig8SKiiI7GV6Du-3DP2RxRjzQOHlmNdJbXUsUSFp6lWGg==;sdtoken=AAbEsBpEIOVjqTAKCQtvQu177MZhI2dRi8Caou4yLnx-guzvAMBX-rk_qUIq3lu9PiP1FiHg0YEeWAlZMK-Ql000XWcRLG1lhDPJCmXSySDAWhB32K_Fkcc9J5s"
request.setValue(cookie, forHTTPHeaderField: "Cookie")

// 配置Session（使用iOS同款配置）
let config = URLSessionConfiguration.default
config.timeoutIntervalForRequest = 30
config.timeoutIntervalForResource = 300
config.httpShouldSetCookies = true
config.httpCookieAcceptPolicy = .always
config.httpAdditionalHeaders = [
    "Accept": "*/*",
    "Accept-Language": "zh-Hans-CN;q=1",
    "Accept-Encoding": "gzip, deflate, br"
]

let session = URLSession(configuration: config)

// 发送请求
print("[*] 使用Swift URLSession发送请求...")
print("[*] URL: \(url)")
print("[*] 使用iOS原生网络栈 (CFNetwork)")

let semaphore = DispatchSemaphore(value: 0)

let task = session.dataTask(with: request) { data, response, error in
    if let error = error {
        print("[-] 错误: \(error)")
        semaphore.signal()
        return
    }
    
    guard let httpResponse = response as? HTTPURLResponse else {
        print("[-] 无效的响应")
        semaphore.signal()
        return
    }
    
    print("[+] 状态码: \(httpResponse.statusCode)")
    print("[+] 响应头: \(httpResponse.allHeaderFields)")
    
    if let data = data, let body = String(data: data, encoding: .utf8) {
        print("[+] 响应体: \(body)")
        
        if body.contains("\"code\":\"601\"") {
            print("[-] 触发风控601")
        } else if body.contains("\"code\":\"0\"") {
            print("[✓] 成功！")
        }
    }
    
    semaphore.signal()
}

task.resume()
semaphore.wait()
