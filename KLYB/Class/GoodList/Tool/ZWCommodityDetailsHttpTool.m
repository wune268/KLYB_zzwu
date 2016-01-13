//
//  ZWCommodityDetailsHttpTool.m
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCommodityDetailsHttpTool.h"
#import "ZWClassRequestPrams.h"
#import "ZWGoodDetailsItems.h"
#import "ZWBrandRequestParams.h"
#import "ZWBrandDetailsItems.h"
#import "ZWSearchShopParams.h"
#import "ZWSearchShopResualt.h"

@implementation ZWCommodityDetailsHttpTool

+ (void)wu_getClassificationWithParams:(ZWClassRequestPrams *)params
                               success:(void (^)(NSArray *))success
                               failure:(void (^)(NSError *))failure
{
//    模型转字典
    NSDictionary *paramsDict = [params mj_keyValues];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/cate/item", httpAddress] params:paramsDict success:^(id json) {
        if (success) {
//            NSLog(@"%@--",json);
            NSMutableArray *goodDetailsItemsArray = [ZWGoodDetailsItems mj_objectArrayWithKeyValuesArray:json];
            success(goodDetailsItemsArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)wu_getBrandListWithParams:(ZWBrandRequestParams *)params
                          success:(void (^)(ZWBrandDetailsItems *))success
                          failure:(void (^)(NSError *))failure
{
//    模型转字典
    NSDictionary *paramsDict = [params mj_keyValues];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/brand/item", httpAddress] params:paramsDict success:^(id json) {
        if (success) {
            WuLog(@"%@--",json);
//            NSMutableArray *goodDetailsItemsArray = [ZWGoodDetailsItems mj_objectArrayWithKeyValuesArray:json];
            ZWBrandDetailsItems *brandDetailsItems = [ZWBrandDetailsItems mj_objectWithKeyValues:json];
            success(brandDetailsItems);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)wu_getSearchGoodsListWithParams:(ZWSearchShopParams *)params
                                success:(void (^)(ZWSearchShopResualt *))success
                                failure:(void (^)(NSError *))failure
{
//    模型转字典
    NSDictionary *paramsDict = [params mj_keyValues];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/item/search", httpAddress] params:paramsDict success:^(id json) {
        if (success) {
            WuLog(@"%@--",json);
            //            NSMutableArray *goodDetailsItemsArray = [ZWGoodDetailsItems mj_objectArrayWithKeyValuesArray:json];
            ZWSearchShopResualt *searchShopResualt = [ZWSearchShopResualt mj_objectWithKeyValues:json];
            success(searchShopResualt);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
