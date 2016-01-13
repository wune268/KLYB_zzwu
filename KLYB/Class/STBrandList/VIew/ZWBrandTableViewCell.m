//
//  ZWBrandTableViewCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWBrandTableViewCell.h"
#import "ZWBrandItems.h"

@interface ZWBrandTableViewCell ()

@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *title;

@end

@implementation ZWBrandTableViewCell

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
    ZWBrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWBrandTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [self addSubview:imageView];
    self.iconView = imageView;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width + imageView.frame.origin.x + 10, imageView.frame.origin.y, Screen_Width - imageView.frame.size.width - imageView.frame.origin.x - 20, imageView.frame.size.height)];
    self.title = title;
    title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:title];
}



- (void)setBrandItemsData:(ZWBrandItems *)brandItemsData
{
    _brandItemsData = brandItemsData;
    
//    self.iconView.image = [UIImage imageNamed:@"jiankangshipin"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress, brandItemsData.imgUrl]] placeholderImage:[UIImage imageNamed:@"jiankangshipin"]];
//    self.imageView sd
    self.title.text = brandItemsData.name;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
