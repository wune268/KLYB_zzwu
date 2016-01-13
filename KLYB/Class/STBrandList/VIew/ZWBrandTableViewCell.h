//
//  ZWBrandTableViewCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWBrandItems;

@interface ZWBrandTableViewCell : UITableViewCell

+ (instancetype)wu_cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ZWBrandItems *brandItemsData;

@end
