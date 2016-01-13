//
//  ZWShopCarViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWShopCarViewController.h"
#import "ZWGoodsListCarCell.h"
#import "ZWAccountViewController.h"
#import "ZWGoodsInfoCarItems.h"
#import "ZWShopCarHttpTool.h"
#import "ZWCheckShopCarStatus.h"
#import "ZWNavigationController.h"
#import "ZWUserLoginViewController.h"
#import "ZWAccountTool.h"
#import "ZWUserAccount.h"
#import "ZWAccountParams.h"
#import "ZWDeleteShopCarItems.h"

@interface ZWShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,ZWGoodsListCarCellDelegate>
/**
 *  合计
 */
@property(nonatomic,strong)UILabel *priceTitle;
/**
 *  结算
 */
@property(nonatomic,weak)UIButton *balanceBtn;

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *goodCarGroup;

//@property(nonatomic,strong)NSMutableArray *payProductGroup;

@end

@implementation ZWShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self wu_addShopView];
    
    [self wu_checkShopCar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wu_cantNotCheckShopCar:) name:@"CantNotCheckShopCar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wu_LoginSuccuss:) name:@"LoginSuccuss" object:nil];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(rightBarButtonClick:)];
    
    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"德国爱他美2段商品图", @"imageName", @"德国爱他美1段", @"goodsTitle", @"19.80", @"goodsPrice", @"1", @"goodsNum", nil];
//    STGoodsInfoCarItems *items = [STGoodsInfoCarItems itemsWithDict:dict];
//    
//    [self.goodCarGroup addObject:items];
//    
//    NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys: @"德国爱他美2段商品图", @"imageName", @"德国爱他美1段", @"goodsTitle", @"19.80", @"goodsPrice", @"1", @"goodsNum", nil];
//    STGoodsInfoCarItems *items1 = [STGoodsInfoCarItems itemsWithDict:dict1];
//    
//    [self.goodCarGroup addObject:items1];
//    
//    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys: @"德国爱他美2段商品图", @"imageName", @"德国爱他美2段", @"goodsTitle", @"19.80", @"goodsPrice", @"1", @"goodsNum", nil];
//    STGoodsInfoCarItems *items2 = [STGoodsInfoCarItems itemsWithDict:dict2];
//    
//    [self.goodCarGroup addObject:items2];
//    [UIImage imageNamed:]
}

- (void) wu_cantNotCheckShopCar:(NSNotification *)notification
{
//    WuLog(@"notification---%@",notification);
    NSDictionary *dict = [notification userInfo];
    ZWCheckShopCarStatus *checkShopCarStatus = [ZWCheckShopCarStatus mj_objectWithKeyValues:dict];
    
    ZWUserLoginViewController *userLoginViewController = [[ZWUserLoginViewController alloc] init];
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:userLoginViewController];
    switch ([checkShopCarStatus.code integerValue]) {
        case 1000:
            WuLog(@"您还没有登录，请登录");
            [self.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
            break;
            
        default:
            break;
    }
}

- (void)wu_checkShopCar
{
    [ZWShopCarHttpTool wu_getCheckShopCarSuccess:^(NSArray *array) {
        WuLog(@"%@",array);
        if (array.count) {
            [self.goodCarGroup addObjectsFromArray:array];
            [self wu_addShopView];
//            [self.tableView reloadData];
        }
        else
        {
            [self wu_shopCarIsNull];
        }
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
}

- (NSMutableArray *)goodCarGroup
{
    if (_goodCarGroup == nil) {
        NSMutableArray *array = [NSMutableArray array];
        _goodCarGroup = array;
    }
    return _goodCarGroup;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    WuLog(@"dealloc");
}

//- (NSMutableArray *)payProductGroup
//{
//    if (_payProductGroup == nil) {
//        NSMutableArray *array = [NSMutableArray array];
//        _payProductGroup = array;
//    }
//    return _payProductGroup;
//}

-(void)wu_LoginSuccuss:(NSNotification *)notification
{
    [self wu_checkShopCar];
}

/**
 *  添加视图
 */
-(void)wu_addShopView
{
    CGFloat tableViewH =Screen_Height - 49;
    self.tableViewFrameHight ? tableViewH = self.tableViewFrameHight : tableViewH;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, tableViewH)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.rowHeight = 120;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, tableView.frame.size.height - 49, Screen_Width, 49)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIButton *checkAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 2, 60, 44)];
    [checkAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    checkAllBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    checkAllBtn.backgroundColor = [UIColor orangeColor];
    [checkAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkAllBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [checkAllBtn addTarget:self action:@selector(wu_checkAllBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:checkAllBtn];
    
    UIButton *balanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 100 - 10, 2, 100, 44)];
    [balanceBtn setTitle:@"结算（0）" forState:UIControlStateNormal];
    balanceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    balanceBtn.enabled = NO;
    balanceBtn.backgroundColor = [UIColor orangeColor];
    [balanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [balanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [balanceBtn addTarget:self action:@selector(wu_balanceBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.balanceBtn = balanceBtn;
    [footView addSubview:balanceBtn];
    
    UILabel *priceTitle = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 260 - 20, 2, 150, 44)];
    priceTitle.text = [NSString stringWithFormat:@"合计：¥ 0.00"];
    priceTitle.textColor = [UIColor redColor];
    priceTitle.textAlignment = NSTextAlignmentRight;
    priceTitle.font = [UIFont systemFontOfSize:15];
    self.priceTitle = priceTitle;
    [footView addSubview:priceTitle];
    
    [self.view addSubview:footView];
}

//-(void)rightBarButtonClick:(UIButton *)button
//{
//    NSLog(@"编辑");
//}

-(void)wu_checkAllBtnDidClick:(UIButton *)button
{
    WuLog(@"全选");
    for (int i = 0; i < self.goodCarGroup.count; i ++) {
        ZWGoodsInfoCarItems *items = self.goodCarGroup[i];
        if (!items.selectState) {
            items.selectState = YES;
        }
        else
        {
            items.selectState = NO;
        }
        [self.tableView reloadData];
    }
    [self wu_totalPrice];
}

-(void)wu_balanceBtnDidClick:(UIButton *)button
{
    ZWAccountViewController *accountListController = [[ZWAccountViewController alloc] init];
    accountListController.title = @"提交订单";
//    NSMutableArray *payProduct = [NSMutableArray array];
    NSString *allShopList = [NSString string];
    for (ZWGoodsInfoCarItems *items in self.goodCarGroup) {
        if (items.selectState) {
//            [payProduct addObject:items];
            allShopList = [allShopList stringByAppendingString:[NSString stringWithFormat:@"%@_%@#",items.goodsID, items.goodsNum]];
        }
    }
//    WuLog(@"%@",allShopList);
    allShopList = [allShopList substringToIndex:allShopList.length - 1];
//    WuLog(@"%@",allShopList);
////    accountListController.payProductArry = payProduct;
//    accountListController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:accountListController animated:YES];
    
    
    ZWAccountParams *accountParams = [[ZWAccountParams alloc] init];
    accountParams.orderItem = allShopList;
    accountListController.hidesBottomBarWhenPushed = YES;
    accountListController.accountParams = accountParams;
    [self.navigationController pushViewController:accountListController animated:YES];
}

- (void)wu_shopCarIsNull
{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"default_03"];
    [self.view addSubview:imageView];
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    [button setTitle:@"返回首页" forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor orangeColor]];
//    button.center = self.view.center;
//    [button addTarget:self action:@selector(cancelHome:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
}

//- (void)cancelHome:(UIButton *)button
//{
//    self.tabBarController.selectedIndex = 0;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelHome" object:button];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.goodCarGroup.count == 0) {
        [self wu_shopCarIsNull];
    }
    return self.goodCarGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWGoodsListCarCell *cell = [[ZWGoodsListCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.delegate = self;
    ZWGoodsInfoCarItems *items = self.goodCarGroup[indexPath.row];
    cell.items = items;
#warning 给cell传递数据
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZWGoodsInfoCarItems *items = self.goodCarGroup[indexPath.row];
    if (items.selectState == YES)
    {
        items.selectState = NO;
    }
    else
    {
        items.selectState = YES;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self wu_totalPrice];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#warning 删除商品
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZWDeleteShopCarItems *deleteShopCarItems = [[ZWDeleteShopCarItems alloc] init];
        ZWGoodsInfoCarItems *goodsInfoCarItems = self.goodCarGroup[indexPath.row];
        deleteShopCarItems.itemId = goodsInfoCarItems.goodsID;
        [ZWShopCarHttpTool wu_postDeleteShopCarWithparams:deleteShopCarItems success:^(ZWAddOrDeleteShopCarStatus *shopCarStatus) {
            WuLog(@"删除成功");
        } failure:^(NSError *error) {
            WuLog(@"删除失败");
        }];
        [self.goodCarGroup removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self wu_totalPrice];
    }
}

- (void)wu_goodsListCarCell:(ZWGoodsListCarCell *)cell buttonDidClick:(UIButton *)button
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ZWGoodsInfoCarItems *items = self.goodCarGroup[index.row];
    int temp = [items.goodsNum intValue];
    switch (button.tag) {
        case -1:
            if (temp > 1)
            {
                temp --;
            }
            break;
            
        case +1:
            temp ++;
            break;
            
        default:
            break;
    }
    items.goodsNum = [NSString stringWithFormat:@"%d",temp];
    cell.items = items;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self wu_totalPrice];
    
}

-(void)wu_totalPrice
{
    double allPrice = 0.0;
    allPrice = [self.priceTitle.text doubleValue];
    int i = 0;
    for (ZWGoodsInfoCarItems *items in self.goodCarGroup)
    {
        if (items.selectState == YES)
        {
            i += [items.goodsNum intValue];
            allPrice = allPrice + [items.goodsPrice doubleValue] * [items.goodsNum intValue];
        }
    }
    self.priceTitle.text = [NSString stringWithFormat:@"合计：¥ %.2f",allPrice];
    if (i) {
        self.balanceBtn.enabled = YES;
    }
    else
    {
        self.balanceBtn.enabled = NO;
    }
    [self.balanceBtn setTitle:[NSString stringWithFormat:@"结算（%d）", i] forState:UIControlStateNormal];
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
