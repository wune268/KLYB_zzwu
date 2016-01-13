//
//  ZWBrandGroup.h
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWBrandGroup : NSObject

/**
 *  这组的标题
 */
@property (nonatomic, copy) NSString *letter;
/**
 *  存放的所有的品牌(里面装的都是ZWBrandItems模型)
 */
@property (nonatomic, strong) NSArray *brands;

//+ (instancetype)groupWithDict:(NSDictionary *)dict;
//- (instancetype)initWithDict:(NSDictionary *)dict;

@end
