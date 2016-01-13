//
//  ZWAccountListHttpTool.h
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@class ZWAccountOrderResultItems;
@class ZWAccountParams;
@class ZWPaymentProduct;
@class ZWBuildListParams;

@interface ZWAccountListHttpTool : NSObject

/**
 *  发送一个GET请求确认订单
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_getAccountListWithParams:(ZWAccountParams *)params
                            success:(void (^)(ZWAccountOrderResultItems *accountOrderResultItems))success
                            failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求生成订单
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_postBuildAccountListWithParams:(ZWBuildListParams *)params
                                  success:(void (^)(ZWPaymentProduct *paymentProduct))success
                                  failure:(void (^)(NSError *error))failure;

@end
