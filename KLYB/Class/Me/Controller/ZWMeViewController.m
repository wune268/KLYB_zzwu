//
//  ZWMeViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMeViewController.h"
#import "ZWMeArrowItem.h"
#import "ZWMeGroup.h"
#import "ZWMeItem.h"
#import "ZWMeSwitchItem.h"
#import "ZWMeTableViewCell.h"
#import "ZWClipCircleView.h"

#define HeadViewHeight 150

@interface ZWMeViewController ()

@property(nonatomic, weak)UIImageView *headView;
@property(nonatomic,weak)ZWClipCircleView *iconView;
@property(nonatomic,weak)UILabel *userName;

@end

@implementation ZWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wu_creatHeaderView];
    
    [self wu_creatFootView];
    
    [self wu_setupGroup];
    [self wu_setupGroup1];
}

-(void)wu_creatHeaderView
{
    self.tableView.contentInset = UIEdgeInsetsMake(HeadViewHeight, 0, 0, 0);
    
    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -HeadViewHeight, Screen_Width, HeadViewHeight)];
    headView.image = [UIImage imageNamed:@"huo_jiushui"];
    headView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:headView];
    self.headView = headView;
    
    //设置autoresizesSubviews让子类自动布局
    headView.autoresizesSubviews = YES;
    
    ZWClipCircleView *iconView = [[ZWClipCircleView alloc]initWithFrame:CGRectMake(10, HeadViewHeight - 60, 50, 50)];
    iconView.backgroundColor = [UIColor redColor];
    iconView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [headView addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(iconView.frame.size.width + 10 * 2, HeadViewHeight - 40, 280, 20)];
    userName.textColor = [UIColor whiteColor];
    userName.text = @"用户名";
    userName.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [headView addSubview:userName];
    self.userName = userName;
}

- (void)wu_creatFootView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    footView.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    self.tableView.tableFooterView = footView;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [footView addSubview:button];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(wu_returnBackAccount:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)wu_returnBackAccount:(UIButton *)button
{
    WuLog(@"退出");
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y + 64;
    if (y < -HeadViewHeight) {
        CGRect frame = self.headView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        self.headView.frame = frame;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//    设置数据转成模型
- (void)wu_setupGroup
{
//    ZWMeItem *listCenter = [ZWMeItem itemWithTitle:@"订单中心"];
    ZWMeItem *obligation = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"待付款" destVclass:[UIViewController class]];
    ZWMeItem *receiptOfGoods = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"待收货" destVclass:[UIViewController class]];
    ZWMeItem *allOrders = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"全部订单" destVclass:[UIViewController class]];
//    ZWMeItem *canReturnList = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"可退货订单列表" destVclass:[UIViewController class]];
//    ZWMeItem *returnHistory = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"退货历史" destVclass:[UIViewController class]];
    
    ZWMeGroup *group = [[ZWMeGroup alloc] init];
    group.header = @"订单中心";
    group.items = @[obligation, receiptOfGoods, allOrders];
    [self.data addObject:group];
}

//    设置数据转成模型
- (void)wu_setupGroup1
{
    ZWMeItem *obligation = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"待付款" destVclass:[UIViewController class]];
    ZWMeItem *receiptOfGoods = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"待收货" destVclass:[UIViewController class]];
    ZWMeItem *allOrders = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"全部订单" destVclass:[UIViewController class]];
//    ZWMeItem *canReturnList = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"可退货订单列表" destVclass:[UIViewController class]];
//    ZWMeItem *returnHistory = [ZWMeArrowItem itemWithIcon:@"camera_addMarked_selected" title:@"退货历史" destVclass:[UIViewController class]];
    
    ZWMeGroup *group = [[ZWMeGroup alloc] init];
    group.items = @[obligation, receiptOfGoods, allOrders];
    [self.data addObject:group];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
