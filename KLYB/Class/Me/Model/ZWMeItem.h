//
//  ZWMeItem.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

typedef void (^ZWItemOption)();

@interface ZWMeItem : NSObject

/**
 * 图标
 */
@property(nonatomic, copy)NSString *icon;

/**
 * 文字
 */
@property(nonatomic, copy)NSString *title;

/**
 *  存储block操作
 */
@property(nonatomic,copy)ZWItemOption option;

/**
 *   创建图片和文字cell
 */
+(instancetype) itemWithIcon:(NSString *)icon title:(NSString *)title;

/**
 *  创建文字ell
 */
+(instancetype) itemWithTitle:(NSString *)title;

@end
