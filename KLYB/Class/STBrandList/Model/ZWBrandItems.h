//
//  ZWBrandItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWBrandItems : NSObject

/**
 *  图标
 */
@property (nonatomic, copy) NSString *imgUrl;

/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  品牌ID
 */
@property (nonatomic, copy) NSString *brandID;

//+ (instancetype)itemsWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
