//
//  ZWGoodsInfoCarItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/10.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWGoodsInfoCarItems : NSObject

/**
 *  商品图片
 */
@property(copy,nonatomic)NSString *imageURL;

/**
 *  商品标题
 */
@property(copy,nonatomic)NSString *goodsTitle;

/**
 *  商品单价
 */
@property(copy,nonatomic)NSString *goodsPrice;

/**
 *  是否选中状态
 */
@property(assign,nonatomic)BOOL selectState;

/**
 *  商品个数
 */
@property(copy,nonatomic)NSString *goodsNum;

/**
 *  商品ID
 */
@property(copy,nonatomic)NSString *goodsID;

/**
 *  商品原价
 */
@property(copy,nonatomic)NSString *goodsOriginalPrice;

//-(instancetype)initWithDict:(NSDictionary *)dict;
//+(instancetype)itemsWithDict:(NSDictionary *)dict;

@end
