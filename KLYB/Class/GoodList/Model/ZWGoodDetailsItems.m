//
//  ZWGoodDetailsItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodDetailsItems.h"

@implementation ZWGoodDetailsItems

//-(instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//
//+(instancetype)itemsWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classID" : @"id"
             };
}

@end
