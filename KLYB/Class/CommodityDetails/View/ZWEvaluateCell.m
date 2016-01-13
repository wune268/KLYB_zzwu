//
//  ZWEvaluateCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/25.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWEvaluateCell.h"
#import "ZWCalculateTextWidthHight.h"
#import "ZWEvaluateItems.h"
#import "ZWEvaluateFrame.h"

@interface ZWEvaluateCell ()

/**
 *  用户头像
 */
@property(nonatomic,weak) UIImageView *iconView;

/**
 *  用户名称
 */
@property(nonatomic,weak) UILabel *title_Name;

/**
 *  评价详情
 */
@property(nonatomic,weak) UILabel *title_Depict;

/**
 *  购买详情图片
 */
@property(nonatomic,strong) NSArray *picArray;

/** 配图 */
@property (nonatomic, strong) UIView *photoView;

/**  背景 */
@property (nonatomic, strong) UIView *view;

/**
 *  评价时间
 */
@property (nonatomic, strong) UILabel *time_Name;

/**
 *  评分
 */
@property (nonatomic, strong) UIView *scroView;

@end

@implementation ZWEvaluateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self wu_creatViewCell];
    }
    
    return self;
}

- (NSArray *)picArray
{
    if (_picArray == nil) {
        _picArray = [NSArray array];
    }
    return _picArray;
}

- (void)wu_creatViewCell
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.view = view;
    [self addSubview:view];
    
    // 用户头像
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    self.iconView = imageView;
    
    // 用户呢称
    UILabel *title_Name = [[UILabel alloc] init];
    self.title_Name = title_Name;
    title_Name.textAlignment = NSTextAlignmentLeft;
    title_Name.font = [UIFont systemFontOfSize:13];
    [view addSubview:title_Name];
    
    UIView *scroView = [[UIView alloc] init];
    self.scroView = scroView;
    [view addSubview:scroView];
    
    // 评价详情
    UILabel *title_Depict = [[UILabel alloc] init];
    title_Depict.textAlignment = NSTextAlignmentLeft;
    title_Depict.font = [UIFont systemFontOfSize:15];
    title_Depict.numberOfLines = 0;
    self.title_Depict = title_Depict;
    [self addSubview:title_Depict];
    
    // 配图
    UIView *photoView = [[UIImageView alloc] init];
    self.photoView = photoView;
    [view addSubview:photoView];
    
    // 评价时间
    UILabel *time_Name = [[UILabel alloc] init];
    self.time_Name = time_Name;
    time_Name.textAlignment = NSTextAlignmentLeft;
    time_Name.font = [UIFont systemFontOfSize:13];
    [view addSubview:time_Name];
}

+ (instancetype)wu_cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"Evaluate";
    ZWEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setItemsFrame:(ZWEvaluateFrame *)itemsFrame
{
    _itemsFrame = itemsFrame;
    
    [self setupOriginalData];
    
//    self.title_Name.text = items.user_Account;
//    self.title_Depict.text = items.user_Depict;
////    self.title_Details.text = items.title_Details;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, items.user_PortraitUrl]] placeholderImage:[UIImage imageNamed:@"main_bottomBar_circleOpaque_normal_new"]];
}

/**
 *  设置数据
 */
- (void)setupOriginalData
{
    ZWEvaluateItems *items = self.itemsFrame.evaluateItems;
//    IWUser *user = status.user;
    
    // 1.topView
    self.view.frame = self.itemsFrame.topViewF;
    
    // 2.头像
//    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress,items.user_PortraitUrl]] placeholderImage:[UIImage imageNamed:@"main_bottomBar_circleOpaque_normal_new"]];
    self.iconView.frame = self.itemsFrame.iconViewF;
    
    // 3.昵称
    self.title_Name.text = items.user_Account;
    self.title_Name.frame = self.itemsFrame.nameLabelF;
    
    // 4.vip
//    if (user.isVip) {
//        self.vipView.hidden = NO;
//        self.vipView.image = [UIImage imageWithName:@"common_icon_membership"];
//        self.vipView.frame = self.statusFrame.vipViewF;
//    } else {
//        self.vipView.hidden = YES;
//    }
    
//     5.评分
    self.scroView.frame = self.itemsFrame.scoreViewF;
    CGFloat scroViewY = 0;
    CGFloat scroViewWH = self.itemsFrame.scoreViewF.size.width * 0.2;
    for (int i = 0; i < [items.user_CommentScore intValue]; i ++) {
        CGFloat scroViewX = i * scroViewWH;
        UIImageView *scroView = [[UIImageView alloc] initWithFrame:CGRectMake(scroViewX, scroViewY, scroViewWH, scroViewWH)];
        scroView.image = [UIImage imageNamed:@"gstar2"];
        [self.scroView addSubview:scroView];
    }
    
    // 6.来源
//    self.sourceLabel.text = status.source;
//    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 7.正文
    self.title_Depict.text = items.user_Depict;
    self.title_Depict.frame = self.itemsFrame.contentLabelF;
    
    // 8.配图
    if (items.user_imgUrl.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.itemsFrame.photoViewF;
        CGFloat picViewY = 5;
        CGFloat picViewH = self.itemsFrame.photoViewF.size.height - picViewY;
        CGFloat padding = 10;
        CGFloat picViewW = (self.itemsFrame.photoViewF.size.width - padding * 6) / 5;
        for (int i = 0; i < items.user_imgUrl.count; i ++) {
            CGFloat picViewX = padding + (padding + picViewW) * i;
            UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(picViewX, picViewY, picViewW, picViewH)];
            [picView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, items.user_imgUrl[i]]] placeholderImage:[UIImage imageNamed:@"main_bottomBar_circleOpaque_normal_new"]];
            [self.photoView addSubview:picView];
        }
    } else {
        self.photoView.hidden = YES;
    }
    
    self.time_Name.text = items.user_EvaluateTime;
    self.time_Name.frame = self.itemsFrame.timeLabelF;
}

@end
