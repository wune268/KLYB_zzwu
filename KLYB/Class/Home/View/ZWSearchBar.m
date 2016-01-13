//
//  ZWSearchBar.m
//  KLYB
//
//  Created by ZZWU on 15/12/17.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWSearchBar.h"

@implementation ZWSearchBar

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

//- (void)layoutSubviews {
//    UITextField *searchField;
////    NSUInteger numViews = [self.subviews count];
////    for(int i = 0; i < numViews; i++)
////    {
////        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]])
////        {
////            searchField = [self.subviews objectAtIndex:i];
////        }
////    }
//    if(!(searchField == nil)) {
//        searchField.textColor = [UIColor redColor];
//        [searchField setBorderStyle:UITextBorderStyleRoundedRect];
//        UIImage *image = [UIImage imageNamed: @"esri.png"];
//        UIImageView *iView = [[UIImageView alloc] initWithImage:image];
//        searchField.leftView = iView;
//    }
//
//    for(UIView *view in  [[[self subviews] objectAtIndex:0] subviews])
//    {
//        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]])
//        {
//            UIButton * cancel = (UIButton *)view;
//            [cancel setTitle:@"取消" forState:UIControlStateNormal];
//        }
//    }
//
//    [super layoutSubviews];
//}

- (void)layoutSubviews
{
    for(UIView *view in  [[[self subviews] objectAtIndex:0] subviews])
    {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]])
        {
            UIButton * cancel = (UIButton *)view;
            [cancel setTitle:@"搜索" forState:UIControlStateNormal];
        }
    }
    //    [self setBackgroundColor:[UIColor grayColor]];
    //    [self setSearchFieldBackgroundImage:[UIImage imageNamed:<#(nonnull NSString *)#>] forState:UIControlStateNormal];
    [self setClipsToBounds:YES];
    [self setShowsCancelButton:YES animated:YES];
    [self setPlaceholder:@"搜索商品"];
    [super layoutSubviews];
}

@end
