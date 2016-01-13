//
//  ZWHomeTableViewCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWHomeTableViewCell.h"
#import "ZWItems.h"

@interface ZWHomeTableViewCell ()

@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *title;
@property(nonatomic,weak) UILabel *price_New;
@property(nonatomic,weak) UILabel *price_Old;

@end

@implementation ZWHomeTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style
   reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self wu_creatViewCell];
    }
    
    return self;
}

- (void)wu_creatViewCell
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, Screen_Width - 10, 135)];
    [self addSubview:imageView];
//    imageView.image = [UIImage imageNamed:@"huo_naifen"];
    self.iconView = imageView;
    
//    UILabel *price_Old = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 65 - 15, imageView.frame.size.height + imageView.frame.origin.y + 5, 65, 23)];
//    self.price_Old = price_Old;
//    price_Old.text = @"原价：$15.6";
//    price_Old.font = [UIFont systemFontOfSize:10];
//    price_Old.textColor = [UIColor grayColor];
//    [self addSubview:price_Old];
//    
//    UILabel *price_New = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 65 - 15, imageView.frame.size.height + imageView.frame.origin.y + 30, 65, 23)];
//    self.price_New = price_New;
//    price_New.text = @"仅售：$15.6";
//    price_New.font = [UIFont systemFontOfSize:10];
//    price_New.textColor = [UIColor redColor];
//    [self addSubview:price_New];
    
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.frame.size.height + imageView.frame.origin.y + 5, (Screen_Width - 15 * 3) - 65, 45)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, imageView.frame.size.height + imageView.frame.origin.y + 5, Screen_Width - 15 * 2, 45)];
    self.title = title;
    title.textAlignment = NSTextAlignmentCenter;
//    title.font = [UIFont systemFontOfSize:15];
    title.numberOfLines = 0;
//    title.text = @"新生代雀氏纸尿裤新生代雀氏纸尿裤";
    [self addSubview:title];
}

/**
 *  创建cell
 */
+ (instancetype)wu_cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"HomeMessage";
    ZWHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setItems:(ZWItems *)items
{
    _items = items;
    if (self.items.imgUrl) {
//        self.imageView.image = [UIImage imageNamed:self.items.icon];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress,self.items.imgUrl]] placeholderImage:[UIImage imageNamed:@"default_01"]];
    }
//    self.title.text = self.items.name;
//    self.price_Old.text = [NSString stringWithFormat:@"原价：%@", self.items.originalPrice];
//    self.price_New.text = [NSString stringWithFormat:@"现价：%@", self.items.price];
}

@end
