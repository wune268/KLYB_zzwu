//
//  ZWAccountProduct.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountProduct.h"

@implementation ZWAccountProduct

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
