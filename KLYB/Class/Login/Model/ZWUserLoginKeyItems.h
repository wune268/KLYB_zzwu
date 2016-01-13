//
//  ZWUserLoginKeyItems.h
//  KLYB
//
//  Created by ZZWU on 16/1/4.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWUserLoginKeyItems : NSObject

/**
 *  是否需要验证码
 */
@property(nonatomic, copy)NSString *displayAuthcode;

/**
 *  密钥运算码
 */
@property(nonatomic, copy)NSString *keyExponent;

/**
 *  登录密匙
 */
@property(nonatomic, copy)NSString *keyModulus;

/**
 *  提示信息
 */
@property(nonatomic, copy)NSString *message;

/**
 *  请求状态
 */
@property(nonatomic, copy)NSString *status;

@property(nonatomic, copy)NSString *url;

@end
