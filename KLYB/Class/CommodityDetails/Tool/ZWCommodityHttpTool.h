//
//  ZWCommodityHttpTool.h
//  KLYB
//
//  Created by ZZWU on 15/12/29.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWCommodityParams;
@class ZWCommodityDetails;
//@class ZWEvaluateItems;

@interface ZWCommodityHttpTool : NSObject

+ (void)wu_getShopWithParams:(ZWCommodityParams *)params
                     success:(void (^)(ZWCommodityDetails *commodityDetails))success
                     failure:(void (^)(NSError *error))failure;

+ (void)wu_getEvaluateWithParams:(ZWCommodityParams *)params
                         success:(void (^)(NSArray *evaluateItemsArray))success
                         failure:(void (^)(NSError *error))failure;

@end
