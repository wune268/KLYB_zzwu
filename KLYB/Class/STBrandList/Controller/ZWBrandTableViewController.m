//
//  STBrandTableViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWBrandTableViewController.h"
#import "ZWGoodDetailsClassViewController.h"
#import "ZWBrandGroup.h"
#import "ZWBrandItems.h"
#import "ZWBrandTableViewCell.h"
#import "ZWSearchBar.h"
#import "ZWBrandTttpTool.h"
#import "ZWBrandRequestParams.h"
#import "ZWSearchShopParams.h"

@interface ZWBrandTableViewController ()<UISearchBarDelegate>

@property(nonatomic,strong)NSArray *groups;

/**
 *  进度显示图
 */
@property(nonatomic,weak)MBProgressHUD *HUD;

/**
 *  搜索框
 */
@property(nonatomic,weak)ZWSearchBar *searchBar;

/**
 *  蒙板button
 */
@property(nonatomic,weak)UIButton *button;

@end

@implementation ZWBrandTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self wu_addleftTitleView];
    [self wu_sentNetToGetBrandList];
    [self wu_addTitleSearchView];
    
    // 隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        });
    }];
}

- (void) wu_sentNetToGetBrandList
{
    [ZWBrandTttpTool wu_getBrandListSuccess:^(NSArray *array) {
        WuLog(@"%@",array);
        self.groups = array;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)groups
{
    if (_groups == nil)
    {
        // 初始化
        // 1.获得plist的全路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"STBrandShop.plist" ofType:nil];
//        
//        // 2.加载数组
//        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
//        
//        // 3.将dictArray里面的所有字典转成模型对象,放到新的数组中
//        NSMutableArray *groupArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            // 3.1.创建模型对象
//            STBrandGroup *group = [STBrandGroup groupWithDict:dict];
//            
//            // 3.2.添加模型对象到数组中
//            [groupArray addObject:group];
//        }
//        NSMutableArray *groupArray = [STBrandItems mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"STBrandShop.plist" ofType:nil]];
        // 4.赋值
        _groups = [NSArray array];
    }
    return _groups;
}

/**
 *  添加左边logo
 */
-(void)wu_addleftTitleView
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
    ZWSearchBar *searchBar = [[ZWSearchBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
}

/**
 *  搜索框被按下的代理方法（添加蒙板）
 */
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    button.backgroundColor = [UIColor grayColor];
    button.alpha = 0.4;
    self.tableView.scrollEnabled = NO;
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
    self.tableView.scrollEnabled = YES;
}

/**
 *  搜索商品
 */
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    HUD.dimBackground = YES;
    self.HUD = HUD;
    [self wu_cancelHome];
    [self.HUD hide:YES afterDelay:2.0];
    
#warning 发送网络数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        STGoodDetailsClassViewController *goodDetailsClassViewController = [[STGoodDetailsClassViewController alloc] init];
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZWBrandGroup *group = self.groups[section];
    return group.brands.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWBrandTableViewCell *cell = [ZWBrandTableViewCell wu_cellWithTableView:tableView];
    
    // 设置数据
    ZWBrandGroup *group = self.groups[indexPath.section];
    ZWBrandItems *items = group.brands[indexPath.row];
    
    cell.brandItemsData = items;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWGoodDetailsClassViewController *goodDetailsClassViewController = [[ZWGoodDetailsClassViewController alloc] init];
    ZWBrandGroup *group = self.groups[indexPath.section];
    ZWBrandItems *items = group.brands[indexPath.row];
    goodDetailsClassViewController.title = items.name;
    ZWBrandRequestParams *brandRequestParams = [[ZWBrandRequestParams alloc] init];
    brandRequestParams.brand = items.brandID;
    goodDetailsClassViewController.brandRequestParams = brandRequestParams;
    goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZWBrandGroup *group = self.groups[section];
    return group.letter;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];
    headerView.backgroundView = backgroundView;
}

/**
 *  返回右边索引条显示的字符串数据
 */
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.groups valueForKeyPath:@"letter"];
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
