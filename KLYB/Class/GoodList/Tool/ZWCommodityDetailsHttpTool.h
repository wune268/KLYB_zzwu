//
//  ZWCommodityDetailsHttpTool.h
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWClassRequestPrams;
@class ZWBrandRequestParams;
@class ZWBrandDetailsItems;
@class ZWSearchShopParams;
@class ZWSearchShopResualt;

@interface ZWCommodityDetailsHttpTool : NSObject


+ (void)wu_getClassificationWithParams:(ZWClassRequestPrams *)params
                               success:(void (^)(NSArray *array))success
                               failure:(void (^)(NSError *error))failure;

+ (void)wu_getBrandListWithParams:(ZWBrandRequestParams *)params
                          success:(void (^)(ZWBrandDetailsItems *brandDetailsItems))success
                          failure:(void (^)(NSError *error))failure;

+ (void)wu_getSearchGoodsListWithParams:(ZWSearchShopParams *)params
                                success:(void (^)(ZWSearchShopResualt *searchShopResualt))success
                                failure:(void (^)(NSError *error))failure;

@end
