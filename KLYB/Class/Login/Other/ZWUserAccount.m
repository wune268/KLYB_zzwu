//
//  ZWUserAccount.m
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWUserAccount.h"

@implementation ZWUserAccount

//+ (instancetype)accountWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.password = [decoder decodeObjectForKey:@"password"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.password forKey:@"password"];
    [encoder encodeObject:self.userName forKey:@"userName"];
}


@end
