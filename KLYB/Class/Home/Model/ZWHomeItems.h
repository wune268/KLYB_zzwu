//
//  ZWHomeItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWHomeItems : NSObject

/**
 *  商品图片
 */
@property(nonatomic,copy)NSString *icon;

/**
 *  商品描述
 */
@property(nonatomic,copy)NSString *title;

/**
 *  商品价格
 */
@property(nonatomic,copy)NSString *price;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemsWithDict:(NSDictionary *)dict;

@end
