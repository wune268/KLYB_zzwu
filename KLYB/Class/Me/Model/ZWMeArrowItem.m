//
//  ZWMeArrowItem.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMeArrowItem.h"

@implementation ZWMeArrowItem

+(instancetype)itemWithIcon:(NSString *)icon
                      title:(NSString *)title
                 destVclass:(__unsafe_unretained Class)destVclass
{
    ZWMeArrowItem *item = [self itemWithIcon:icon title:title];
    item.destVclass = destVclass;
    return item;
}

@end
