//
//  ZWBrandTttpTool.m
//  KLYB
//
//  Created by ZZWU on 16/1/8.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWBrandTttpTool.h"
#import "ZWBrandGroup.h"

@implementation ZWBrandTttpTool

+ (void)wu_getBrandListSuccess:(void (^)(NSArray *))success
                       failure:(void (^)(NSError *))failure
{
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/brand/list", httpAddress] params:nil success:^(id json) {
        if (success) {
            NSMutableArray *brandGroup = [ZWBrandGroup mj_objectArrayWithKeyValuesArray:json];
            success(brandGroup);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
