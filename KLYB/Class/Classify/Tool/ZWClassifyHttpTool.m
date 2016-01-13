//
//  ZWClassifyHttpTool.m
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWClassifyHttpTool.h"
#import "ZWClassifyGroup.h"

@implementation ZWClassifyHttpTool

/**
 *  滚动图片
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getClassSuccess:(void (^)(NSArray *array))success
                   failure:(void (^)(NSError *))failure
{
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/cate/list", httpAddress] params:nil success:^(id json) {
        if (success) {
//            NSLog(@"%@",json);
            NSMutableArray *classifyGroup = [NSMutableArray array];
            classifyGroup = [ZWClassifyGroup mj_objectArrayWithKeyValuesArray:json];
            success(classifyGroup);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
