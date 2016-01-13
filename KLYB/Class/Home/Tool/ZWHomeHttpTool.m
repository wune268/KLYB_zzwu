//
//  ZWHomeHttpTool.m
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWHomeHttpTool.h"
#import "ZWActivity.h"
#import "ZWThemePavilion.h"
#import "ZWItems.h"
#import "ZWActivityParams.h"
#import "ZWActivityGoodsDetailItem.h"

@implementation ZWHomeHttpTool

/**
 *  滚动图片
 *
 *  @param url     URL地址
 *  @param params  请求参数
 *  @param success 成功
 *  @param failure 失败
 */
+(void)wu_getHomeActivitySuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@app/v1/index/rollActivity",httpAddress];
    [ZWKLYBHttpTool wu_getWithURL:url params:nil success:^(id json) {
        if (success) {
//            NSLog(@"%@",json);
            NSMutableArray *activity = [NSMutableArray array];
            activity = [ZWActivity mj_objectArrayWithKeyValuesArray:json];
            success(activity);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

/**
 *  品牌分类
 *
 *  @param url     URL地址
 *  @param params  请求参数
 *  @param success 成功
 *  @param failure 失败
 */

+ (void)wu_getHomeBrandSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@app/v1/index/navCategory",httpAddress];
    [ZWKLYBHttpTool wu_getWithURL:url params:nil success:^(id json) {
        if (success) {
//            NSLog(@"---%@",json);
            NSMutableArray *themePavilion = [NSMutableArray array];
            themePavilion = [ZWThemePavilion mj_objectArrayWithKeyValuesArray:json];
            success(themePavilion);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

/**
 *  本周推荐
 *
 *  @param url     URL地址
 *  @param params  请求参数
 *  @param success 成功
 *  @param failure 失败
 */
+(void)wu_getHomeRecommendedSuccess:(void (^)(NSArray *))success
                            failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:@"%@app/v1/index/weekChosen",httpAddress];
    [ZWKLYBHttpTool wu_getWithURL:url params:nil success:^(id json) {
        if (success) {
//            NSLog(@"%@--json",json);
            NSMutableArray *recommended = [NSMutableArray array];
            recommended = [ZWItems mj_objectArrayWithKeyValuesArray:json];
            success(recommended);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)wu_getActivityParams:(ZWActivityParams *)params
                     success:(void (^)(ZWActivityGoodsDetailItem *))success
                     failure:(void (^)(NSError *))failure

{
    NSDictionary *activityParams = [NSDictionary dictionaryWithObjectsAndKeys:params.activityID, @"id", nil];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/activity",httpAddress] params:activityParams success:^(id json) {
        if (success) {
//            WuLog(@"json--%@",json);
            ZWActivityGoodsDetailItem *activityGoodsDetailItem = [ZWActivityGoodsDetailItem mj_objectWithKeyValues:json];
            success(activityGoodsDetailItem);
        }
    } failure:^(NSError *error) {
        if (error) {
            WuLog(@"%@",error);
            failure(error);
        }
    }];
}

@end
