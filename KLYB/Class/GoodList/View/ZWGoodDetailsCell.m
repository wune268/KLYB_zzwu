//
//  ZWGoodDetailsCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodDetailsCell.h"
#import "ZWGoodDetailsItems.h"

@interface ZWGoodDetailsCell ()

@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *title;
@property(nonatomic,weak) UILabel *price_New;
@property(nonatomic,weak) UILabel *price_Old;

@end

@implementation ZWGoodDetailsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self wu_creatView:frame];
    }
    return self;
}

-(void)wu_creatView:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10, frame.size.width * 0.8)];
//    imageView.image = [UIImage imageNamed:@"muying"];
    self.iconView = imageView;
    [self addSubview:imageView];
    
    UIImageView *hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
    hotImageView.image = [UIImage imageNamed:@"collection_outlet"];
//    self.iconView = hotImageView;
    [self addSubview:hotImageView];

    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5, imageView.frame.size.height + imageView.frame.origin.y, frame.size.width - 10, 20)];
    self.title = title;
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont systemFontOfSize:13];
//    title.numberOfLines = 0;
//    title.text = @"新生代雀氏纸尿裤新生代雀氏纸尿裤";
//    title.backgroundColor = [UIColor yellowColor];
    [self addSubview:title];
    
    UILabel *price_Old = [[UILabel alloc] initWithFrame:CGRectMake(5, title.frame.size.height + title.frame.origin.y, frame.size.width * 0.45, 20)];
    self.price_Old = price_Old;
//    price_Old.text = @"原价：¥19.64";
    price_Old.textAlignment = NSTextAlignmentLeft;
    price_Old.font = [UIFont systemFontOfSize:10];
    price_Old.textColor = [UIColor grayColor];
//    price_Old.backgroundColor = [UIColor redColor];
    [self addSubview:price_Old];
    
    UILabel *price_New = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 0.45 + 5, title.frame.size.height + title.frame.origin.y, frame.size.width * 0.55 - 10, 20)];
    self.price_New = price_New;
//    price_New.text = @"仅售：¥15.64";
    price_New.textAlignment = NSTextAlignmentRight;
    price_New.font = [UIFont systemFontOfSize:11];
    price_New.textColor = [UIColor redColor];
//    price_New.backgroundColor = [UIColor blueColor];
    [self addSubview:price_New];
}

- (void)setCollectionItem:(ZWGoodDetailsItems *)collectionItem
{
    _collectionItem = collectionItem;
//    self.iconView.image = [UIImage imageNamed:collectionItem.imgUrl];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", httpResourcesAddress, collectionItem.imgUrl]] placeholderImage:[UIImage imageNamed:@"default_02"]];
    self.title.text = collectionItem.name;
    self.price_New.text = [NSString stringWithFormat:@"仅售：¥%@", collectionItem.price];
    self.price_Old.text = [NSString stringWithFormat:@"原价：¥%@", collectionItem.originalPrice];
}

@end
