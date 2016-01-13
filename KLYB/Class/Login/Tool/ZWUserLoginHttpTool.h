//
//  ZWUserLoginHttpTool.h
//  KLYB
//
//  Created by ZZWU on 16/1/4.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@class ZWUserLoginKeyItems;

@interface ZWUserLoginHttpTool : NSObject

/**
 *  发送一个POST请求登录
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_postLoginWithparams:(NSDictionary *)params
                       success:(void (^)(id json))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求注册
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_postCreatWithparams:(NSDictionary *)params
                       success:(void (^)(id json))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  发送一个Get请求密匙
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_getKeyWithparams:(NSDictionary *)params
                    success:(void (^)(ZWUserLoginKeyItems *keyItems))success
                    failure:(void (^)(NSError *error))failure;

@end
