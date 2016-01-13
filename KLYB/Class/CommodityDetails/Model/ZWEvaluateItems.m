//
//  ZWEvaluateItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/25.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWEvaluateItems.h"

@implementation ZWEvaluateItems

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"user_PortraitUrl" : @"portraitUrl",
             @"user_Name" : @"name",
             @"user_Depict" : @"evaluateDetail",
             @"user_Account" : @"account",
             @"user_CommentScore" : @"commentScore",
             @"user_EvaluateTime" : @"evaluateTime",
             @"user_imgUrl" : @"evaImgList"
             };
}

@end
