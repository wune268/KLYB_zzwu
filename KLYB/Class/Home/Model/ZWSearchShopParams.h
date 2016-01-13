//
//  ZWSearchShopParams.h
//  KLYB
//
//  Created by ZZWU on 16/1/8.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWSearchShopParams : NSObject

/**
 *  搜索关键字
 */
@property (nonatomic, copy) NSString *k;

/**
 *  返回结果的页码，默认为1
 */
@property (nonatomic, copy) NSString *page;

/**
 *  单页返回的记录条数，默认为8
 */
@property (nonatomic, copy) NSString *rows;

/**
 *  是否只搜索有货商品   stock=1为显示有货
 */
@property (nonatomic, copy) NSString *stock;

/**
 *  排序字段    sales：销量  score:评分  price：价格（要结合sord一起使用）
 */
@property (nonatomic, copy) NSString *sidx;

/**
 *  排序类型  asc：升序  desc：降序   （要结合sidx一起使用）
 */
@property (nonatomic, copy) NSString *sord;

@end
