//
//  ZWEvaluateFrame.m
//  KLYB
//
//  Created by ZZWU on 15/12/29.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWEvaluateFrame.h"
#import "ZWEvaluateItems.h"

/** cell的边框宽度 */
#define WuStatusCellBorder 10

@implementation ZWEvaluateFrame

- (void)setEvaluateItems:(ZWEvaluateItems *)evaluateItems
{
    _evaluateItems = evaluateItems;
    // cell的宽度
    CGFloat cellW = Screen_Width;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 5;
    
    // 2.头像
    CGFloat iconViewWH = 20;
    CGFloat iconViewX = WuStatusCellBorder;
    CGFloat iconViewY = WuStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + WuStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = CGSizeMake(180, 20);
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
//     4.评分图标
    CGFloat scoreViewW = 80;
    CGFloat scoreViewH = nameLabelSize.height;
    CGFloat scoreViewX = topViewW - scoreViewW - WuStatusCellBorder;
    CGFloat scoreViewY = nameLabelY;
    _scoreViewF = CGRectMake(scoreViewX, scoreViewY, scoreViewW, scoreViewH);
    
    // 7.正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + WuStatusCellBorder;
    CGSize contentLabelSize = [evaluateItems.user_Depict boundingRectWithSize:CGSizeMake(Screen_Width - WuStatusCellBorder * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if (evaluateItems.user_imgUrl.count) {
        CGFloat photoViewH = 50;
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + WuStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, Screen_Width - 2 * WuStatusCellBorder, photoViewH);
    }
    
//     5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = MAX(CGRectGetMaxY(_contentLabelF), CGRectGetMaxY(_photoViewF)) + WuStatusCellBorder;
//    CGSize timeLabelSize = [evaluateItems.user_EvaluateTime sizeWithFont:[UIFont systemFontOfSize:13]];
    CGSize timeLabelSize = [evaluateItems.user_EvaluateTime boundingRectWithSize:CGSizeMake(topViewW - 2 * WuStatusCellBorder, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_timeLabelF) + WuStatusCellBorder;
    WuLog(@"_cellHeight---%f",_cellHeight);
    
    topViewH = _cellHeight - 5;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
}

@end
