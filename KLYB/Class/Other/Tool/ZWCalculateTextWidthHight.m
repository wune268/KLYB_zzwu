//
//  ZWCalculatetextWidthHight.m
//  KLYB
//
//  Created by ZZWU on 15/12/25.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCalculateTextWidthHight.h"

@implementation ZWCalculateTextWidthHight

+ (CGRect)wu_calculateText:(NSString *)textName textSize:(CGFloat)textSize
{
    CGRect rect = [textName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:textName size:textSize],NSFontAttributeName, nil] context:nil];
    return rect;
}

@end
