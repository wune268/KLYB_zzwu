//
//  ZWAccountOrderResultItems.h
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@class ZWAccountAddressItems;

@interface ZWAccountOrderResultItems : NSObject

/**
 *  邮费
 */
@property(nonatomic,copy)NSString *shippingFee;

/**
 *  折扣金额
 */
@property(nonatomic,copy)NSString *rebate;

/**
 *  实际支付
 */
@property(nonatomic,copy)NSString *payFee;

/**
 *  商品金额
 */
@property(nonatomic,copy)NSString *itemAmount;

/**
 *  收货地址数组
 */
@property(nonatomic,strong)ZWAccountAddressItems *address;

/**
 *  购买商品数组
 */
@property(nonatomic,strong)NSArray *itemList;

/**
 *  支付方式数组
 */
@property(nonatomic,strong)NSArray *payTypeList;

/**
 *  配送方式数组
 */
@property(nonatomic,strong)NSArray *sendTypeList;

@end
