//
//  ZWClassifyHttpTool.h
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWClassifyHttpTool : NSObject

/**
 *  滚动图片
 *
 *  @param success 成功返回模型数组
 *  @param failure 失败回调参数
 */
+ (void)wu_getClassSuccess:(void (^)(NSArray *array))success
                   failure:(void (^)(NSError *error))failure;

@end
