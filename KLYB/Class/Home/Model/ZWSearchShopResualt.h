//
//  ZWSearchShopResualt.h
//  KLYB
//
//  Created by ZZWU on 16/1/8.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

@interface ZWSearchShopResualt : NSObject

/**
 *  搜索关键字
 */
@property (nonatomic, copy) NSString *k;

/**
 *  满足条件的商品
 */
@property (nonatomic, copy) NSArray *itemList;

/**
 *  满足搜索条件的商品总数
 */
@property (nonatomic, copy) NSString *num;

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
