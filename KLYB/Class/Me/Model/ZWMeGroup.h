//
//  ZWMeGroup.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWMeGroup : NSObject

/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *header;

/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footer;

/**
 *  存放着这组所有行的模型数据(这个数组中都是ZWMeItems对象)
 */
@property (nonatomic, strong) NSArray *items;

@end
