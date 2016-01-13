//
//  ZWMeArrowItem.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMeItem.h"

@interface ZWMeArrowItem : ZWMeItem

@property(nonatomic,assign) Class destVclass;

/**
 *  创建cell模型
 *
 *  @param icon       图片
 *  @param title      文字
 *  @param destVclass 跳转的控制器
 */
+(instancetype)itemWithIcon:(NSString *)icon
                      title:(NSString *)title
                 destVclass:(Class)destVclass;

@end
