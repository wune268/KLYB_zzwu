//
//  ZWBrandTttpTool.h
//  KLYB
//
//  Created by ZZWU on 16/1/8.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWBrandTttpTool : NSObject

/**
 *  获取品牌列表
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getBrandListSuccess:(void (^)(NSArray *array))success
                       failure:(void (^)(NSError *error))failure;

@end
