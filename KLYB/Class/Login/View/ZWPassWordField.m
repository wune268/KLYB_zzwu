//
//  ZWPassWordField.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWPassWordField.h"

@implementation ZWPassWordField

- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[ZWPassWordField alloc] initWithFrame:frame];
        self.placeholder = placeholder;
        self.secureTextEntry = YES;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.returnKeyType = UIReturnKeyNext;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

+ (instancetype)passWordWithFrame:(CGRect)frame
                      placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithFrame:frame placeholder:placeholder];
}

@end
