//
//  ZWGoodsInfoCarItems.m
//  KLYB
//
//  Created by ZZWU on 15/12/10.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodsInfoCarItems.h"

@implementation ZWGoodsInfoCarItems

//-(instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    return self;
//}
//
//+(instancetype)itemsWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"goodsID" : @"id",
             @"goodsTitle" : @"name",
             @"goodsPrice" : @"price",
             @"goodsNum" : @"number",             
             @"goodsOriginalPrice" : @"originalPrice",
             @"imageURL" : @"imgUrl"
             };
}

@end
