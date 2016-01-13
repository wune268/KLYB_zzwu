//
//  ZWEvaluateFrame.h
//  KLYB
//
//  Created by ZZWU on 15/12/29.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWEvaluateItems;

@interface ZWEvaluateFrame : NSObject

@property (nonatomic, strong) ZWEvaluateItems *evaluateItems;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 图标 */
@property (nonatomic, assign, readonly) CGRect scoreViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
