//
//  ZWCommodityDetailsHeadView.h
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWCommodityDetails;

@interface ZWCommodityDetailsHeadView : UIView

/**
 *  ZWCommodityDetails模型
 */
//@property(nonatomic,strong)STCommodityDetails *commodityDetails;

- (instancetype)initWithFrame:(CGRect)frame
             commodityDetails:(ZWCommodityDetails *)commodityDetails;

@end
