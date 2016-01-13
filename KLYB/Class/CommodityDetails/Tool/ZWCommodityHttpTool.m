//
//  ZWCommodityHttpTool.m
//  KLYB
//
//  Created by ZZWU on 15/12/29.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCommodityHttpTool.h"
#import "ZWCommodityParams.h"
#import "ZWCommodityDetails.h"
#import "ZWEvaluateItems.h"

@implementation ZWCommodityHttpTool

+ (void)wu_getShopWithParams:(ZWCommodityParams *)params
                     success:(void (^)(ZWCommodityDetails *))success
                     failure:(void (^)(NSError *))failure
{
//    NSDictionary *paramsDict = [params mj_keyValues];
//    NSDictionary *paramsDict = [NSDictionary dictionaryWithObject:params.commodityID forKey:@"id"];
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:params.commodityID, @"id", params.rows, @"rows", params.page, @"page", nil];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/item", httpAddress] params:paramsDict success:^(id json) {
        if (success) {
//            WuLog(@"json%@",json);
            ZWCommodityDetails *commodityDetails = [ZWCommodityDetails mj_objectWithKeyValues:json];
//            WuLog(@"%@",commodityDetails);
            success(commodityDetails);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)wu_getEvaluateWithParams:(ZWCommodityParams *)params
                         success:(void (^)(NSArray *))success
                         failure:(void (^)(NSError *))failure
{
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:params.commodityID, @"id", params.rows, @"rows", params.page, @"page", nil];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/item/comment",httpAddress] params:paramsDict success:^(id json) {
        if (success) {
            WuLog(@"%@",json);
            NSMutableArray *evaluateItemsArray = [ZWEvaluateItems mj_objectArrayWithKeyValuesArray:json];
            success(evaluateItemsArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
