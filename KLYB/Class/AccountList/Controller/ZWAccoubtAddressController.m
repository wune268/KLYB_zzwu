//
//  ZWaccoubtAddressController.m
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccoubtAddressController.h"
#import "ZWAddressPickerView.h"
#import "ZWAddressModel.h"
#import "ZWAddressItems.h"
#import "ZWAccountViewController.h"

@interface ZWAccoubtAddressController ()

@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation ZWAccoubtAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(wu_addNewAddress:)];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(void)wu_addNewAddress:(UIBarButtonItem *)barButtonItem
{
    __weak typeof(self)myself = self;
    UIAlertController *addAddressController = [UIAlertController alertControllerWithTitle:@"添加收获地址" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [addAddressController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        textField.placeholder = @"收货人";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [addAddressController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        textField.placeholder = @"手机号码";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    [addAddressController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        textField.placeholder = @"收货地址";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        ZWAddressPickerView *pickView = [[ZWAddressPickerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 216)];
        pickView.block = ^(ZWAddressPickerView *view,UIButton *btn,ZWAddressModel *locate)
        {
            textField.text = [NSString stringWithFormat:@"%@",locate];
        };
        textField.inputView = pickView;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [addAddressController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField)
    {
        textField.placeholder = @"详细地址";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [addAddressController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [addAddressController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray *textArray = addAddressController.textFields;
        UITextField *T0 = textArray[0];
        UITextField *T1 = textArray[1];
        UITextField *T2 = textArray[2];
        UITextField *T3 = textArray[3];
        NSString *address = [NSString stringWithFormat:@"%@%@",T2.text, T3.text];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: T0.text, @"userName", T1.text, @"userPhone", address, @"userAddress", nil];
        
        ZWAddressItems *items = [ZWAddressItems itemsWithDict:dict];
        
        WuLog(@"userAddress--%@",items.userAddress);
        [myself.groups addObject:items];
        [myself.tableView reloadData];
    }]];
    
    [self.navigationController presentViewController:addAddressController animated:YES completion:^{
        
    }];
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
    ZWAddressItems *items = self.groups[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",items.userName, items.userPhone];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",items.userAddress];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    ZWAccountViewController *AccountViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    
    //初始化其属性
    ZWAddressItems *items = self.groups[indexPath.row];
    
    AccountViewController.addressItems = items;
    
    //使用popToViewController返回并传值到上一页面
    
    [self.navigationController popToViewController:AccountViewController animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.groups removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
