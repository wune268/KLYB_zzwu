//
//  ZWMeItem.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMeItem.h"

@implementation ZWMeItem

+(instancetype) itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ZWMeItem *item = [self itemWithTitle:title];
    item.icon = icon;
    return item;
}

+(instancetype) itemWithTitle:(NSString *)title
{
    ZWMeItem *item = [[self alloc] init];
    item.title = title;
    return item;
}

@end
