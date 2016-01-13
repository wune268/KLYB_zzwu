//
//  AlipayHeader.h
//  KLYB
//
//  Created by ZZWU on 16/1/9.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#ifndef AlipayHeader_h
#define AlipayHeader_h

#import <AlipaySDK/AlipaySDK.h>     // 导入AlipaySDK
#import "ZWAlipayRequestConfig.h"     // 导入支付类
#import "Order.h"                   // 导入订单类
#import "DataSigner.h"              // 生成signer的类：获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode

/**
 *  partner:合作身份者ID,以 2088 开头由 16 位纯数字组成的字符串。
 *
 */
#define kPartnerID @"2088121255193687"


/**
 *  seller:支付宝收款账号,手机号码或邮箱格式。
 */
#define kSellerAccount @"klyb20151103@qq.com"

/**
 *  支付宝服务器主动通知商户网站里指定的页面 http 路径。
 */
#define kNotifyURL @"http://www.klg100.com.cn/app/v1/order/appback"

/**
 *  appSckeme:应用注册scheme，处理支付宝回调
 */
#define kAppScheme @"KLYBzzwu"

/**
 *  private_key:商户方的私钥,pkcs8 格式。
 */
#define kPrivateKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAOFLBDXjtWUKsH7u6b6udxJpX4O6ebOJ/qOP1MV8pbfk6PBHY80J1gjtZ2KHOGgyl+hOXid8rb70Ql7hZxs1PdgNq1rywaarN8E+8NTDQpxSuAJtumqYaDbqHFvxtIJfH0Q2RKO38f8hzfbB0479g/1G7UPvYCG2e2CH7U08Yj3/AgMBAAECgYEAlxrtdAeKPn7w6fHsLMxvaJXsTjngLp87fxCVMO/tZm3OHnqDYZ5bRBmW4eq31os4f8MwO2PQVOcXLPQZZ5JKK0Bw/gR45CpaJqYa+twmWlHvuSHL1RjjZJWkvhIb5ihxHx9rLcJhQAL72KAch1LLqVAG+ZSeWJHmNLXZNWtZW2ECQQD6YTFZmo+6LRX+u7UJwIf17eHgknfJdJZONC5apYxscYMFUkEVwgUBy27LKQ+lNEV3ACqjxN14ausfD5osiVLNAkEA5lmpz6AJ8mEdWm3p/FxTWmy9I27eNeTZYBkr2Xy64/uusOYCG+o2/wYHHQ0W6a87KDFwom5kOfiof1vaCGxL+wJAVS8mFB8y0RuvxQfl0xiO6Uvysm4ClSa2UIsOTkbOnMKN2gyfGiD1hSPKYRJqQUGkdJU47Jj45JQzxFCRmp9p7QJBAK86OgElXyuwUKH/xuUgXpAE9ARGTGd3BR0jSMYTKiBPzt3mumf9zYRGU5b35Bw0Hq4+nc4SZ8/pplPrzXpm140CQQCJdEv4dRjHPVFRLo/hJnmkebMyQkQwWQA4+TP2KOhccFZm09JgDpGtK1oZsHTFa6KD3zykqJ08yaCWZtRFsSE5"



#endif /* AlipayHeader_h */
