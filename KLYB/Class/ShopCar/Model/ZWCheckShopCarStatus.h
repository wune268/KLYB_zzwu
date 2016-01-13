//
//  ZWCheckShopCarStatus.h
//  KLYB
//
//  Created by ZZWU on 16/1/5.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWCheckShopCarStatus : NSObject

/**
 *  请求状态
 */
@property(nonatomic,copy) NSString *status;

/**
 *  响应代码
 */
@property(nonatomic,copy) NSNumber *code;

/**
 *  提示信息
 */
@property(nonatomic,copy) NSString *message;

/**
 *  跳转url
 */
@property(nonatomic,copy) NSNumber *url;

@end
