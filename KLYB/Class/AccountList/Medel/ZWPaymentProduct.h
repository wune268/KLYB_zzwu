//
//  ZWPaymentProduct.h
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWPaymentProduct : NSObject

/**
 *  商品图片
 */
//@property(copy,nonatomic)NSString *imageName;

/**
 *  商品标题
 */
@property(copy,nonatomic)NSString *goodsTitle;

/**
 *  商品描述
 */
@property (nonatomic, copy) NSString *sellerSubject;

/**
 *  商品总价
 */
@property(copy,nonatomic)NSString *goodsPrice;

/**
 *  商品订单号
 */
@property (nonatomic, copy) NSString *sellerGoodsID;

/**
 *  支付方式
 */
@property (nonatomic, copy) NSString *payStyle;

/**
 *  快递方式
 */
@property(copy,nonatomic)NSString *expressStyle;

/**
 *  回调地址
 */
@property (nonatomic, copy) NSString *returnUrl;

/**
 *  折扣金额
 */
@property(copy,nonatomic)NSString *endPayTiem;

@end
