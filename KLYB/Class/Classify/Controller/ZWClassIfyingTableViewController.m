//
//  ZWClassIfyingTableViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWClassIfyingTableViewController.h"
#import "ZWGoodDetailsClassViewController.h"
#import "ZWSearchBar.h"
#import "ZWClassifyGroup.h"
#import "ZWClassifyModel.h"
#import "ZWClassIfyTableViewCell.h"
#import "ZWClassifyHttpTool.h"
#import "ZWClassifyGroup.h"
#import "ZWClassifyModel.h"
#import "ZWClassRequestPrams.h"
#import "ZWSearchShopParams.h"

@interface ZWClassIfyingTableViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

//@property(nonatomic,strong)NSArray *groups;

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

/**
 *  左边的主要table
 */
@property(nonatomic,weak)UITableView *leftMainTable;

/**
 *  右边的主要table
 */
@property(nonatomic,weak)UITableView *rightTable;

@property(nonatomic,strong)NSArray *classifyGroup;

//@property(nonatomic,weak)NSArray *classifyModel;

@property(nonatomic,strong)NSArray *classifyRightModel;

@end

@implementation ZWClassIfyingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows lastObject] animated:YES];
    HUD.dimBackground = YES;
    self.HUD = HUD;
    
    [self wu_addleftView];
    [self wu_addTitleSearchView];
    
    [self wu_addTableView];
    
    __weak typeof(self)myself = self;
    [ZWClassifyHttpTool wu_getClassSuccess:^(NSArray *array) {
        myself.classifyGroup = array;
        myself.HUD.hidden = YES;
        [myself.leftMainTable reloadData];
        [myself.rightTable reloadData];
    } failure:^(NSError *error) {
        myself.HUD.hidden = YES;
        [MBProgressHUD showError:@"网络出错"];
    }];
    
//    for (ZWClassifyGroup *group in self.classifyGroup) {
//        NSLog(@"group--%@",group);
//    }
    
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//        });
//    }];
    
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void) wu_addTableView
{
//    左边的类别
    UITableView *leftMainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, Screen_Height) style:UITableViewStyleGrouped];
    leftMainTable.delegate = self;
    leftMainTable.dataSource = self;
    self.leftMainTable = leftMainTable;
    [self.view addSubview:leftMainTable];
    
//    右边的分类
    UITableView *rightTable = [[UITableView alloc] initWithFrame:CGRectMake(150, 64, Screen_Width - 150, Screen_Height) style:UITableViewStyleGrouped];
    rightTable.delegate = self;
    rightTable.dataSource = self;
    self.rightTable = rightTable;
    [self.view addSubview:rightTable];
}

//- (NSArray *)groups
//{
//    if (_groups == nil) {
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
        
        // 4.赋值
//        _groups = [NSMutableArray array];
//    }
//    return _groups;
//}

- (NSArray *)classifyGroup
{
    if (_classifyGroup == nil)
    {
//        NSMutableArray *array = [STClassifyGroup mj_objectArrayWithFilename:@"STBrandShop.plist"];
//        NSMutableArray *array = [STClassifyGroup mj_objectArrayWithKeyValuesArray:dict];
        _classifyGroup = [NSMutableArray array];
    }
    return _classifyGroup;
}

//- (NSArray *)classifyModel
//{
//    if (_classifyModel == nil) {
//        
//        for (STClassifyGroup *group in self.classifyGroup) {
//            NSMutableArray *m = [STClassifyModel mj_objectArrayWithKeyValuesArray:group.brand];
//            _classifyModel = m;
//        }
//    }
//    return _classifyModel;
//}

-(NSArray *)classifyRightModel
{
    if (_classifyRightModel == nil) {
        _classifyRightModel = [NSMutableArray array];
    }
    return _classifyRightModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    WuLog(@"%@",self.searchBar.text);
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
//    ZWBrandGroup *group = self.groups[section];
//    return group.BrandItems.count;
//    return 10;
    if ([tableView isEqual:self.leftMainTable]) {
        return self.classifyGroup.count;
    }else
    {
//        ZWBrandGroup *group = self.groups[indexPath.section];
//        ZWBrandItems *items = group.BrandItems[indexPath.row];
        
//        ZWBrandGroup *group = self.groups[section];
//        return group.BrandItems.count;
        
        return self.classifyRightModel.count;
    }
    return 0;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
////    return self.groups.count;
//    return 3;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    // 1.定义一个循环标识
//    static NSString *ID = @"fenlei";
//    
//    // 2.从缓存池中取出可循环利用cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    
//    // 3.缓存池中没有可循环利用的cell
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    
//    // 4.设置数据
//    if ([tableView isEqual:self.leftMainTable])
//    {
//        STClassifyGroup *group = self.classifyGroup[indexPath.row];
//        cell.textLabel.text = group.title;
//    }
//    else
//    {
//        STClassifyModel *model = self.classifyModel[indexPath.row];
//        NSLog(@"classifyRightModel--%@",self.classifyModel);
//        cell.textLabel.text = model.name;
//    }
//    NSLog(@"self.classifyGroup--%@",self.classifyGroup);
//    for (STClassifyGroup *group in self.classifyGroup) {
//        NSLog(@"group--%@",group.title);
//        NSLog(@"group--%@",group.brand);
//        NSMutableArray *m = [STClassifyModel mj_objectArrayWithKeyValuesArray:group.brand];
//        for (STClassifyModel *model in self.classifyModel) {
//            NSLog(@"group--%@",model.icon);
//            NSLog(@"group--%@",model.name);
//        }
//    }
    
    ZWClassIfyTableViewCell *cell = [ZWClassIfyTableViewCell wu_cellWithTableView:tableView];
    
    if ([tableView isEqual:self.leftMainTable])
    {
        ZWClassifyGroup *group  = self.classifyGroup[indexPath.row];
        cell.textLabel.text = group.classifyName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
//        ZWBrandGroup *group  = self.groups[indexPath.section];
//        ZWBrandItems *item = group.BrandItems[indexPath.row];
        ZWClassifyModel *item = self.classifyRightModel[indexPath.row];
        cell.textLabel.text = item.name;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ZWBrandGroup *group = self.groups[indexPath.section];
//    ZWBrandItems *items = group.BrandItems[indexPath.row];
//    goodDetailsClassViewController.title = items.name;
    if ([tableView isEqual:self.leftMainTable])
    {
        
//        cell.textLabel.text = [NSZWring stringWithFormat:@"分类－－%ld",(long)indexPath.row];
//        STClassifyGroup *group = self.classifyGroup[indexPath.row];
//        if (self.classifyModel == nil) {
//            
//            for (STClassifyGroup *group in self.classifyGroup) {
//                NSMutableArray *m = [STClassifyModel mj_objectArrayWithKeyValuesArray:group.brand];
//                self.classifyModel = m[indexPath.row];
//            }
//        }
//        [self.classifyModel arrayByAddingObjectsFromArray:group.brand];
        
//        self.rightTable selectRowAtIndexPath:<#(nullable NSIndexPath *)#> animated:<#(BOOL)#> scrollPosition:<#(UITableViewScrollPosition)#>
//        self.rightTable
        
        ZWClassifyGroup *group = self.classifyGroup[indexPath.row];
        self.classifyRightModel = group.classifySub;
        [self.rightTable reloadData];
    }
    else
    {
        ZWClassifyModel *model = self.classifyRightModel[indexPath.row];
        
        ZWClassRequestPrams *classRequestPrams = [[ZWClassRequestPrams alloc] init];
        classRequestPrams.categoryId = model.classID;
        classRequestPrams.level = model.level;
//        [STClassifyHttpTool wu_getClassificationWithParams:classRequestPrams success:^(NSArray *array) {
//            NSLog(@"%@---array",array);
//        } failure:^(NSError *error) {
//            
//        }];
        ZWGoodDetailsClassViewController *goodDetailsClassViewController = [[ZWGoodDetailsClassViewController alloc] init];
//        ZWClassifyModel *model = self.classifyRightModel[indexPath.row];
        goodDetailsClassViewController.title = model.name;
        goodDetailsClassViewController.classRequestPrams = classRequestPrams;
        goodDetailsClassViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:goodDetailsClassViewController animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    STBrandGroup *group = self.groups[section];
//    return group.title;
//    if ([tableView isEqual:self.leftMainTable])
//    {
//        
//        cell.textLabel.text = [NSString stringWithFormat:@"分类－－%ld",(long)indexPath.row];
//    }
//    else
//    {
//        cell.textLabel.text = [NSString stringWithFormat:@"分类dfdrsfdf－－%ld",(long)indexPath.row];
//    }
//    return [NSString stringWithFormat:@"类型－%ld",(long)section];
//}

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *)view;
//    UIView *backgroundView = [[UIView alloc] init];
//    backgroundView.backgroundColor = [UIColor colorWithRed:0.10 green:0.68 blue:0.94 alpha:1.0];
//    headerView.backgroundView = backgroundView;
//}

/**
 *  返回右边索引条显示的字符串数据
 */
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
////    return [self.groups valueForKeyPath:@"title"];
//    return [NSArray arrayWithObject:@""];
//}

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
