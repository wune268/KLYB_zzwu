//
//  ZWEvaluateDetailsViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/30.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWEvaluateDetailsViewController.h"
#import "ZWEvaluateItems.h"
#import "ZWEvaluateFrame.h"
#import "ZWCommodityParams.h"
#import "ZWCommodityHttpTool.h"
#import "ZWEvaluateCell.h"

@interface ZWEvaluateDetailsViewController ()

@property(nonatomic,strong) NSMutableArray *evaluatelGroup;
@property(nonatomic, assign)NSInteger page;

@end

@implementation ZWEvaluateDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self wu_sendNetRequestWithParams:_params];
    
    [self wu_refurbishData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (NSMutableArray *)evaluatelGroup
{
    if (_evaluatelGroup == nil) {
        _evaluatelGroup = [NSMutableArray array];
    }
    return _evaluatelGroup;
}

- (void)wu_refurbishData
{
    __weak typeof(self)myself = self;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        ZWCommodityParams *param = [[ZWCommodityParams alloc] init];
        param.commodityID = _params.commodityID;
        param.rows = @(20);
        param.page = [NSNumber numberWithInteger:myself.page];
        [ZWCommodityHttpTool wu_getEvaluateWithParams:param success:^(NSArray *evaluateItemsArray) {
            NSMutableArray *itemsArray = [NSMutableArray array];
            for (ZWEvaluateItems *items in evaluateItemsArray) {
                ZWEvaluateFrame *itemsFrame = [[ZWEvaluateFrame alloc] init];
                // 传递模型数据
                itemsFrame.evaluateItems = items;
                [itemsArray addObject:itemsFrame];
            }
            [myself.evaluatelGroup addObjectsFromArray:itemsArray];
            [myself.tableView reloadData];
            [myself.tableView.mj_footer endRefreshing];
            if (evaluateItemsArray.count) {
                myself.page ++;
            }
        } failure:^(NSError *error) {
            WuLog(@"网络错误");
        }];

    }];
}

- (void)wu_sendNetRequestWithParams:(ZWCommodityParams *)params
{
    __weak typeof(self)myself = self;
    [ZWCommodityHttpTool wu_getEvaluateWithParams:params success:^(NSArray *evaluateItemsArray)
     {
        NSMutableArray *itemsArray = [NSMutableArray array];
        for (ZWEvaluateItems *items in evaluateItemsArray) {
            ZWEvaluateFrame *itemsFrame = [[ZWEvaluateFrame alloc] init];
            // 传递模型数据
            itemsFrame.evaluateItems = items;
            [itemsArray addObject:itemsFrame];
        }
        myself.evaluatelGroup = itemsArray;
        [myself.tableView reloadData];
         if (evaluateItemsArray.count) {
             myself.page ++;
         }
    } failure:^(NSError *error) {
        WuLog(@"网络错误");
    }];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.evaluatelGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    ZWEvaluateCell *cell = [ZWEvaluateCell wu_cellWithtableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.itemsFrame = self.evaluatelGroup[indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWEvaluateFrame *itemsFrame = self.evaluatelGroup[indexPath.row];
    return itemsFrame.cellHeight;
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
