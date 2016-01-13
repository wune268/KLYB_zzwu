//
//  ZWPayMentLabel.m
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWPayMentLabel.h"

@implementation ZWPayMentLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor grayColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
