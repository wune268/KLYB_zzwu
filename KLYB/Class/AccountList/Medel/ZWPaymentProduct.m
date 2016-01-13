//
//  ZWPaymentProduct.m
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWPaymentProduct.h"

@implementation ZWPaymentProduct

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsTitle" : @"name",
             @"sellerSubject" : @"desc",
             @"goodsPrice" : @"payFee",
             @"sellerGoodsID" : @"orderNo",
             @"payStyle" : @"payType",
             @"expressStyle" : @"sendType",
             };
}

@end
