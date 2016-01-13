//
//  ZWAccountOrderResultItems.m
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWAccountOrderResultItems.h"

@implementation ZWAccountOrderResultItems

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"itemList" : @"ZWAccountItemsList",
             @"payTypeList" : @"ZWAccountPayTypeList",
             @"sendTypeList" : @"ZWAccountSendTypeList"
             };
}

@end
