//
//  ZWEnlargeHeader.m
//  KLYB
//
//  Created by ZZWU on 16/1/11.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWEnlargeHeader.h"

#define ZWEnlargeContentOffset @"contentOffset"

@interface ZWEnlargeHeader ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollView;
@property (nonatomic, weak)UIView *enlargeView;
@property (nonatomic, assign)CGFloat enlargeHeight;

@end

@implementation ZWEnlargeHeader

- (void)dealloc{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:ZWEnlargeContentOffset];
        _scrollView = nil;
    }
    _enlargeView = nil;
}

+ (instancetype)wu_enlargeWithScrollView:(UIScrollView *)scrollView enlargeView:(UIView *)enlargeView
{
    ZWEnlargeHeader *enlargeHeader = [[ZWEnlargeHeader alloc] init];
    [enlargeHeader wu_enlargeWithScrollView:scrollView enlargeView:enlargeView];
    return enlargeHeader;
}

- (void)wu_enlargeWithScrollView:(UIScrollView *)scrollView enlargeView:(UIView *)enlargeView
{
    
    self.enlargeHeight = CGRectGetHeight(enlargeView.frame);
    
    _scrollView = scrollView;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.enlargeHeight, 0, 0, 0);
    [self.scrollView insertSubview:enlargeView atIndex:0];
    [self.scrollView addObserver:self forKeyPath:ZWEnlargeContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView setContentOffset:CGPointMake(0, -180)];
    
    _enlargeView = enlargeView;
    
    //使View可以伸展效果  重要属性
    self.enlargeView.contentMode= UIViewContentModeScaleAspectFill;
    self.enlargeView.clipsToBounds = YES;
    
    [self reSizeView];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:ZWEnlargeContentOffset]) {
        return;
    }
    [self scrollViewDidScroll:self.scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < self.enlargeHeight * -1) {
        CGRect currentFrame = self.enlargeView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        self.enlargeView.frame = currentFrame;
    }
    
}

- (void)reSizeView{
    
    //重置_expandView位置
    [self.enlargeView setFrame:CGRectMake(0, -1 * self.enlargeHeight, CGRectGetWidth(self.enlargeView.frame), self.enlargeHeight)];
    
}


@end
