//
//  ZWHomeTableViewCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWItems;

@interface ZWHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)ZWItems *items;

+ (instancetype)wu_cellWithTableView:(UITableView *)tableView;

@end
