//
//  ZWClassIfyTableViewCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWClassIfyTableViewCell.h"
#import "ZWClassifyGroup.h"
#import "ZWBrandGroup.h"

@implementation ZWClassIfyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)wu_cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Brand";
    ZWClassIfyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[ZWClassIfyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(void)setGroup:(ZWClassifyGroup *)group
{
    
}

-(void)setGroupB:(ZWBrandGroup *)groupB
{
    _groupB = groupB;
    self.textLabel.text = groupB.letter;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
