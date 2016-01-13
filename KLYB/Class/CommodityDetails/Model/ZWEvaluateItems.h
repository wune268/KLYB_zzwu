//
//  ZWEvaluateItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/25.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWEvaluateItems : NSObject

/**
 *  用户头像URL地址
 */
@property(nonatomic,copy) NSString *user_PortraitUrl;

/**
 *  用户名称
 */
@property(nonatomic,copy) NSString *user_Name;

/**
 *  评价详情
 */
@property(nonatomic,copy) NSString *user_Depict;

/**
 *  用户帐号
 */
@property(nonatomic,copy) NSString *user_Account;

/**
 *  用户评分
 */
@property(nonatomic,copy) NSString *user_CommentScore;

/**
 *  评价时间
 */
@property(nonatomic,copy) NSString *user_EvaluateTime;

/**
 *  评价图片数组
 */
@property(nonatomic,strong) NSArray *user_imgUrl;

@end
