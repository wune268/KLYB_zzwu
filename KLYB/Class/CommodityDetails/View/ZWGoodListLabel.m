//
//  ZWGoodListLabel.m
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodListLabel.h"

@implementation ZWGoodListLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:10];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor redColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
