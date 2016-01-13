//
//  ZWColumuItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/16.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWColumuItems.h"

@implementation ZWColumuItems

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"columuID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"items" : @"ZWItems"
             };
}

@end
