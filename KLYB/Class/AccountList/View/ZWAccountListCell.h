//
//  ZWAccountListCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWAccountItemsList;

@interface ZWAccountListCell : UITableViewCell

@property(nonatomic,weak)ZWAccountItemsList *items;

+ (instancetype)wu_cellWithTableView:(UITableView *)tableView;

@end
