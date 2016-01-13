//
//  ZWBaseMeController.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWBaseMeController.h"
#import "ZWMeSwitchItem.h"
#import "ZWMeTableViewCell.h"
#import "ZWMeItem.h"
#import "ZWMeGroup.h"
#import "ZWMeArrowItem.h"

@interface ZWBaseMeController ()

@end

@implementation ZWBaseMeController

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:style];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

-(NSArray *)data
{
    if (nil == _data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZWMeGroup *group = self.data[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    ZWMeTableViewCell *cell = [ZWMeTableViewCell wu_cellWithTableView:tableView];
    
    // 2.给cell传递模型数据
    ZWMeGroup *group = self.data[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    // 3.返回cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取消选中这行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 2.模型数据
    ZWMeGroup *group = self.data[indexPath.section];
    ZWMeItem *item = group.items[indexPath.row];
    
    if (item.option) { // block有值(点击这个cell,.有特定的操作需要执行)
        item.option();
    } else if ([item isKindOfClass:[ZWMeArrowItem class]]) { // 箭头
        ZWMeArrowItem *arrowItem = (ZWMeArrowItem *)item;
        
        // 如果没有需要跳转的控制器
        if (arrowItem.destVclass == nil) return;
        
        UIViewController *vc = [[arrowItem.destVclass alloc] init];
        vc.title = arrowItem.title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc  animated:YES];
    }
}

//  头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZWMeGroup *group = self.data[section];
    return group.header;
}

//  尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZWMeGroup *group = self.data[section];
    return group.footer;
}

@end
