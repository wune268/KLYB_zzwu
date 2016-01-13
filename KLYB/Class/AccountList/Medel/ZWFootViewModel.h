//
//  ZWFootViewModel.h
//  KLYB
//
//  Created by ZZWU on 15/12/24.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWFootViewModel : NSObject

/**
 *  运费
 */
@property (copy, nonatomic) NSString *postage;

/**
 *   商品总价格
 */
@property (copy, nonatomic) NSString *totalPrice;

/**
 *  快递方式
 */
@property (copy, nonatomic) NSString *sendTtyle;

//@property (copy, nonatomic) NSString *area;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemsWithDict:(NSDictionary *)dict;

@end
