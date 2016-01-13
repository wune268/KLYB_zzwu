//
//  ZWEnlargeHeader.h
//  KLYB
//
//  Created by ZZWU on 16/1/11.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWEnlargeHeader : NSObject

/**
 *  生成一个CExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 对象
 */
+ (instancetype)wu_enlargeWithScrollView:(UIScrollView *)scrollView enlargeView:(UIView *)enlargeView;


#pragma mark - 成员方法
/**
 *
 *
 *  @param scrollView
 *  @param expandView
 */
- (void)wu_enlargeWithScrollView:(UIScrollView *)scrollView enlargeView:(UIView *)enlargeView;

/**
 *  监听scrollViewDidScroll方法
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
