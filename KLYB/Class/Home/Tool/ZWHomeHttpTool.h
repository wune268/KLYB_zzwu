//
//  ZWHomeHttpTool.h
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWActivityParams;
@class ZWActivityGoodsDetailItem;

@interface ZWHomeHttpTool : NSObject

/**
 *  滚动图片
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getHomeActivitySuccess:(void (^)(NSArray *array))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  品牌分类
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getHomeBrandSuccess:(void (^)(NSArray *array))success
                       failure:(void (^)(NSError *error))failure;

/**
 *  本周推荐
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getHomeRecommendedSuccess:(void (^)(NSArray *array))success
                             failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求活动详情
 *
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_getActivityParams:(ZWActivityParams *)params
                     success:(void (^)(ZWActivityGoodsDetailItem *activityGoodsDetailItem))success
                     failure:(void (^)(NSError *error))failure;

@end
