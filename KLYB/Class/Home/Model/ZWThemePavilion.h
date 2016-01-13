//
//  ZWThemePavilion.h
//  KLYB
//
//  Created by ZZWU on 15/12/17.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWThemePavilion : NSObject

/**
 *  品牌图片
 */
@property(nonatomic,copy)NSString *imgUrl;

/**
 *  品牌ID
 */
@property(nonatomic,copy)NSString *themePavilionID;

/**
 *  品牌名字
 */
@property(nonatomic,copy)NSString *name;

/**
 *  品牌描述
 */
@property(nonatomic,copy)NSString *remark;

/**
 *  品牌级别
 */
@property(nonatomic,copy)NSString *level;

@end
