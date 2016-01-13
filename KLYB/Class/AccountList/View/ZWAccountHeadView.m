//
//  ZWAccountHeadView.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountHeadView.h"
#import "ZWAddressItems.h"
#import "ZWPayStyleItems.h"
#import "ZWAccountPayTypeList.h"
#import "ZWAccountAddressItems.h"

@interface ZWAccountHeadView ()

@property (nonatomic, strong) UIButton *nameBtn;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UILabel *sellerName;
@property (nonatomic, strong) UILabel *sellerCount;

@end

@implementation ZWAccountHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self wu_creatView:frame];
    }
    return self;
}

- (void)wu_creatView:(CGRect)frame
{
    //收货人信息
    UIButton *nameBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, 70)];
    nameBtn.tag = 1;
    [nameBtn addTarget:self action:@selector(wu_nameMent:) forControlEvents:UIControlEventTouchUpInside];
    nameBtn.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
    nameBtn.backgroundColor=[UIColor whiteColor];
    [nameBtn setTitle:@"收货人" forState:UIControlStateNormal];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    nameBtn.titleLabel.lineBreakMode = 0;
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:nameBtn];
    self.nameBtn = nameBtn;
    
//    UIImageView *nameBtnImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
//    nameBtnImage.image = [UIImage imageNamed:@"dd_card"];
//    [nameBtn addSubview:nameBtnImage];
    
//    UILabel *payTitle = [[UILabel alloc]initWithFrame:CGRectMake(nameBtnImage.frame.size.width+nameBtnImage.frame.origin.x+5, 10, frame.size.width - 40, 20)];
//    if ([[NSUserDefaults standardUserDefaults ]objectForKey:@"zhifufangshi"]==nil)
//    {
//        payTitle.text=@"请选择支付方式";
//    }else{
//        payTitle.text=[[NSUserDefaults standardUserDefaults ]objectForKey:@"zhifufangshi"];
//    }
    
//    title_label1.font=[UIFont systemFontOfSize:12];
//    title_label1.backgroundColor=[UIColor clearColor];
//    title_label1.textColor =hui2;
//    title_label1.textAlignment=0;
//    [btn1 addSubview:title_label1];
    
    //付款方式
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, nameBtn.frame.size.height +nameBtn.frame.origin.y + 10, frame.size.width, 45)];
    payBtn.tag = 2;
    [payBtn addTarget:self action:@selector(wu_payment:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
    payBtn.backgroundColor=[UIColor whiteColor];
    [payBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payBtn setTitle:@"付款方式" forState:UIControlStateNormal];
    [self addSubview:payBtn];
    self.payBtn = payBtn;
    
//    UIView *sellerCell=[[UIView alloc]initWithFrame:CGRectMake(0, payBtn.frame.size.height + payBtn.frame.origin.y + 10, frame.size.width, 45)];
//    sellerCell.backgroundColor = [UIColor whiteColor];
//    [self addSubview:sellerCell];
    
//    UILabel *sellerTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 40, 30)];
//    sellerTitle.text=@"商家";
//    sellerTitle.font=[UIFont systemFontOfSize:12];
//    sellerTitle.backgroundColor=[UIColor clearColor];
//    sellerTitle.textColor =[UIColor blackColor];
//    sellerTitle.textAlignment=0;
//    [sellerCell addSubview:sellerTitle];
//    
//    UILabel *sellerName = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitle.frame.size.width + sellerTitle.frame.origin.x + 5, 5, frame.size.width - 100 - sellerTitle.frame.size.width - sellerTitle.frame.origin.x - 5, 30)];
//    sellerName.text = @"莎儿家";
//    sellerName.font=[UIFont systemFontOfSize:14];
//    sellerName.backgroundColor=[UIColor clearColor];
//    sellerName.textColor = [UIColor blackColor];
//    sellerName.textAlignment=0;
//    [sellerCell addSubview:sellerName];
//    self.sellerName = sellerName;
//    
//    UILabel *sellerCount = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 100, 5, 80, 30)];
//    sellerCount.text=@"共:3件";
//    sellerCount.font=[UIFont systemFontOfSize:12];
//    sellerCount.backgroundColor=[UIColor clearColor];
//    sellerCount.textColor = [UIColor redColor];
//    sellerCount.textAlignment=0;
//    [sellerCell addSubview:sellerCount];
//    self.sellerCount = sellerCount;
    WuLog(@"sellerCell--%f",payBtn.frame.origin.y);
}

-(void)wu_payment:(UIButton *)button
{
    WuLog(@"payment");
    if ([self.delegate respondsToSelector:@selector(wu_accountHeadView:buttonClick:)]) {
        [self.delegate wu_accountHeadView:self buttonClick:button];
    }
}

-(void)wu_nameMent:(UIButton *)button
{
    WuLog(@"nameMent");
    if ([self.delegate respondsToSelector:@selector(wu_accountHeadView:buttonClick:)]) {
        [self.delegate wu_accountHeadView:self buttonClick:button];
    }
}

- (void)setAccountAddressItems:(ZWAccountAddressItems *)accountAddressItems
{
    _accountAddressItems = accountAddressItems;
    [self.nameBtn setTitle:[NSString stringWithFormat:@"收货人：%@\t联系方式：%@\n收货地址：%@", accountAddressItems.receiver, accountAddressItems.tel, accountAddressItems.addressDetail] forState:UIControlStateNormal];
    self.nameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setAccountPayTypeList:(ZWAccountPayTypeList *)accountPayTypeList
{
    _accountPayTypeList = accountPayTypeList;
    [self.payBtn setTitle:[NSString stringWithFormat:@"%@",accountPayTypeList.name] forState:UIControlStateNormal];
}

-(void)setAddressItem:(ZWAddressItems *)addressItem
{
    _addressItem = addressItem;
    [self.nameBtn setTitle:[NSString stringWithFormat:@"收货人：%@\t手机号码：%@\n收货地址：%@",addressItem.userName, addressItem.userPhone, addressItem.userAddress] forState:UIControlStateNormal];
    self.nameBtn.titleLabel.font = [UIFont systemFontOfSize:15];
}

-(void)setPayStyleItem:(ZWPayStyleItems *)payStyleItem
{
    _payStyleItem = payStyleItem;
    [self.payBtn setTitle:[NSString stringWithFormat:@"%@",payStyleItem.name] forState:UIControlStateNormal];
}

@end
