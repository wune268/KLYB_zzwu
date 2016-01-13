//
//  ZWBuildListParams.h
//  KLYB
//
//  Created by ZZWU on 16/1/7.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWBuildListParams : NSObject

/**
 *  商品种类和数量
 */
@property(nonatomic,copy)NSString *orderItem;

/**
 *  收货地址ID
 */
@property(nonatomic,copy)NSNumber *address;

/**
 *  支付方式ID
 */
@property(nonatomic,copy)NSNumber *payType;

/**
 *  配送方式ID
 */
@property(nonatomic,copy)NSNumber *sendType;

@end
