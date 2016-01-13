//
//  ZWHomeItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWHomeItems.h"

@implementation ZWHomeItems

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

@end
