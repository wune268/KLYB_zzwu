//
//  ZWPayStyleItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWPayStyleItems.h"

@implementation ZWPayStyleItems

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
    return [NSString stringWithFormat:@"%@", self.name];
}

@end
