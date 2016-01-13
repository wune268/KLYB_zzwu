//
//  ZWGoodsListCarCell.h
//  KLYB
//
//  Created by ZZWU on 15/12/10.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWGoodsListCarCell;
@class ZWGoodsInfoCarItems;

@protocol ZWGoodsListCarCellDelegate <NSObject>

@optional

-(void) wu_goodsListCarCell:(ZWGoodsListCarCell *)cell buttonDidClick:(UIButton *)button;

@end

@interface ZWGoodsListCarCell : UITableViewCell

@property(nonatomic, strong)ZWGoodsInfoCarItems *items;
@property(nonatomic,weak)id<ZWGoodsListCarCellDelegate> delegate;

+(instancetype) wu_cellWithTableView:(UITableView *)tableView;

@end
