//
//  ZWAlipayRequestConfig.h
//  KLYB
//
//  Created by ZZWU on 16/1/9.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlipayHeader.h"

@class ZWAlipayResult;

@interface ZWAlipayRequestConfig : NSObject

/**
 *  配置请求信息，仅有变化且必要的参数
 *
 *  @param tradeNO            商户网站唯一订单号
 *  @param productName        商品名称
 *  @param productDescription 商品详情
 *  @param amount             总金额
 *  @param itBPay             未付款交易的超时时间
 *  @param success             交易状态回调
 */
+ (void)wu_alipayWithTradeNO:(NSString *)tradeNO
                 productName:(NSString *)productName
          productDescription:(NSString *)productDescription
                      amount:(NSString *)amount
                      itBPay:(NSString *)itBPay
                     success:(void (^)(ZWAlipayResult *alipayResult))success;

@end