//
//  ZWAccountListHttpTool.m
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWAccountListHttpTool.h"
#import "ZWAccountParams.h"
#import "ZWAccountOrderResultItems.h"
#import "ZWBuildListParams.h"
#import "ZWPaymentProduct.h"

@implementation ZWAccountListHttpTool

+ (void)wu_getAccountListWithParams:(ZWAccountParams *)params
                            success:(void (^)(ZWAccountOrderResultItems *))success
                            failure:(void (^)(NSError *))failure
{
    NSDictionary *accountParams = [params mj_keyValues];
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/order/confirm", httpAddress] params:accountParams success:^(id json) {
        if (success) {
            WuLog(@"%@--json",json);
            ZWAccountOrderResultItems *items = [ZWAccountOrderResultItems mj_objectWithKeyValues:json];
            success(items);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)wu_postBuildAccountListWithParams:(ZWBuildListParams *)params
                                 success:(void (^)(ZWPaymentProduct *))success
                                 failure:(void (^)(NSError *))failure
{
    NSDictionary *buildListParams = [params mj_keyValues];
    [ZWKLYBHttpTool wu_postWithURL:[NSString stringWithFormat:@"%@app/v1/order/add", httpAddress] params:buildListParams success:^(id json) {
        if (success) {
            WuLog(@"%@--json",json);
            ZWPaymentProduct *items = [ZWPaymentProduct mj_objectWithKeyValues:json];
            success(items);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
