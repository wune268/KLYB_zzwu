//
//  ZWAccountPayStyleController.m
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountPayStyleController.h"
#import "ZWAccountViewController.h"
#import "ZWPayStyleItems.h"

@interface ZWAccountPayStyleController ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation ZWAccountPayStyleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: @"支付宝", @"name", nil];
    
    ZWPayStyleItems *items = [ZWPayStyleItems itemsWithDict:dict];
    
    [self.groups addObject:items];

}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    WuFriendGroup *group = self.groups[section];
    //
    //    return (group.isOpened ? group.friends.count : 0);
    return self.groups.count;
    //    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UserName";
    // 1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
//    STAddressItems *items = self.groups[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",items.userName, items.userPhone];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",items.userAddress];
    ZWPayStyleItems *items = self.groups[indexPath.row];
    cell.textLabel.text = items.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
    ZWAccountViewController *AccountViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
    //初始化其属性
    ZWPayStyleItems *items = self.groups[indexPath.row];
    
    AccountViewController.payStyleItems = items;
    
    //使用popToViewController返回并传值到上一页面
    
    [self.navigationController popToViewController:AccountViewController animated:YES];
}


@end
