//
//  ZWUserAccount.h
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWUserAccount : NSObject<NSCoding>

/**
 *  用户的密码
 */
@property (nonatomic, copy) NSString *password;

/**
 *  用户名
 */
@property (nonatomic, copy) NSString *userName;

//+ (instancetype)accountWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
