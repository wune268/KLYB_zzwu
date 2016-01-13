//
//  ZWKLYBHttpTool.h
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWKLYBHttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_postWithURL:(NSString *)url
                params:(NSDictionary *)params
               success:(void (^)(id json))success
               failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  文件参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_postWithURL:(NSString *)url
                params:(NSDictionary *)params
         formDataArray:(NSArray *)formDataArray
               success:(void (^)(id json))success
               failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)wu_getWithURL:(NSString *)url
               params:(NSDictionary *)params
              success:(void (^)(id json))success
              failure:(void (^)(NSError *error))failure;

@end


/**
 *  用来封装文件数据的模型
 */
@interface ZWFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
