//
//  ZWClipCircleView.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWClipCircleView.h"

@interface ZWClipCircleView ()

/**
 *  圆的半径
 */
@property(nonatomic,assign)CGFloat cornerRadius;

@end

@implementation ZWClipCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    self.cornerRadius = frame.size.width * 0.5;
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
