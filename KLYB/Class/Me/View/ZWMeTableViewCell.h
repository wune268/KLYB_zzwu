//
//  ZWMeTableViewCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWMeItem;

@interface ZWMeTableViewCell : UITableViewCell

/**
 *  模型数据
 */
@property (nonatomic, strong) ZWMeItem *item;

/**
 *  创建cell
 */
+ (instancetype)wu_cellWithTableView:(UITableView *)tableView;

@end
