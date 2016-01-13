//
//  ZWAccountListCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountListCell.h"
//#import "ZWAccountProduct.h"
#import "ZWAccountItemsList.h"

@interface ZWAccountListCell ()

@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *title;
@property(nonatomic,weak) UILabel *sellerPrice;
@property(nonatomic,weak) UILabel *sellerStyle;
@property(nonatomic,weak) UILabel *sellerSize;
@property(nonatomic,weak) UILabel *sellerCount;

@end

@implementation ZWAccountListCell

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

- (void)wu_creatViewCell
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
    [self addSubview:imageView];
    self.iconView = imageView;
    
    CGFloat titleX = imageView.frame.size.width + imageView.frame.origin.x + 5;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 5, Screen_Width - titleX - 20, 45)];
    self.title = title;
    title.numberOfLines = 0;
    [self addSubview:title];
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(titleX, title.frame.size.height + title.frame.origin.y + 5, 45, 25)];
    price.text = @"价格：";
    price.font = [UIFont systemFontOfSize:15];
    price.textColor = [UIColor grayColor];
    [self addSubview:price];
    
    CGFloat PriceX = titleX + price.frame.size.width + 5;
    
    UILabel *sellerPrice = [[UILabel alloc] initWithFrame:CGRectMake(PriceX, price.frame.origin.y, 70, 25)];
    self.sellerPrice = sellerPrice;
    sellerPrice.textColor = [UIColor redColor];
    [self addSubview:sellerPrice];
    
//    UILabel *style = [[UILabel alloc] initWithFrame:CGRectMake(Screen_Width - 120, title.frame.size.height + title.frame.origin.y + 5, 45, 25)];
//    style.text = @"款式：";
//    style.font = [UIFont systemFontOfSize:15];
//    style.textColor = [UIColor grayColor];
//    [self addSubview:style];
//    
//    UILabel *sellerStyle = [[UILabel alloc] initWithFrame:CGRectMake(style.frame.size.width + style.frame.origin.x + 5, price.frame.origin.y, 70, 25)];
//    self.sellerStyle = sellerStyle;
//    sellerStyle.text = @"欧美";
//    sellerStyle.textColor = [UIColor redColor];
//    [self addSubview:sellerStyle];
    
//    UILabel *size = [[UILabel alloc] initWithFrame:CGRectMake(titleX, price.frame.size.height + price.frame.origin.y + 5, 70, 25)];
//    size.text = @"大小：";
//    size.font = [UIFont systemFontOfSize:15];
//    size.textColor = [UIColor grayColor];
//    [self addSubview:size];
//    
//    UILabel *sellerSize = [[UILabel alloc] initWithFrame:CGRectMake(PriceX, size.frame.origin.y, 70, 25)];
//    self.sellerSize = sellerSize;
//    sellerSize.text = @"小";
//    sellerSize.textColor = [UIColor redColor];
//    [self addSubview:sellerSize];
    
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(titleX, price.frame.size.height + price.frame.origin.y + 5, 70, 25)];
    count.text = @"数量：";
    count.font = [UIFont systemFontOfSize:15];
    count.textColor = [UIColor grayColor];
    [self addSubview:count];
    
    UILabel *sellerCount = [[UILabel alloc] initWithFrame:CGRectMake(PriceX, count.frame.origin.y, 70, 25)];
    self.sellerCount = sellerCount;
    sellerCount.textColor = [UIColor redColor];
    [self addSubview:sellerCount];
    
//    Screen_Width <= 320.0 ? (collectionViewW = Screen_Width * 0.48) : (collectionViewW = Screen_Width * 0.48);
}

/**
 *  创建cell
 */
+ (instancetype)wu_cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"accountList";
    ZWAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWAccountListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setItems:(ZWAccountItemsList *)items
{
    _items = items;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpResourcesAddress,items.imgUrl]] placeholderImage:[UIImage imageNamed:@"德国爱他美2段详情图1"]];
    self.title.text = items.name;
    self.sellerPrice.text = [NSString stringWithFormat:@"¥%@",items.price];
    self.sellerCount.text = items.number;
//    self.sellerStyle.text = items.sellerStyle;
//    self.sellerSize.text = items.sellerSize;
}

@end
