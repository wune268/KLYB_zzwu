//
//  ZWTaBar.m
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWTaBar.h"
#import "ZWTaBarButton.h"

@interface ZWTaBar()

@property(nonatomic,strong)ZWTaBarButton *selectBtn;

@end

@implementation ZWTaBar

-(void)addTabBarButtonItem:(UITabBarItem *)item
{
    //    创建按钮
    ZWTaBarButton *btn = [[ZWTaBarButton alloc]init];
    [self addSubview:btn];
    
    //    设置数据
    btn.item = item;
    
    [btn addTarget:self action:@selector(wu_BtnClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count == 1) {
        [self wu_BtnClick:btn];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnY =0;
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i ++) {
        ZWTaBarButton *btn = self.subviews[i];
        CGFloat btnX = i * btnW;
        btn.tag = i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
}

-(void)wu_BtnClick:(ZWTaBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(wu_tabBar:didSelectItemFrom:To:)]) {
        [self.delegate wu_tabBar:self didSelectItemFrom:self.selectBtn.tag To:button.tag];
    }
    self.selectBtn.selected = NO;
    button.selected = YES;
    self.selectBtn = button;
}

@end
