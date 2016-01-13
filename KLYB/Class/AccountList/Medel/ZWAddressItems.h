//
//  ZWAddressItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWAddressItems : NSObject

@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *userPhone;
@property(nonatomic,copy) NSString *userAddress;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemsWithDict:(NSDictionary *)dict;

- (NSString *)wu_description;

@end
