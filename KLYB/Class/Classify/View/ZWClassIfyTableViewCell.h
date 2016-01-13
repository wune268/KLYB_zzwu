//
//  ZWClassIfyTableViewCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWClassifyGroup;
@class ZWBrandGroup;

@interface ZWClassIfyTableViewCell : UITableViewCell

@property(nonatomic, strong)ZWClassifyGroup *group;
@property(nonatomic, strong)ZWBrandGroup *groupB;

+ (instancetype)wu_cellWithTableView:(UITableView *)tableView;

@end
