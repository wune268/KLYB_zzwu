//
//  ZWThemePavilionButton.m
//  KLYB
//
//  Created by ZZWU on 15/12/17.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWThemePavilionButton.h"
#import "ZWThemePavilion.h"

//@interface ZWThemePavilionButton ()
//
///**
// *  图片
// */
//@property(nonatomic,weak)UIImageView *iconView;
//
///**
// *  名字
// */
//@property(nonatomic,weak)UILabel *Labletext;
//
///**
// *  描述
// */
//@property(nonatomic,weak)UILabel *describe;
//
//@end

@implementation ZWThemePavilionButton

+ (instancetype)buttonWithFrame:(CGRect)frame
                  themePavilion:(ZWThemePavilion *)themePavilion
{
    return [[self alloc] initWithFrame:frame themePavilion:themePavilion];
}

- (instancetype)initWithFrame:(CGRect)frame
                themePavilion:(ZWThemePavilion *)themePavilion
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageviewW = frame.size.height - 10;
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, imageviewW, imageviewW)];
//        imageview.image = [UIImage imageNamed:themePavilion.icon];
//        self.iconView = iconView;
        [iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@,%@",httpResourcesAddress, themePavilion.imgUrl]] placeholderImage:[UIImage imageNamed:@"muying"]];
        [self addSubview:iconView];
        
        CGFloat LabletextX = iconView.frame.size.width + 5 * 2;
        CGFloat LabletextW = frame.size.width - LabletextX - 5;
        CGFloat LabletextY = iconView.frame.origin.y;
        CGFloat LabletextH = (iconView.frame.size.height - 5) * 0.5;
        
        UILabel *Labletext = [[UILabel alloc] initWithFrame:CGRectMake(LabletextX, LabletextY, LabletextW, LabletextH)];
//        Labletext.text = themePavilion.mainText;
//        self.Labletext = Labletext;
        
        Labletext.text = themePavilion.name;
        [self addSubview:Labletext];
        
        UILabel *describe = [[UILabel alloc] initWithFrame:CGRectMake(LabletextX, LabletextH + 10, LabletextW, LabletextH)];
//        describe.text = themePavilion.describeTxet;
        describe.textColor = [UIColor grayColor];
        describe.font = [UIFont systemFontOfSize:13];
//        self.describe = describe;
        
        describe.text = themePavilion.remark;
        [self addSubview:describe];
    }
    return self;
}

//- (void)setThemePavilion:(ZWThemePavilion *)themePavilion
//{
//    _themePavilion = themePavilion;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@,%@",httpResourcesAddress, themePavilion.imgUrl]] placeholderImage:[UIImage imageNamed:@"muying"]];
//    self.Labletext.text = themePavilion.name;
//    self.describe.text = themePavilion.remark;
//}

@end
