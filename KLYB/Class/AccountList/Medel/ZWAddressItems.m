//
//  ZWAddressItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAddressItems.h"

@implementation ZWAddressItems

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)itemsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (NSString *)wu_description
{
    return [NSString stringWithFormat:@"收货人：%@, 联系方式：%@, 收货地址：%@", self.userName, self.userPhone, self.userAddress];
}

@end
