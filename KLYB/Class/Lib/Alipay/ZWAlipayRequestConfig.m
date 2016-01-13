//
//  ZWAlipayRequestConfig.m
//  KLYB
//
//  Created by ZZWU on 16/1/9.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWAlipayRequestConfig.h"
#import "ZWAlipayResult.h"

@implementation ZWAlipayRequestConfig

// 仅含有变化的参数
+ (void)wu_alipayWithTradeNO:(NSString *)tradeNO
                 productName:(NSString *)productName
          productDescription:(NSString *)productDescription
                      amount:(NSString *)amount
                      itBPay:(NSString *)itBPay
                     success:(void (^)(ZWAlipayResult *))success
{
    [self wu_alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:tradeNO productName:productName productDescription:productDescription amount:amount notifyURL:kNotifyURL service:@"mobile.securitypay.pay" paymentType:@"1" inputCharset:@"UTF-8" itBPay:itBPay showUrl:@"m.alipay.com" privateKey:kPrivateKey appScheme:kAppScheme success:^(ZWAlipayResult *alipayResult)
    {
        if (success)
        {
            success(alipayResult);
        }
    }];
}

// 包含所有必要的参数
+ (void)wu_alipayWithPartner:(NSString *)partner
                      seller:(NSString *)seller
                     tradeNO:(NSString *)tradeNO
                 productName:(NSString *)productName
          productDescription:(NSString *)productDescription
                      amount:(NSString *)amount
                   notifyURL:(NSString *)notifyURL
                     service:(NSString *)service
                 paymentType:(NSString *)paymentType
                inputCharset:(NSString *)inputCharset
                      itBPay:(NSString *)itBPay
                     showUrl:(NSString *)showUrl
                  privateKey:(NSString *)privateKey
                   appScheme:(NSString *)appScheme
                     success:(void (^)(ZWAlipayResult *alipayResult))success
{
    
    /*
     *生成订单信息及签名
     */
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = tradeNO; //订单ID（由商家自行制定）
    order.productName = productName; //商品标题
    order.productDescription = productDescription; //商品描述
    order.amount = amount; //商品价格
//    支付宝服务器返回告诉商家服务器的地址（商家服务器地址）
    order.notifyURL = notifyURL;
    order.service = service;
    order.paymentType = paymentType;
    order.inputCharset = inputCharset;
    order.itBPay = itBPay;
    order.showUrl = showUrl;
    NSString *orderSpec = [order description];
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    NSString *signedString = [self wu_genSignedStringWithPrivateKey:kPrivateKey OrderSpec:orderSpec];
    
    // 调用支付接口
    [self wu_payWithAppScheme:appScheme orderSpec:orderSpec signedString:signedString success:^(ZWAlipayResult *alipayResult) {
        if (success) {
            success(alipayResult);
        }
    }];
}

// 生成signedString
+ (NSString *)wu_genSignedStringWithPrivateKey:(NSString *)privateKey OrderSpec:(NSString *)orderSpec {
    
    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循 RSA 签名规范, 并将签名字符串 base64 编码和 UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    return [signer signString:orderSpec];
}

// 支付
+ (void)wu_payWithAppScheme:(NSString *)appScheme orderSpec:(NSString *)orderSpec signedString:(NSString *)signedString success:(void (^)(ZWAlipayResult *alipayResult))success{
    
    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if (success) {
                ZWAlipayResult *alipayResult = [ZWAlipayResult mj_objectWithKeyValues:resultDic];
                success(alipayResult);
            }
        }];
    }    
}

@end
