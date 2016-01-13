//
//  ZWShopCarHttpTool.h
//  KLYB
//
//  Created by ZZWU on 16/1/5.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@class ZWAddShopCarParams;
@class ZWAddOrDeleteShopCarStatus;
@class ZWGoodsInfoCarItems;
@class ZWDeleteShopCarItems;

@interface ZWShopCarHttpTool : NSObject

/**
 *  发送一个POST加入购物车
 */
+ (void)wu_postAddShopCarWithparams:(ZWAddShopCarParams *)params
                            success:(void (^)(ZWAddOrDeleteShopCarStatus *shopCarStatus))success
                            failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求查看购物车
 */
+ (void)wu_getCheckShopCarSuccess:(void (^)(NSArray *array))success
                          failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST删除购物车商品
 */
+ (void)wu_postDeleteShopCarWithparams:(ZWDeleteShopCarItems *)params
                               success:(void (^)(ZWAddOrDeleteShopCarStatus *shopCarStatus))success
                               failure:(void (^)(NSError *error))failure;

@end
