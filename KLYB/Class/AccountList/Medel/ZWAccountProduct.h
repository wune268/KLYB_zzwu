//
//  ZWAccountProduct.h
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWAccountProduct : NSObject

//@property (nonatomic, copy) NSString *price;
//@property (nonatomic, copy) NSString *subject;
//@property (nonatomic, copy) NSString *body;
//@property (nonatomic, copy) NSString *orderId;
//
//@property (nonatomic, copy) NSString *iconView;
//@property (nonatomic, copy) NSString *sellerPrice;
//@property (nonatomic, copy) NSString *sellerStyle;
//@property (nonatomic, copy) NSString *sellerSize;
//@property (nonatomic, copy) NSString *sellerCount;

/**
 *  商品图片
 */
@property(copy,nonatomic)NSString *imageName;

/**
 *  商品标题
 */
@property(copy,nonatomic)NSString *goodsTitle;

/**
 *  商品描述
 */
//@property (nonatomic, copy) NSString *sellerSubject;

/**
 *  商品单价
 */
@property(copy,nonatomic)NSString *goodsPrice;

/**
 *  是否选中状态
 */
@property(assign,nonatomic)BOOL selectState;

/**
 *  商品个数
 */
@property(copy,nonatomic)NSString *goodsNum;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemsWithDict:(NSDictionary *)dict;

@end
