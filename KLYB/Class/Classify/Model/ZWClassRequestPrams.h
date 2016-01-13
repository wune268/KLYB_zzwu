//
//  ZWClassRequestPrams.h
//  KLYB
//
//  Created by ZZWU on 15/12/28.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWClassRequestPrams : NSObject

/**
 *  分类ID（必须）
 */
@property(nonatomic,copy)NSString *categoryId;

/**
 *  分类级别（必须）
 */
@property(nonatomic,copy)NSString *level;

/**
 *  分类品牌
 */
@property(nonatomic,copy)NSString *brand;

/**
 *  返回页码
 */
@property(nonatomic,copy)NSNumber *page;

/**
 *  默认返回数量
 */
@property(nonatomic,copy)NSNumber *rows;

@end
