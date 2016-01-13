//
//  ZWAddressModel.m
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAddressModel.h"

@implementation ZWAddressModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.region,self.province,self.city,self.area];
}

@end
