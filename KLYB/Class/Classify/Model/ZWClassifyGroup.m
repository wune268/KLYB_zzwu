//
//  ZWClassifyGroup.m
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWClassifyGroup.h"
#import "ZWClassifyModel.h"

@implementation ZWClassifyGroup

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"classifySub" : @"ZWClassifyModel"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"classifyID" : @"id",
             @"classifyLevel" : @"level",
             @"classifyName" : @"name",
             @"classifySub" : @"sub"
             };
}

@end
