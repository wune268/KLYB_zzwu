//
//  ZWCommodityDetails.h
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWCommodityDetails : NSObject

/**
 *  商品图片数组
 */
@property(nonatomic,strong)NSArray *shop_ImgList;
/**
 *  商品名字
 */
@property(nonatomic,copy)NSString *shop_Name;
/**
 *  售价
 */
@property(nonatomic,copy)NSString *shop_price_New;
/**
 *  原价
 */
@property(nonatomic,copy)NSString *shop_price_Old;
/**
 *  是否含税
 */
//@property(nonatomic,copy)NSString *shop_Tax;
/**
 *  邮费
 */
@property(nonatomic,copy)NSString *shop_Postage;
/**
 *  库存
 */
@property(nonatomic,copy)NSString *shop_Stocks;
/**
 *  销量
 */
@property(nonatomic,copy)NSString *shop_Sales;

/**
 *  商品类型
 */
@property(nonatomic,copy)NSString *shop_Type;

/**
 *  商品评分
 */
@property(nonatomic,copy)NSString *shop_Score;

/**
 *  商品简介
 */
@property(nonatomic,copy)NSString *shop_Remark;

/**
 *  商品ID
 */
@property(nonatomic,copy)NSString *shop_ID;

/**
 *  商品评论总数
 */
@property(nonatomic,copy)NSString *shop_EvaluateNum;

/**
 *  商品评论
 */
@property(nonatomic,strong)NSArray *shop_EvList;

/**
 *  商品品牌
 */
@property(nonatomic,copy)NSString *shop_Brand;

/**
 *  商品属性
 */
@property(nonatomic,strong)NSArray *shop_AttrsList;

@end
