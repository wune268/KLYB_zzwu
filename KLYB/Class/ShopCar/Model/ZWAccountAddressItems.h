//
//  ZWAccountAddressItems.h
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWAccountAddressItems : NSObject

/**
 *  详细
 */
@property(nonatomic,copy)NSString *addressDetail;

/**
 *  城市
 */
@property(nonatomic,copy)NSString *city;

/**
 *  国家
 */
@property(nonatomic,copy)NSString *county;

/**
 *  地址ID
 */
@property(nonatomic,copy)NSNumber *addressID;

/**
 *  <#Description#>
 */
@property(nonatomic,copy)NSString *isdefault;

/**
 *  电话
 */
@property(nonatomic,copy)NSString *phone;

/**
 *  省市
 */
@property(nonatomic,copy)NSString *province;

/**
 *  收货人
 */
@property(nonatomic,copy)NSString *receiver;

/**
 *  手机
 */
@property(nonatomic,copy)NSString *tel;

/**
 *  乡镇
 */
@property(nonatomic,copy)NSString *town;

/**
 *  用户ID
 */
@property(nonatomic,copy)NSString *userId;

@end
