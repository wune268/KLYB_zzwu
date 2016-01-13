//
//  ZWBrandGroup.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWBrandGroup.h"
#import "ZWBrandItems.h"

@implementation ZWBrandGroup

//+ (instancetype)groupWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init]) {
//        // 赋值标题
//        self.title = dict[@"title"];
//        
//        // 取出原来的字典数组
//        NSArray *dictArray = dict[@"brand"];
//        NSMutableArray *brandArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            STBrandItems *brand = [STBrandItems itemsWithDict:dict];
//            [brandArray addObject:brand];
//        }
//        self.brand = brandArray;
//    }
//    return self;
//}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"brands" : @"ZWBrandItems"
             };
}

@end
