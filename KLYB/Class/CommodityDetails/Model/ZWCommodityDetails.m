//
//  ZWCommodityDetails.m
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCommodityDetails.h"
//#import "ZWEvaluateItems.h"

@implementation ZWCommodityDetails

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"shop_ImgList" : @"imgList",
             @"shop_Name" : @"name",
             @"shop_price_New" : @"price",
             @"shop_price_Old" : @"originalPrice",
             @"shop_Stocks" : @"stock",
             @"shop_Sales" : @"sales",
             @"shop_Type" : @"type",
             @"shop_Score" : @"score",
             @"shop_Remark" : @"remark",
             @"shop_ID" : @"id",
             @"shop_EvaluateNum" : @"evaluateNum",
             @"shop_EvList" : @"evList",
             @"shop_Brand" : @"brand",
             @"shop_AttrsList" : @"attrsList"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"shop_EvList" : @"ZWEvaluateItems"
             };
}

@end
