//
//  ZWAccountViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountViewController.h"
#import "ZWAccountHeadView.h"
#import "ZWAccountFootView.h"
#import "ZWAccountListCell.h"
#import "ZWAccoubtAddressController.h"
#import "ZWAccountPayStyleController.h"
//#import "STAccountProduct.h"
#import "ZWPaymentViewController.h"
#import "ZWFootViewModel.h"
#import "ZWPaymentProduct.h"
#import "ZWAddressItems.h"
#import "ZWPayStyleItems.h"
#import "ZWAccountOrderResultItems.h"
#import "ZWAccountItemsList.h"
#import "ZWAccountSendTypeList.h"
#import "ZWAccountListHttpTool.h"
#import "ZWBuildListParams.h"
#import "ZWAccountAddressItems.h"
#import "ZWAccountPayTypeList.h"
#import "ZWAccountParams.h"

@interface ZWAccountViewController ()<ZWAccountHeadViewDelegate>

@property(nonatomic,weak)ZWAccountHeadView *headView;
@property(nonatomic,weak)ZWAccountAddressItems *accountAddressItems;

@property(nonatomic,strong)NSArray *itemsGroup;
//@property(nonatomic,strong)NSArray *addressGroup;
@property(nonatomic,strong)NSArray *payStyleGroup;
@property(nonatomic,strong)NSArray *sendStyleGroup;
@property(nonatomic,strong)ZWAccountOrderResultItems *accountOrderResultItems;

@end

@implementation ZWAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wu_addRightButtonItem];
    
//    [self wu_creatTableView];
    
    [ZWAccountListHttpTool wu_getAccountListWithParams:_accountParams
                                               success:^(ZWAccountOrderResultItems *accountOrderResultItems)
    {
        if (accountOrderResultItems) {
            WuLog(@"%@",accountOrderResultItems);
            self.accountOrderResultItems = accountOrderResultItems;
            self.accountAddressItems = accountOrderResultItems.address;
            self.payStyleGroup = accountOrderResultItems.payTypeList;
            self.sendStyleGroup = accountOrderResultItems.sendTypeList;
            self.itemsGroup = accountOrderResultItems.itemList;
            [self wu_creatTableView];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
}

- (NSArray *)itemsGroup
{
    if (!_itemsGroup) {
        _itemsGroup = [NSArray array];
    }
    return _itemsGroup;
}

//- (NSArray *)addressGroup
//{
//    if (!_addressGroup) {
//        _addressGroup = [NSArray array];
//    }
//    return _addressGroup;
//}

- (NSArray *)payStyleGroup
{
    if (!_payStyleGroup) {
        _payStyleGroup = [NSArray array];
    }
    return _payStyleGroup;
}

- (NSArray *)sendStyleGroup
{
    if (!_sendStyleGroup) {
        _sendStyleGroup = [NSArray array];
    }
    return _sendStyleGroup;
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)wu_creatTableView
{
//    头部视图
    ZWAccountHeadView *headView = [[ZWAccountHeadView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 145)];
    headView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    headView.delegate = self;
    self.headView = headView;
    headView.accountAddressItems = self.accountAddressItems;
    headView.accountPayTypeList = [self.payStyleGroup firstObject];
    self.tableView.tableHeaderView = headView;
    
//    尾部视图
    ZWAccountFootView *footView = [[ZWAccountFootView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 125)];
    ZWFootViewModel *model = [[ZWFootViewModel alloc] init];
//    model.totalPrice = [self wu_totalPrice];
    ZWAccountSendTypeList *accountSendTypeList = [self.sendStyleGroup firstObject];
    model.postage = self.accountOrderResultItems.shippingFee;
    model.totalPrice = self.accountOrderResultItems.payFee;
    model.sendTtyle = accountSendTypeList.name;
    footView.footitems = model;
    self.tableView.tableFooterView = footView;
    
    self.tableView.rowHeight = 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSString *)wu_totalPrice
//{
//    double allPrice = 0.0;
//    for (STAccountProduct *items in self.payProductArry)
//    {
//        allPrice = allPrice + [items.goodsPrice doubleValue] * [items.goodsNum intValue];
//    }
//    return [NSString stringWithFormat:@"%.2f",allPrice];
//}

/**
 *  添加右边提交按钮
 */
-(void)wu_addRightButtonItem
{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(wu_rightBarButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark   ==============产生订单号==============
- (NSString *)wu_generateTradeNO
{
//    获取当前时间的年月日
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    static int kNumber = 10;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *resultStr = [[NSString alloc] init];
    srand((unsigned int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@",oneStr]];
    }
    resultStr = [dateTime stringByAppendingString:[NSString stringWithFormat:@"%@",resultStr]];
    
    return resultStr;
}

//订单ID（由商家自行制定）
//商品标题
//商品描述
//商品价格

-(void)wu_rightBarButtonClick:(UIButton *)button
{
    ZWPaymentViewController *paymentViewController = [[ZWPaymentViewController alloc] init];
    paymentViewController.title = @"下单成功";
//    ZWPaymentProduct *product = [[STPaymentProduct alloc] init];
//    product.goodsTitle = @"新生代雀氏纸尿裤新生代雀氏纸尿裤";
//    product.sellerSubject = @"纸尿裤";
//    product.sellerGoodsID = [self wu_generateTradeNO];
//    product.imageName = @"德国爱他美2+段详情图2";
//    product.goodsPrice = _accountOrderResultItems.payFee;
//    product.payStyle = [self.payStyleItems wu_description];
//    [paymentViewController setProduct:product];
    ZWBuildListParams *buildListParams = [[ZWBuildListParams alloc] init];
    ZWAccountPayTypeList *accountPayTypeList = [self.payStyleGroup firstObject];
    ZWAccountSendTypeList *accountSendTypeList = [self.sendStyleGroup firstObject];
    buildListParams.address = self.accountAddressItems.addressID;
    buildListParams.sendType = accountSendTypeList.value;
    buildListParams.payType = accountPayTypeList.value;
    buildListParams.orderItem = _accountParams.orderItem;
    paymentViewController.buildListParams = buildListParams;
    paymentViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paymentViewController animated:YES];
}

- (void)wu_accountHeadView:(ZWAccountHeadView *)accountHeadView buttonClick:(UIButton *)button
{
    ZWAccoubtAddressController *accoubtAddressController;
    ZWAccountPayStyleController *accoubtPayStyleController;
    switch (button.tag)
    {
        case 1:
//            收货人
            WuLog(@"收货人");
            accoubtAddressController = [[ZWAccoubtAddressController alloc] init];
            [self.navigationController pushViewController:accoubtAddressController animated:YES];
            break;
        case 2:
//            付款方式
            WuLog(@"付款方式");
            accoubtPayStyleController = [[ZWAccountPayStyleController alloc] init];
            [self.navigationController pushViewController:accoubtPayStyleController animated:YES];
            break;
            
        default:
            break;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWAccountListCell *cell = [ZWAccountListCell wu_cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
#warning 传递数据模型
    ZWAccountItemsList *items = self.itemsGroup[indexPath.row];
    cell.items = items;
    return cell;
}

-(void)setAddressItems:(ZWAddressItems *)addressItems
{
    _addressItems = addressItems;
    self.headView.addressItem = addressItems;
}

-(void)setPayStyleItems:(ZWPayStyleItems *)payStyleItems
{
    _payStyleItems = payStyleItems;
    self.headView.payStyleItem = payStyleItems;
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
