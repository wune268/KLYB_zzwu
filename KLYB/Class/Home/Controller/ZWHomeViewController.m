//
//  ZWHomeViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWHomeViewController.h"
#import "ZWHomeView.h"
#import "ZWCommodityDetailsViewController.h"
#import "ZWHomeTableViewCell.h"
#import "ZWClassIfyingTableViewController.h"
#import "ZWGoodDetailsClassViewController.h"
#import "ZWActivity.h"
#import "ZWTodayHot.h"
#import "ZWColumuItems.h"
#import "ZWItems.h"
#import "ZWThemePavilion.h"
#import "ZWSearchBar.h"
#import "ZWHomeHttpTool.h"
#import "ZWCommodityParams.h"
#import "ZWClassRequestPrams.h"
#import "ZWSearchShopParams.h"
#import "ZWHomeAcrivityParams.h"
#import "ZWActivityParams.h"

//#import "ZWAccountTool.h"
//#import "ZWUserAccount.h"
//#import "ZWUserLoginHttpTool.h"
//#import "CommonFunc.h"
//#import "ZWUserLoginKeyItems.h"

@interface ZWHomeViewController ()<ZWHomeViewDelegate,UISearchBarDelegate>

//@property(nonatomic,strong)ZWUserLoginKeyItems *keyItems;

/**
 *  活动推荐
 */
@property(nonatomic,strong) NSArray *activityArray;
/**
 *  今日精选
 */
//@property(nonatomic,strong) NSArray *todayGoodArray;

/**
 *  今日推荐
 */
//@property(nonatomic,strong) NSArray *columuItemsArray;

/**
 *  本周热卖
 */
@property(nonatomic,strong) NSArray *itemsArray;

/**
 *  首页tableview头视图
 */
@property(nonatomic,weak)ZWHomeView *homeView;

/**
 *  进度显示图
 */
@property(nonatomic,weak)MBProgressHUD *HUD;

/**
 *  主题馆
 */
@property(nonatomic,strong)NSArray *themePavilion;

/**
 *  搜索框
 */
@property(nonatomic,strong)ZWSearchBar *searchBar;

/**
 *  蒙板button
 */
@property(nonatomic,weak)UIButton *button;

@end

@implementation ZWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self wu_getKeyForUserLogin];
//    创建进度视图
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    HUD.dimBackground = YES;
    self.HUD = HUD;
    
//    取消分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    设置行高
    [self.tableView setRowHeight:200];
    
//    [self addRightViewItem];
//    添加左边logo
    [self wu_addleftView];
//    添加搜索框
    [self wu_addTitleSearchView];
//    发送网络请求
    [self wu_sendNetRequest];
    
//    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [self.tableView mj_header];
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.tableView.mj_header.state = MJRefreshStateNoMoreData;
//        });
//    }];
    
//    刷新控件
    __weak typeof(self)myself = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            myself.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        });
    }];
}

//-(void)wu_getKeyForUserLogin
//{
//    ZWUserAccount *account = [ZWAccountTool account];
//    if (account) {
//        [ZWUserLoginHttpTool wu_getKeyWithparams:nil success:^(ZWUserLoginKeyItems *keyItems) {
//            self.keyItems = keyItems;
////            WuLog(@"keyItemskeyItems-----%@",keyItems.status);
////            [self wu_setUserLogin];
////            WuLog(@"--currentThread--%@",[NSThread currentThread]);
//        } failure:^(NSError *error) {
//            WuLog(@"%@",error);
//        }];
//    }
//}
//
//- (void)wu_setUserLogin
//{
//    ZWUserAccount *account = [ZWAccountTool account];
//    if ([self.keyItems.status isEqualToString:@"success"]) {
//        NSString *password = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@%@",self.keyItems.keyExponent, [CommonFunc textFromBase64String:account.password]]];
//        WuLog(@"%@",[CommonFunc textFromBase64String:account.password]);
//        NSString *username = account.userName;
//        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"account", password, @"password", nil];
//        [STUserLoginHttpTool wu_postLoginWithparams:param success:^(id json) {
//            WuLog(@"%@----------json",json);
//            WuLog(@"--currentThread--%@",[NSThread currentThread]);
//        } failure:^(NSError *error) {
//            
//        }];
//    }
//}

- (void)dealloc
{
    WuLog(@"dealloc");
}

-(NSArray *)activityArray
{
    if (_activityArray == nil) {
        NSArray *array = [NSArray array];
        _activityArray = array;
    }
    return _activityArray;
}

//-(NSArray *)todayGoodArray
//{
//    if (_todayGoodArray == nil) {
//        NSArray *array = [NSArray array];
//        _todayGoodArray = array;
//    }
//    return _todayGoodArray;
//}

//- (NSArray *)columuItemsArray
//{
//    if (_columuItemsArray == nil) {
//        NSArray *array = [NSArray array];
//        _columuItemsArray = array;
//    }
//    return _columuItemsArray;
//}

-(NSArray *)themePavilion
{
    if (_themePavilion == nil) {
        NSArray *array = [NSArray array];
        _themePavilion = array;
    }
    return _themePavilion;
}

- (NSArray *)itemsArray
{
    if (_itemsArray == nil) {
        NSArray *array = [NSArray array];
        _itemsArray = array;
    }
    return _itemsArray;
}

-(void)wu_sendNetRequest
{
//    [self wu_sendHttpGetWithString:[NSString stringWithFormat:@"%@/shop/app/v1/index/activity",httpAddress] index:0];
//    [self sendHttpGetWithString:[NSString stringWithFormat:@"%@/shop/app/v1/index/today",httpAddress] index:1];
//    [self wu_sendHttpGetWithString:[NSString stringWithFormat:@"%@/shop/app/v1/index/columuItems",httpAddress] index:1];
    __weak typeof(self)myself = self;
    [ZWHomeHttpTool wu_getHomeActivitySuccess:^(NSArray *array) {
        myself.activityArray = array;
        WuLog(@"activityArray---%@",array);
        
        [self wu_creatHomeHeaderView];
        myself.homeView.activityArray = array;
    } failure:^(NSError *error) {
//        [MBProgressHUD showError:@"网络连接失败，请检查网络"];
//        [self.HUD hide:YES];
    }];
    
    [ZWHomeHttpTool wu_getHomeBrandSuccess:^(NSArray *array) {
        self.themePavilion = array;
        
        [self wu_creatHomeHeaderView];
    } failure:^(NSError *error) {
        [myself.HUD hide:YES];
        [MBProgressHUD showError:@"网络连接失败，请检查网络"];
    }];
    
    [ZWHomeHttpTool wu_getHomeRecommendedSuccess:^(NSArray *array) {
        myself.itemsArray = array;
        [myself.tableView reloadData];
    } failure:^(NSError *error) {
        [myself.HUD hide:YES];
    }];
}

- (void)wu_creatHomeHeaderView
{
    if (self.activityArray.count != 0 && self.themePavilion.count != 0) {
        //    创建头部视图
        CGFloat homeViewH = 200 + 15 + ((self.themePavilion.count + 1) / 2) * 65;
        ZWHomeView *homeView = [[ZWHomeView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, homeViewH) activity:self.activityArray themePavilion:self.themePavilion];
        self.homeView = homeView;
        self.tableView.tableHeaderView = homeView;
        homeView.delegate = self;
        [self.HUD hide:YES];
    }
}

/**
 *  添加左边logo
 */
-(void)wu_addleftView
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    imageV.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageV];
}

/**
 *  添加头部搜索框
 */
-(void)wu_addTitleSearchView
{
    ZWSearchBar *searchBar = [[ZWSearchBar alloc] initWithFrame:CGRectMake(0, 5, Screen_Width - 100, 40)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
//    UITextField *t = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, Screen_Width - 100, 40)];
//    self.navigationItem.titleView = t;
//    t.delegate = self;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    button.backgroundColor = [UIColor grayColor];
    button.alpha = 0.4;
    //    self.tableView.scrollEnabled = NO;
    self.button = button;
    [button addTarget:self action:@selector(wu_cancelHome) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

/**
 *   返回首页
 */
-(void)wu_cancelHome
{
    [self.button removeFromSuperview];
//    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
    //    self.tableView.scrollEnabled = YES;
}

/**
 *  搜索商品
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self wu_cancelHome];
    [self.HUD hide:YES];
#warning 发送网络数据
//    WuLog(@"%@",self.searchBar.text);
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        ZWGoodDetailsClassViewController *goodDetailsClassViewController = [[ZWGoodDetailsClassViewController alloc] init];
//        goodDetailsClassViewController.title = @"搜索结果";
//        goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
//    });
    
    ZWGoodDetailsClassViewController *goodDetailsClassViewController = [[ZWGoodDetailsClassViewController alloc] init];
    goodDetailsClassViewController.title = @"搜索结果";
    ZWSearchShopParams *searchShopParams = [[ZWSearchShopParams alloc] init];
    searchShopParams.k = self.searchBar.text;
    goodDetailsClassViewController.searchShopParams = searchShopParams;
    goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
}

/**
 *  返回按钮被点击
 */
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //    [self cancelHome];
    [self searchBarSearchButtonClicked:searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return self.itemsArray.count;
    return 1;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWHomeTableViewCell *cell = [ZWHomeTableViewCell wu_cellWithTableView:tableView];
    cell.items = self.itemsArray[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"本周热卖"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZWCommodityDetailsViewController *commodityDetailsViewController = [[ZWCommodityDetailsViewController alloc] init];
    commodityDetailsViewController.title = @"商品详情";
    
    ZWCommodityParams *params = [[ZWCommodityParams alloc] init];
    ZWItems *items = self.itemsArray[indexPath.row];
    params.commodityID = items.categoryId;
    params.rows = @(3);
    commodityDetailsViewController.commodityParams = params;
    
    commodityDetailsViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commodityDetailsViewController animated:YES];
}

-(void)wu_homeView:(ZWHomeView *)homeView buttonDidClick:(NSInteger)index activity:(ZWActivity *)activity
{
    NSInteger groupNum = index / 10;
    ZWGoodDetailsClassViewController *goodDetailsClassViewController = [[ZWGoodDetailsClassViewController alloc] init];
    
    NSInteger num = index % 10;
    
    ZWThemePavilion *themePavilion = nil;
    ZWClassRequestPrams *classRequestPrams = [[ZWClassRequestPrams alloc] init];
    
//    ZWActivity *activity = self.activityArray[index % 10];
    ZWActivityParams *activityParams = [[ZWActivityParams alloc] init];
    switch (groupNum) {
        case 0:
            WuLog(@"%ld",(long)index);
//            WuLog(@"strURL---%@",strURL);
//            activityParams = [NSDictionary dictionaryWithObjectsAndKeys:@"id",activity.activityID, nil];
//            [STHomeHttpTool wu_getActivityParams:activityParams success:^(id json) {
//                
//                WuLog(@"json--%@",json);
//
//            } failure:^(NSError *error) {
//                
//            }];
            activityParams.activityID = activity.activityID;
            goodDetailsClassViewController.title = @"新品详情";
            goodDetailsClassViewController.activityParams = activityParams;
            goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
            break;
        case 1:
            themePavilion = self.themePavilion[num >= self.themePavilion.count ? (num = self.themePavilion.count - 1) : num];
            classRequestPrams.categoryId = themePavilion.themePavilionID;
            classRequestPrams.level = themePavilion.level;
            goodDetailsClassViewController.title = themePavilion.name;
            goodDetailsClassViewController.classRequestPrams = classRequestPrams;
            goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
            break;
            
        default:
            break;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
