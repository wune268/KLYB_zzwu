//
//  ZWMeTableViewCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMeTableViewCell.h"
#import "ZWMeGroup.h"
#import "ZWMeItem.h"
#import "ZWMeArrowItem.h"
#import "ZWMeSwitchItem.h"

@interface ZWMeTableViewCell ()

/**
 *  箭头
 */
@property (nonatomic, strong) UIImageView *arrowView;

/**
 *  开关
 */
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation ZWMeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(wu_switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

/**
 *  监听开关状态改变
 */
- (void)wu_switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

/**
 *  创建cell
 */
+ (instancetype)wu_cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Me";
    ZWMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWMeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItem:(ZWMeSwitchItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self wu_setupData];
    
    // 2.设置右边的内容
    [self wu_setupRightContent];
}

/**
 *  设置右边的内容
 */
- (void)wu_setupRightContent
{
    if ([self.item isKindOfClass:[ZWMeArrowItem class]]) {
        
        // 箭头
        self.accessoryView = self.arrowView;
    }else if ([self.item isKindOfClass:[ZWMeSwitchItem class]]) {

        // 开关
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 设置开关的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
    }
    else {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

/**
 *  设置数据
 */
- (void)wu_setupData
{
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    self.textLabel.text = self.item.title;
}

@end
