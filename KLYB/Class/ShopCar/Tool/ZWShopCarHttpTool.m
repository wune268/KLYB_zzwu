//
//  ZWShopCarHttpTool.m
//  KLYB
//
//  Created by ZZWU on 16/1/5.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWShopCarHttpTool.h"
#import "ZWAddShopCarParams.h"
#import "ZWAddOrDeleteShopCarStatus.h"
#import "ZWGoodsInfoCarItems.h"
#import "ZWDeleteShopCarItems.h"

@implementation ZWShopCarHttpTool

+(void)wu_postAddShopCarWithparams:(ZWAddShopCarParams *)params
                           success:(void (^)(ZWAddOrDeleteShopCarStatus *))success
                           failure:(void (^)(NSError *))failure
{
    NSDictionary *paramsDict = [params mj_keyValues];
    [ZWKLYBHttpTool wu_postWithURL:[NSString stringWithFormat:@"%@app/v1/cart/add",httpAddress] params:paramsDict success:^(id json) {
        if (success) {
            ZWAddOrDeleteShopCarStatus *shopCarStatus = [ZWAddOrDeleteShopCarStatus mj_objectWithKeyValues:json];
            WuLog(@"---------------%@",shopCarStatus);
            success(shopCarStatus);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)wu_getCheckShopCarSuccess:(void (^)(NSArray *))success
                         failure:(void (^)(NSError *))failure
{
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/cart",httpAddress] params:nil success:^(id json) {
        if (success) {
            WuLog(@"%@",json);
            NSMutableArray *array  = [ZWGoodsInfoCarItems mj_objectArrayWithKeyValuesArray:json];
            if (array) {
                success(array);
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CantNotCheckShopCar" object:nil userInfo:json];
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)wu_postDeleteShopCarWithparams:(ZWDeleteShopCarItems *)params
                               success:(void (^)(ZWAddOrDeleteShopCarStatus *))success
                               failure:(void (^)(NSError *))failure
{
    NSDictionary *paramsDict = [NSDictionary dictionaryWithObjectsAndKeys:params.itemId,@"id", nil];
    [ZWKLYBHttpTool wu_postWithURL:[NSString stringWithFormat:@"%@app/v1/cart/del",httpAddress] params:paramsDict success:^(id json) {
        if (success) {
            ZWAddOrDeleteShopCarStatus *shopCarStatus = [ZWAddOrDeleteShopCarStatus mj_objectWithKeyValues:json];
            WuLog(@"---------------%@",shopCarStatus);
            success(shopCarStatus);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
