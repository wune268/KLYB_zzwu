//
//  ZWPaymentViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWPaymentViewController.h"
#import "ZWPaymentProduct.h"
#import "ZWPayMentLabel.h"
#import "ZWSubmitOrdersViewController.h"
#import "ZWNavigationController.h"
#import "ZWAccountListHttpTool.h"
#import "ZWAlipayResult.h"

//集成支付宝
#import "ZWAlipayRequestConfig.h"

@interface ZWPaymentViewController ()

@property(nonatomic,weak) ZWPayMentLabel *detail_goodsID;
@property(nonatomic,weak) ZWPayMentLabel *detail_payPrice;
@property(nonatomic,weak) ZWPayMentLabel *detail_payStyle;
@property(nonatomic,weak) ZWPayMentLabel *detail_expressStyle;
@property(nonatomic,weak) UIImageView *accountView;

@property(nonatomic,strong) ZWPaymentProduct *paymentProduct;

@end

@implementation ZWPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wu_sentBuildList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wu_alipayResult:) name:@"AlipayResult" object:nil];
}

- (void) wu_sentBuildList
{
    [ZWAccountListHttpTool wu_postBuildAccountListWithParams:_buildListParams success:^(ZWPaymentProduct *paymentProduct) {
        if (paymentProduct) {
            self.paymentProduct = paymentProduct;
            [self wu_creatMainView];
        }
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
}

- (void)dealloc
{
    WuLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)wu_creatMainView
{
    UIImageView *accountView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, 200)];
//    accountView.image = [UIImage imageNamed:_product.imageName];
    accountView.image = [UIImage imageNamed:@"success"];
    [self.view addSubview:accountView];
    
    CGFloat goodsID_X = 0;
    CGFloat goodsID_W = 0;
    
    Screen_Width <= 320.0 ? (goodsID_X = 15, goodsID_W = 65) : (goodsID_X = 30, goodsID_W = 80);
    
    ZWPayMentLabel *goodsID = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID_X, accountView.frame.size.height + accountView.frame.origin.y + 10, goodsID_W, 30)];
    goodsID.text = @"商品订单:";
    goodsID.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:goodsID];
    
    ZWPayMentLabel *goodsID_detail = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID.frame.size.width + goodsID.frame.origin.x + 5, accountView.frame.size.height + accountView.frame.origin.y + 10, Screen_Width - goodsID.frame.size.width - goodsID_X * 2 - 10, 30)];
    goodsID_detail.text = self.paymentProduct.sellerGoodsID;
    self.detail_goodsID = goodsID_detail;
    [self.view addSubview:goodsID_detail];
    
    ZWPayMentLabel *payPrice = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID_X, goodsID.frame.size.height + goodsID.frame.origin.y + 10, goodsID_W, 30)];
    payPrice.text = @"商品总价:";
    payPrice.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:payPrice];
    
    ZWPayMentLabel *payPrice_detail = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID.frame.size.width + goodsID.frame.origin.x + 5, goodsID.frame.size.height + goodsID.frame.origin.y + 10, Screen_Width - goodsID.frame.size.width - goodsID_X * 2 - 10, 30)];
    payPrice_detail.text = self.paymentProduct.goodsPrice;
    self.detail_payPrice = payPrice_detail;
    [self.view addSubview:payPrice_detail];
    
    ZWPayMentLabel *payStyle = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID_X, payPrice.frame.size.height + payPrice.frame.origin.y + 10, goodsID_W, 30)];
    payStyle.text = @"支付方式:";
    payStyle.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:payStyle];
    
    ZWPayMentLabel *payStyle_detail = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID.frame.size.width + goodsID.frame.origin.x + 5, payPrice.frame.size.height + payPrice.frame.origin.y + 10, Screen_Width - goodsID.frame.size.width - goodsID_X * 2 - 10, 30)];
    payStyle_detail.text = self.paymentProduct.payStyle;
    self.detail_payStyle = payStyle_detail;
    [self.view addSubview:payStyle_detail];
    
    ZWPayMentLabel *expressStyle = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID_X, payStyle.frame.size.height + payStyle.frame.origin.y + 10, goodsID_W, 30)];
    expressStyle.text = @"快递方式:";
    expressStyle.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:expressStyle];
    
    ZWPayMentLabel *expressStyle_detail = [[ZWPayMentLabel alloc] initWithFrame:CGRectMake(goodsID.frame.size.width + goodsID.frame.origin.x + 5, payStyle.frame.size.height + payStyle.frame.origin.y + 10, Screen_Width - goodsID.frame.size.width - goodsID_X * 2 - 10, 30)];
    expressStyle_detail.text = @"顺丰包邮";
    self.detail_expressStyle = expressStyle_detail;
    [self.view addSubview:expressStyle_detail];
    
    UIButton *checkListButton = [[UIButton alloc] initWithFrame:CGRectMake(goodsID_X, expressStyle.frame.size.height + expressStyle.frame.origin.y + 10, Screen_Width - goodsID_X * 2 - 130, 40)];
    [checkListButton setTitle:@"查看订单" forState:UIControlStateNormal];
    [checkListButton setBackgroundColor:[UIColor colorWithRed:226/255.0 green:253/255.0 blue:255/255.0 alpha:1.0]];
    [checkListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkListButton addTarget:self action:@selector(wu_checkListButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkListButton];
    
    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(checkListButton.frame.origin.x + checkListButton.frame.size.width + 5, expressStyle.frame.size.height + expressStyle.frame.origin.y + 10, 120, 40)];
    [payButton setTitle:@"立即付款" forState:UIControlStateNormal];
    [payButton setBackgroundColor:[UIColor redColor]];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(wu_payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
}

- (void)wu_checkListButtonClick:(UIButton *)button
{
    WuLog(@"checkListButtonClick");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 生成订单的信息用于支付
-(void)wu_payButtonClick:(UIButton *)button
{
    [ZWAlipayRequestConfig wu_alipayWithTradeNO:self.paymentProduct.sellerGoodsID
                                    productName:self.paymentProduct.goodsTitle
                             productDescription:self.paymentProduct.goodsTitle
                                         amount:[NSString stringWithFormat:@"%.2f",[self.paymentProduct.goodsPrice doubleValue]]
                                         itBPay:@"30m" success:^(ZWAlipayResult *alipayResult)
    {
//        WuLog(@"alipayResultalipayResultalipayResult---%@",alipayResult.memo);
//        WuLog(@"alipayResultalipayResultalipayResult---%@",alipayResult.result);
//        WuLog(@"alipayResultalipayResultalipayResult---%@",alipayResult.resultStatus);
        if ([alipayResult.resultStatus  isEqual: @"9000"] && ([alipayResult.result rangeOfString:@"success=\"true\""].location != NSNotFound )) {
# warning 未测试
            WuLog(@"支付成功");
            [self wu_alipayResult:nil];
        }
    }];
}

//ResultStatus={9000};memo={};result={partner="2088101568358171"&seller_id="xxx@alipay.com"&out_trade_no="0819145412-6177"&subject="测试"&body="测试测试"&total_fee="0.01"&notify_url="http://notify.msp.hk/notify.htm"&service="mobile.securitypay.pay"&payment_type="1"&_input_charset="utf-8"&it_b_pay="30m"&success="true"&sign_type="RSA"&sign="hkFZr+zE9499nuqDNLZEF7W75RFFPsly876QuRSeN8WMaUgcdR00IKy5ZyBJ4eldhoJ/2zghqrD4E2G2mNjs3aE+HCLiBXrPDNdLKCZgSOIqmv46TfPTEqopYfhs+o5fZzXxt34fwdrzN4mX6S13cr3UwmEV4L3Ffir/02RBVtU="}

- (void)wu_alipayResult:(NSNotification *)notification
{
//    处理支付结果
    WuLog(@"notification-----%@", notification);
    ZWSubmitOrdersViewController *submitOrdersViewController = [[ZWSubmitOrdersViewController alloc] init];
    submitOrdersViewController.title = @"支付完成";
    ZWNavigationController *naV = [[ZWNavigationController alloc] initWithRootViewController:submitOrdersViewController];
    [self.navigationController presentViewController:naV animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
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
