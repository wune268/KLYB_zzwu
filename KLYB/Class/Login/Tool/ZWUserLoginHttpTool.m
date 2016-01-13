//
//  ZWUserLoginHttpTool.m
//  KLYB
//
//  Created by ZZWU on 16/1/4.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWUserLoginHttpTool.h"
#import "ZWUserLoginKeyItems.h"

@implementation ZWUserLoginHttpTool

+ (void)wu_getKeyWithparams:(NSDictionary *)params
                    success:(void (^)(ZWUserLoginKeyItems *))success
                    failure:(void (^)(NSError *))failure
{
    [ZWKLYBHttpTool wu_getWithURL:[NSString stringWithFormat:@"%@app/v1/ios/security/login",httpAddress] params:params success:^(id json) {
        if (success) {
            ZWUserLoginKeyItems *keyItems = [ZWUserLoginKeyItems mj_objectWithKeyValues:json];
            success(keyItems);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)wu_postCreatWithparams:(NSDictionary *)params
                      success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure
{
   
}

+ (void)wu_postLoginWithparams:(NSDictionary *)params
                       success:(void (^)(id))success
                       failure:(void (^)(NSError *))failure
{
    
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@app/v1/ios/security/loginValidate",httpAddress]]];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"kUserDefaultsCookie"];
    
    [ZWKLYBHttpTool wu_postWithURL:[NSString stringWithFormat:@"%@app/v1/ios/security/loginValidate",httpAddress] params:params success:^(id json) {
        if (success) {
            WuLog(@"%@",json);
            success(json);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
