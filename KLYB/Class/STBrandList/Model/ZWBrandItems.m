//
//  ZWBrandItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWBrandItems.h"

@implementation ZWBrandItems

//+ (instancetype)itemsWithDict:(NSDictionary *)dict
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

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"brandID" : @"id"
             };
}

@end
