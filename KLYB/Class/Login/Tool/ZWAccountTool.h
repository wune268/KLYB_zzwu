//
//  ZWAccountTool.h
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@class ZWUserAccount;

@interface ZWAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(ZWUserAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (ZWUserAccount *)account;

/**
 *  删除存储的账号信息
 */
+ (void)removeAccount;

@end
