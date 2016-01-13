//
//  ZWHomeView.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWHomeView.h"
#import "ZWScrollerView.h"
#import "ZWActivity.h"
#import "UIButton+WebCache.h"
#import "ZWThemePavilion.h"
#import "ZWThemePavilionButton.h"

@interface ZWHomeView ()<ZWScrollerViewDelegate>

//@property(nonatomic,weak)UrlImageButton *fourBtn;
//@property(nonatomic,weak)UILabel *fourLab;
//@property(nonatomic,weak)UIView *viewToday;

//@property(nonatomic,retain)NSDictionary *data;
//@property(nonatomic,retain)NSMutableArray *newsArray;
//@property(nonatomic,retain)NSMutableArray *_marray_updateDate;//更新时间
//@property(nonatomic,retain)NSMutableArray *_mainHead_marray;//订标题
//@property(nonatomic,retain)NSMutableArray *_subHead_marray;//副标题
//@property(nonatomic,retain)NSMutableArray *_createDate_marray;//创建时间
//@property(nonatomic,retain)NSMutableArray *_filePath_marray;// 图片路径
//@property(nonatomic,retain)NSMutableArray *_scrolFilePath_marray;//导航图片路径
//@property(nonatomic,strong)NSArray *scrol_marray;//焦点数组
//@property(nonatomic,strong)NSArray *todayHot_marray;//导航图片路径

@end

@implementation ZWHomeView

- (instancetype)initWithFrame:(CGRect)frame
                     activity:(NSArray *)activity
                themePavilion:(NSArray *)themePavilion
{
    self = [super initWithFrame:frame];
    if (self) {
        [self wu_drawViewRect:frame activity:activity themePavilion:themePavilion];
    }
    return self;
}

-(void)wu_drawViewRect:(CGRect)frame
              activity:(NSArray *)activity
         themePavilion:(NSArray *)themePavilion
{
    //    首页滚动背景
    
    ZWScrollerView *scrollerView=[[ZWScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, frame.size.width, 160) scrolArray:activity type:0];
    scrollerView.delegate = self;
    scrollerView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollerView];
    //    风格
//    NSInteger countFG = hotToday.count;
    
    CGFloat imageViewY = scrollerView.frame.size.height + scrollerView.frame.origin.y + 10;
//    CGFloat btnW = 90;
//    CGFloat btnH = 70;
//    CGFloat labelW = btnW;
//    CGFloat labelH = 20;
//    CGFloat labelY = btnH + btnY + 5;
//    
//    for (int i = 0; i < countFG; i ++)
//    {
//        ZWTodayHot *todayHot = hotToday[i];
//        CGFloat padding = (frame.size.width - countFG * btnW) / (countFG + 1);
//        CGFloat btnX = (padding + btnW) * i + padding;
//        
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
////        [btn setImage:[UIImage imageNamed:@"default_02.png"] forState:0];
//        [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, todayHot.imgUrl]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_02.png"]];
//        [self addSubview:btn];
//        [btn addTarget:self action:@selector(btnFenlei:) forControlEvents:UIControlEventTouchUpInside];
//        btn.backgroundColor=[UIColor clearColor];
//        
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btnX, labelY, labelW, labelH)];
////        label.text=@"新品装|New";
//        label.text = todayHot.name;
//        label.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
//        label.font=[UIFont systemFontOfSize:12];
//        label.textAlignment = 1;
//        label.backgroundColor=[UIColor clearColor];
//        
//        [self addSubview:label];
//    }
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,imageViewY , frame.size.width, 30)];
//    imageView.image = [UIImage imageNamed:@"titlebar"];
//    imageView.backgroundColor=[UIColor clearColor];
//    [self addSubview:imageView];
    UILabel *imageView = [[UILabel alloc]initWithFrame:CGRectMake(0 ,imageViewY , frame.size.width, 30)];
//    imageView.image = [UIImage imageNamed:@"titlebar"];
    imageView.textAlignment = NSTextAlignmentCenter;
    imageView.text = [NSString stringWithFormat:@"主题馆"];
    imageView.backgroundColor=[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    [self addSubview:imageView];

    
    //    分类
//    NSInteger countFL = hotToday.count;
    
//    hotToday.count < 6 ? countFL = hotToday.count : countFL = 6;
    
    CGFloat padding = 5;
    CGFloat btnH = 60;
    CGFloat btnY = 0.0;
    
    CGFloat btnW = (frame.size.width - 3 * padding) * 0.5;
    
    for (int i = 0; i < themePavilion.count; i++)
    {
        ZWThemePavilion *tPavilion = themePavilion[i];
        
        CGFloat btnX = (padding + btnW) * (i % 2) + padding;
        
        CGFloat paddingY = 5;
        
        btnY = (imageView.frame.origin.y + imageView.frame.size.height + 10) + (paddingY + btnH) * (i / 2);
        
        ZWThemePavilionButton *btn = [ZWThemePavilionButton buttonWithFrame:CGRectMake(btnX, btnY, btnW, btnH) themePavilion:tPavilion];
        [btn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
        [self addSubview:btn];
        
        btn.tag = 10 + i;
        
//        NSLog(@"btnY--%f",btnY);
    }
//    CGFloat ViewY = 60 + btnY + 10;
//    NSLog(@"ViewY--%f",ViewY);
    
}

//-(void)setActivity:(ZWActivity *)activity
//{
//    _activity = activity;
//}
//
//-(void)setTodayHot:(ZWTodayHot *)todayHot
//{
//    _todayHot = todayHot;
//}

- (void)wu_scrollerViewDidClicked:(NSUInteger)index activity:(ZWActivity *)activity
{
    [self wu_notificationDelegateWithTag:index activity:activity];
    
}

-(void)btnShopStore:(id)sender
{
    UIButton *button = sender;
    [self wu_notificationDelegateWithTag:button.tag activity:nil];
}

//-(void)btnFenlei:(id)sender
//{
////    NSLog(@"btnFenlei");
//    UIButton *button = sender;
//    [self notificationDelegateWithTag:button.tag];
//}

- (void)wu_notificationDelegateWithTag:(NSInteger)index activity:(ZWActivity *)activity
{
    if ([self.delegate respondsToSelector:@selector(wu_homeView:buttonDidClick:activity:)]) {
        [self.delegate wu_homeView:self buttonDidClick:index activity:activity];
    }
}

@end
