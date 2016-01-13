//
//  ZWEvaluateCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/25.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWEvaluateFrame;

@interface ZWEvaluateCell : UITableViewCell

@property(nonatomic,weak)ZWEvaluateFrame *itemsFrame;

+ (instancetype)wu_cellWithtableView:(UITableView *)tableView;

@end
