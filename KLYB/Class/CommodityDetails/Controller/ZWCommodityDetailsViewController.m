//
//  ZWCommodityDetailsViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCommodityDetailsViewController.h"
#import "ZWCommodityDetailsHeadView.h"
#import "ZWEvaluateCell.h"
#import "ZWEvaluateItems.h"
#import "ZWShopCarViewController.h"
#import "ZWUserLoginViewController.h"
#import "ZWNavigationController.h"
#import "ZWCommodityHttpTool.h"
#import "ZWCommodityDetails.h"
#import "ZWEvaluateFrame.h"
#import "ZWEvaluateDetailsViewController.h"
#import "ZWCommodityParams.h"
#import "ZWAddShopCarParams.h"
#import "ZWShopCarHttpTool.h"
#import "ZWAddOrDeleteShopCarStatus.h"
#import "ZWUserAccount.h"
#import "ZWAccountTool.h"

@interface ZWCommodityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIWebView *webView;
@property(nonatomic,weak)UIView *bgView;
@property(nonatomic,weak)UIScrollView *scrollView;

@property (nonatomic,strong) ZWCommodityDetails *commodityDetails;
@property(nonatomic,strong) NSArray *evaluatelGroup;
//@property(nonatomic,weak) CAShapeLayer *shaperLayer;

@end

@implementation ZWCommodityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wu_addMainView];
    
    [self wu_sendNetRequest];
    
    [self wu_creatRightButton];
    
    [self wu_creatToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wu_LoginSuccuss:) name:@"LoginSuccuss" object:nil];
}

- (NSArray *)evaluatelGroup
{
    if (_evaluatelGroup == nil) {
        _evaluatelGroup = [NSArray array];
    }
    return _evaluatelGroup;
}

- (void)wu_addMainView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.bgView = bgView;
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    self.scrollView = scrollView;
    self.scrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height * 2);
    //设置分页效果
    self.scrollView.pagingEnabled = YES;
    //禁用滚动
    self.scrollView.scrollEnabled = NO;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 108) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    [self.tableView setRowHeight:110];
    
//    STCommodityDetailsHeadView *commodityDetailsHeadView = [[STCommodityDetailsHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 330) commodityArray:self.groupArray];
//    self.tableView.tableHeaderView = commodityDetailsHeadView;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, 20)];
    footLabel.text = @"上拉查看详情哦";
    footLabel.textAlignment = NSTextAlignmentCenter;
    [footView addSubview:footLabel];
    self.tableView.tableFooterView = footView;
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height + 64, Screen_Width, self.tableView.frame.size.height)];
    web.delegate = self;
    self.webView = web;
    web.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.scrollView];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.webView];
    
    __weak typeof(self)myself = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //上拉，执行对应的操作---改变底层滚动视图的滚动到对应位置
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            myself.scrollView.contentOffset = CGPointMake(0, Screen_Height - 108);
        } completion:^(BOOL finished) {
            //结束加载
            [myself.tableView.mj_footer endRefreshing];
        }];
    }];
    
    //设置UIWebView 有下拉操作
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            myself.scrollView.contentOffset = CGPointMake(0, -64);
        } completion:^(BOOL finished) {
            //结束加载
            [myself.webView.scrollView.mj_header endRefreshing];
        }];
    }];
}

- (void) wu_sendNetRequest
{
    __weak typeof(self)myself = self;
    [ZWCommodityHttpTool wu_getShopWithParams:_commodityParams success:^(ZWCommodityDetails *commodityDetails) {
        ZWCommodityDetailsHeadView *commodityDetailsHeadView = [[ZWCommodityDetailsHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 390) commodityDetails:commodityDetails];
        myself.tableView.tableHeaderView = commodityDetailsHeadView;
        myself.commodityDetails = commodityDetails;
        myself.evaluatelGroup = commodityDetails.shop_EvList;
        NSMutableArray *itemsArray = [NSMutableArray array];
        for (ZWEvaluateItems *items in myself.evaluatelGroup) {
            ZWEvaluateFrame *itemsFrame = [[ZWEvaluateFrame alloc] init];
            // 传递模型数据
            itemsFrame.evaluateItems = items;
//            NSLog(@"%@",items.user_Depict);
            [itemsArray addObject:itemsFrame];
        }
//        [self.evaluatelGroup removeAllObjects];
        myself.evaluatelGroup = itemsArray;
//        NSLog(@"eeee%@",self.evaluatelGroup);
        [myself.tableView reloadData];
        
//        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
//        UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, Screen_Width, 20)];
////        footButton.text = @"上拉有惊喜哦";
//        [footButton setTitle:@"查看更多评论" forState:UIControlStateNormal];
//        [footButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [footButton addTarget:myself action:@selector(wu_getMostComment) forControlEvents:UIControlEventTouchUpInside];
//        footButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [footView addSubview:footButton];
//        myself.tableView.tableFooterView = footView;
        [myself.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app/v1/item/ajax/desc?id=%d",httpAddress,[self.commodityDetails.shop_ID intValue]]]]];

    } failure:^(NSError *error) {
        WuLog(@"网络错误");
    }];
}

- (void)wu_creatRightButton
{
    //    购物与分享
    UIButton *btnShare = [UIButton buttonWithType:0];
    btnShare.frame = CGRectMake(Screen_Width - 50, 10, 40, 40);
    btnShare.backgroundColor=[UIColor clearColor];
    [btnShare addTarget:self action:@selector(wu_shareButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnShare setImage:[UIImage imageNamed:@"G_shareSelected"] forState:0];
    
    UIButton *btnGoShop = [UIButton buttonWithType:0];
    btnGoShop.frame = CGRectMake(Screen_Width - 50 * 2, 10, 40, 40);
    btnGoShop.backgroundColor=[UIColor clearColor];
    [btnGoShop addTarget:self action:@selector(wu_goShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
    [btnGoShop setImage:[UIImage imageNamed:@"marked_right_tag_shopcart"] forState:0];
    
    [self.scrollView addSubview:btnGoShop];
    [self.scrollView addSubview:btnShare];
}

-(void)wu_getMostComment
{
    WuLog(@"加载更多评论");
    ZWEvaluateDetailsViewController *evaluateDetailsViewController = [[ZWEvaluateDetailsViewController alloc] init];
    evaluateDetailsViewController.title = @"评价详情";
    ZWCommodityParams *params = [[ZWCommodityParams alloc] init];
    params.commodityID = self.commodityDetails.shop_ID;
    params.rows = @(20);
    evaluateDetailsViewController.params = params;
    [self.navigationController pushViewController:evaluateDetailsViewController animated:YES];
}

#pragma 下方加入购物车与结算
-(void)wu_creatToolBar
{
    UIView *view_bar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height - 44, Screen_Width, 44)];
    view_bar.backgroundColor = [UIColor whiteColor];
    view_bar.layer.borderColor = [UIColor colorWithRed:.9 green:.9  blue:.9  alpha:1.0].CGColor;
    view_bar.layer.borderWidth = 3;
    
    UIButton *addShopCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width * 0.5, 44)];
    [addShopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    addShopCarBtn.backgroundColor=[UIColor orangeColor];
    [addShopCarBtn addTarget:self action:@selector(wu_addShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:addShopCarBtn];
    
    UIButton *btnShop = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width * 0.5, 0, Screen_Width * 0.5, 44)];
    btnShop.backgroundColor=[UIColor redColor];
    [btnShop setTitle:@"去结算" forState:UIControlStateNormal];
    [btnShop addTarget:self action:@selector(wu_goShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnShop];
    [self.bgView addSubview:view_bar];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app/v1/item/ajax/desc?id=%d",httpAddress,[self.commodityDetails.shop_ID intValue]]]]];
//    WuLog(@"%@",[NSString stringWithFormat:@"%@app/v1/item/ajax/desc?id=%@",httpAddress,self.commodityDetails]);
//}

//-(void)startAnimationWithRect:(CGRect)rect //imageView:(UIImageView *)imageView
//{
//    if (!_layer) {
//        //        _btn.enabled = NO;
//        _layer = [CALayer layer];
//        _layer.contents = (id)self.view.layer.contents;
//        
//        _layer.contentsGravity = kCAGravityResizeAspectFill;
//        _layer.bounds = rect;
////        [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
////        _layer setCornerRadius:
////        _layer.masksToBounds = YES;
//        // 导航64
//        _layer.position = CGPointMake(self.view.center.x, CGRectGetMidY(rect));
//        //        [_tableView.layer addSublayer:_layer];
//        [self.view.layer addSublayer:_layer];
//        self.path = [UIBezierPath bezierPath];
//        [_path moveToPoint:_layer.position];
//        //        (SCREEN_WIDTH - 60), 0, 50, 50)
//        [_path addQuadCurveToPoint:CGPointMake(Screen_Width - 80, 75) controlPoint:CGPointMake(Screen_Height / 2,rect.origin.y - 80)];
//        //        [_path addLineToPoint:CGPointMake(SCREEN_WIDTH-40, 30)];
//    }
//    [self groupAnimation];
//}
//
//-(void)groupAnimation
//{
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animation.path = _path.CGPath;
//    animation.rotationMode = kCAAnimationRotateAuto;
//    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    expandAnimation.duration = 0.5f;
//    expandAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
//    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    
//    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    narrowAnimation.beginTime = 0.5;
//    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
//    narrowAnimation.duration = 1.5f;
//    narrowAnimation.toValue = [NSNumber numberWithFloat:0.3f];
//    
//    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    CAAnimationGroup *groups = [CAAnimationGroup animation];
//    groups.animations = @[animation,expandAnimation,narrowAnimation];
//    groups.duration = 2.0f;
//    groups.removedOnCompletion=NO;
//    groups.fillMode=kCAFillModeForwards;
//    groups.delegate = self;
//    [_layer addAnimation:groups forKey:@"group"];
//}
//
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    //    [anim def];
//    if (anim == [_layer animationForKey:@"group"]) {
//        [_layer removeFromSuperlayer];
//        _layer = nil;
//        CATransition *animation = [CATransition animation];
//        animation.duration = 0.25f;
////        _cntLabel.text = [NSString stringWithFormat:@"%ld",(long)_cnt];
////        [_cntLabel.layer addAnimation:animation forKey:nil];
//        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//        shakeAnimation.duration = 0.25f;
//        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
//        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
//        shakeAnimation.autoreverses = YES;
////        [_btn.layer addAnimation:shakeAnimation forKey:nil];
//    }
//}

# pragma Mark - 以前代码
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self creatTableView];
//    
//    [self creatRightButton];
//    
//    [self creatToolBar];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccuss:) name:@"LoginSuccuss" object:nil];
//}

- (void)dealloc
{
    WuLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void) creatTableView
//{
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 44)];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
//    
//    STCommodityDetailsHeadView *commodityDetailsHeadView = [[STCommodityDetailsHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 330)];
//    self.tableView.tableHeaderView = commodityDetailsHeadView;
//}

//- (void)creatRightButton
//{
////    购物与分享
//    UIButton *btnShare = [UIButton buttonWithType:0];
//    btnShare.frame = CGRectMake(Screen_Width - 50, 64 + 10, 40, 40);
//    btnShare.backgroundColor=[UIColor clearColor];
//    [btnShare addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
//    [btnShare setImage:[UIImage imageNamed:@"G_shareSelected"] forState:0];
//    
//    UIButton *btnGoShop = [UIButton buttonWithType:0];
//    btnGoShop.frame = CGRectMake(Screen_Width - 50 * 2, 64 + 10, 40, 40);
//    btnGoShop.backgroundColor=[UIColor clearColor];
//    [btnGoShop addTarget:self action:@selector(goShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
//    [btnGoShop setImage:[UIImage imageNamed:@"marked_right_tag_shopcart"] forState:0];
//    
//    [self.view addSubview:btnGoShop];
//    [self.view addSubview:btnShare];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.evaluatelGroup.count; //> 3 ? 3 : self.evaluatelGroup.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWEvaluateCell *cell = [ZWEvaluateCell wu_cellWithtableView:tableView];
//    ZWEvaluateItems *items = self.evaluatelGroup[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZWEvaluateFrame *itemsFrame = self.evaluatelGroup[indexPath.row];
    cell.itemsFrame = itemsFrame;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"评论   共%@条", self.commodityDetails.shop_EvaluateNum];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
    UILabel *headerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
    headerTitle.text = [NSString stringWithFormat:@"评论   共%@条", self.commodityDetails.shop_EvaluateNum];
    [headerView addSubview:headerTitle];
    
    UIButton *mostCommentButton = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 110, 5, 100, 20)];
    [mostCommentButton setTitle:@"查看更多" forState:UIControlStateNormal];
    [mostCommentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [mostCommentButton addTarget:self action:@selector(wu_getMostComment) forControlEvents:UIControlEventTouchUpInside];
    mostCommentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:mostCommentButton];
    
    return headerView;
}

//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"上拉有惊喜哦";
//}

#warning
//#pragma 下方加入购物车与结算
//-(void)creatToolBar
//{
//    UIView *view_bar = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height - 44, Screen_Width, 44)];
//    view_bar.backgroundColor = [UIColor whiteColor];
//    view_bar.layer.borderColor = [UIColor colorWithRed:.9 green:.9  blue:.9  alpha:1.0].CGColor;
//    view_bar.layer.borderWidth = 3;
//
//    UIButton *addShopCarBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Screen_Width * 0.5, 44)];
//    [addShopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
//    addShopCarBtn.backgroundColor=[UIColor orangeColor];
//    [addShopCarBtn addTarget:self action:@selector(addShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:addShopCarBtn];
//    
//    UIButton *btnShop = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width * 0.5, 0, Screen_Width * 0.5, 44)];
//    btnShop.backgroundColor=[UIColor redColor];
//    [btnShop setTitle:@"去结算" forState:UIControlStateNormal];
//    [btnShop addTarget:self action:@selector(goShopCarButton:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:btnShop];
//    [self.scrollView addSubview:view_bar];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWEvaluateFrame *itemsFrame = self.evaluatelGroup[indexPath.row];
    return itemsFrame.cellHeight;
}

//分享
-(void)wu_shareButton:(id)sender
{
    WuLog(@"分享");
}

//添加购物车
-(void)wu_addShopCarButton:(UIButton *)button
{
    WuLog(@"商品成功添加购物车！");
    
    ZWUserLoginViewController *userLoginViewController = [[ZWUserLoginViewController alloc] init];
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:userLoginViewController];
    
    
    UIAlertController *addShopCarController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"添加成功！现在前往购物车？" preferredStyle:UIAlertControllerStyleAlert];
    
    ZWAddShopCarParams *shopCarParams = [[ZWAddShopCarParams alloc] init];
    shopCarParams.itemId = self.commodityDetails.shop_ID;
    shopCarParams.number = @(1);
    
//    [ZWAccountTool account];
    __weak typeof(self)myself = self;
    [ZWShopCarHttpTool wu_postAddShopCarWithparams:shopCarParams success:^(ZWAddOrDeleteShopCarStatus *shopCarStatus) {
        switch ([shopCarStatus.code integerValue]) {
            case 1000:
                WuLog(@"登录失败,请登录");
                [myself.navigationController presentViewController:nav animated:YES completion:nil];

                break;
            case 1001:
                WuLog(@"加入成功");
                [addShopCarController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [addShopCarController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self wu_goShopCarButton:nil];
                }]];
                
                [self.navigationController presentViewController:addShopCarController animated:YES completion:nil];

                break;
                
//            default:
//                break;
        }
//        [addShopCarController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//        [addShopCarController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self wu_goShopCarButton:nil];
//        }]];
//        
//        [self.navigationController presentViewController:addShopCarController animated:YES completion:nil];
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
}

-(void)wu_LoginSuccuss:(NSNotification *)notification
{
    ZWAddShopCarParams *shopCarParams = [[ZWAddShopCarParams alloc] init];
    shopCarParams.itemId = self.commodityDetails.shop_ID;
    shopCarParams.number = @(1);
    
    [ZWShopCarHttpTool wu_postAddShopCarWithparams:shopCarParams success:^(ZWAddOrDeleteShopCarStatus *shopCarStatus) {
        WuLog(@"加入成功");
    } failure:^(NSError *error) {
        WuLog(@"加入失败");
    }];
    
    UIAlertController *addShopCarController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"添加成功！现在前往购物车？" preferredStyle:UIAlertControllerStyleAlert];
    
    [addShopCarController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [addShopCarController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self wu_goShopCarButton:nil];
    }]];
    
    [self.navigationController presentViewController:addShopCarController animated:YES completion:^{
        
    }];
}

//- (void)commodityDetailsFootView:(STCommodityDetailsFootView *)commodityDetailsFootView buttonDidClick:(UIButton *)button
//{
//    switch (button.tag) {
//        case 0: // 加入购物车
//            [self addShopCar];
//            break;
//            
//        case 1: // 去结算
//            [self goShopCar];
//            break;
//            
//        default:
//            break;
//    }
//}

//去购物车
-(void)wu_goShopCarButton:(UIButton *)button
{
    ZWShopCarViewController *shopCarViewController = [[ZWShopCarViewController alloc] init];
    shopCarViewController.tableViewFrameHight = Screen_Height;
    shopCarViewController.title = @"购物车";
    [self.navigationController pushViewController:shopCarViewController animated:YES];
}

@end
