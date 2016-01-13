//
//  ZWCommodityDetailsHeadView.m
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCommodityDetailsHeadView.h"
#import "ZWGoodListLabel.h"
#import "ZWCommodityDetails.h"
#import "ZWScrollerView.h"

@interface ZWCommodityDetailsHeadView ()<ZWScrollerViewDelegate>

/**
 *  商品图片
 */
@property(nonatomic,weak)UIImageView *shop_ImageView;
/**
 *  商品名字
 */
@property(nonatomic,weak)UILabel *shop_Name;
/**
 *  售价
 */
@property(nonatomic,weak)UILabel *shop_price_New;
/**
 *  原价
 */
@property(nonatomic,weak)UILabel *shop_price_Old;
/**
 *  商品类型
 */
@property(nonatomic,weak)UILabel *shop_Type;
/**
 *  邮费
 */
@property(nonatomic,weak)UILabel *shop_Postage;
/**
 *  库存
 */
@property(nonatomic,weak)UILabel *shop_Stocks;
/**
 *  销量
 */
@property(nonatomic,weak)UILabel *shop_Sale;

/**
 *  销量
 */
@property(nonatomic,weak)UILabel *shop_Score;


/**
 *  销量
 */
@property(nonatomic,weak)UILabel *shop_AttrsList;

@end

@implementation ZWCommodityDetailsHeadView

- (instancetype)initWithFrame:(CGRect)frame commodityDetails:(ZWCommodityDetails *)commodityDetails
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self wu_creatViewWithFrame:frame commodityDetails:commodityDetails];
    }
    return self;
}

-(void)wu_creatViewWithFrame:(CGRect)frame
            commodityDetails:(ZWCommodityDetails *)commodityDetails
{
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 160)];
//    imageView.image = [UIImage imageNamed:@"huo_naifen"];
//    imageView.backgroundColor=[UIColor clearColor];
//    [self addSubview:imageView];
//    self.shop_ImageView = imageView;
    
    ZWScrollerView *scrollerView = [[ZWScrollerView alloc] initWithFrameRect:CGRectMake(0, 0, frame.size.width, 160) scrolArray:commodityDetails.shop_ImgList type:1];
    scrollerView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollerView];
    
    UIView *bigView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollerView.frame.size.height + scrollerView.frame.origin.y + 10, frame.size.width, 35)];
    bigView.layer.borderWidth = 2;
    bigView.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    
    bigView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bigView];
    
    ZWGoodListLabel *shop_Name = [[ZWGoodListLabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 35)];
    shop_Name.text = @"澳洲原装进口奶粉";
    shop_Name.font = [UIFont systemFontOfSize:15];
    shop_Name.textColor = [UIColor colorWithRed:.3 green:.3 blue:.3 alpha:1.0];
    shop_Name.textAlignment = NSTextAlignmentLeft;
    self.shop_Name = shop_Name;
    [bigView addSubview:shop_Name];
    
    
    UIView *bigView0 = [[UIView alloc] initWithFrame:CGRectMake(0, bigView.frame.size.height + bigView.frame.origin.y + 10, frame.size.width, 44)];
    bigView0.layer.borderWidth = 1;
    bigView0.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    bigView0.backgroundColor = [UIColor whiteColor];
    [self addSubview:bigView0];
    
    ZWGoodListLabel *shop_price_New=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(0, 7, bigView0.frame.size.width * 0.3, 30)];
    shop_price_New.text = @"¥128.00";
    shop_price_New.font = [UIFont systemFontOfSize:25];
    shop_price_New.textAlignment = NSTextAlignmentRight;
    self.shop_price_New = shop_price_New;
    [bigView0 addSubview:shop_price_New];

    ZWGoodListLabel *shop_price_Old=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView0.frame.size.width * 0.3 + 5, 17, bigView0.frame.size.width * 0.5 * 0.5, 20)];
    shop_price_Old.text = @"¥196.00";
    shop_price_Old.font = [UIFont systemFontOfSize:18];
    shop_price_Old.textColor =[UIColor grayColor];
    self.shop_price_Old = shop_price_Old;
    [bigView0 addSubview:shop_price_Old];

    UIImageView *line01 = [[UIImageView alloc]initWithFrame:CGRectMake(shop_price_Old.frame.size.width * 0.1, shop_price_Old.frame.size.height * 0.5, shop_price_Old.frame.size.width * 0.8, 1)];
    line01.image = [UIImage imageNamed:@"default_03"];
    [shop_price_Old addSubview:line01];
    
    ZWGoodListLabel *shop_Type=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView0.frame.size.width - bigView0.frame.size.width * 0.2 - 5, 7, bigView0.frame.size.width * 0.2, 30)];
    shop_Type.text=@"含税";
    shop_Type.font = [UIFont systemFontOfSize:18];
    shop_Type.textColor =[UIColor grayColor];
    self.shop_Type = shop_Type;
    [bigView0 addSubview:shop_Type];
    
    //邮费销量库存
    UIView *bigView1 = [[UIView alloc] initWithFrame:CGRectMake(0, bigView0.frame.size.height + bigView0.frame.origin.y + 10, frame.size.width, 50)];
    bigView1.layer.borderWidth = 1;
    bigView1.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
    bigView1.backgroundColor = [UIColor whiteColor];
    [self addSubview:bigView1];
    
    ZWGoodListLabel *title1 = [[ZWGoodListLabel alloc]initWithFrame:CGRectMake(0, 10, bigView1.frame.size.width/4, 15)];
    title1.text = @"邮费";
    title1.textColor =[UIColor grayColor];
    [bigView1 addSubview:title1];
    
    ZWGoodListLabel *shop_Postage = [[ZWGoodListLabel alloc]initWithFrame:CGRectMake(0, title1.frame.size.height + 10, bigView1.frame.size.width/4, 15)];
    shop_Postage.text = @"包邮";
    self.shop_Postage = shop_Postage;
    [bigView1 addSubview:shop_Postage];
    
    UIImageView *line11=[[UIImageView alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4,(bigView1.frame.size.height - 30) * 0.5, 1, 30)];
    line11.image=[UIImage imageNamed:@"default_03"];
    [bigView1 addSubview:line11];
    
    UIImageView *line12=[[UIImageView alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 2,(bigView1.frame.size.height - 30) * 0.5, 1, 30)];
    line12.image=[UIImage imageNamed:@"default_03"];
    [bigView1 addSubview:line12];
    
    ZWGoodListLabel *title11=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4, 10, bigView1.frame.size.width / 4, 15)];
    title11.text=@"销量";
    title11.textColor =[UIColor grayColor];
    [bigView1 addSubview:title11];
    
    ZWGoodListLabel *shop_Sale=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width/4, title1.frame.size.height + 10, bigView1.frame.size.width / 4, 15)];
    shop_Sale.text=@"41";
    self.shop_Sale = shop_Sale;
    [bigView1 addSubview:shop_Sale];
    
    ZWGoodListLabel *title21=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 2, 10, bigView1.frame.size.width / 4, 15)];
    title21.text=@"库存";
    title21.textColor =[UIColor grayColor];
    [bigView1 addSubview:title21];
    
    ZWGoodListLabel *shop_Stocks=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 2, title1.frame.size.height + 10, bigView1.frame.size.width / 4, 15)];
    shop_Stocks.text=@"11";
    self.shop_Stocks = shop_Stocks;
    [bigView1 addSubview:shop_Stocks];
    
    
    UIImageView *line103=[[UIImageView alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 3,(bigView1.frame.size.height - 30) * 0.5, 1, 30)];
    line103.image=[UIImage imageNamed:@"default_03"];
    [bigView1 addSubview:line103];
    
    ZWGoodListLabel *title12=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 3, 10, bigView1.frame.size.width / 4, 15)];
    title12.text = @"评分";
    title12.textColor =[UIColor grayColor];
    [bigView1 addSubview:title12];
    
    ZWGoodListLabel *shop_Score=[[ZWGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 4 * 3, title1.frame.size.height + 10, bigView1.frame.size.width / 4, 15)];
    shop_Score.text=@"41";
    self.shop_Score = shop_Score;
    [bigView1 addSubview:shop_Score];
    
    
     UIView *bigView2 = [[UIView alloc] initWithFrame:CGRectMake(0, bigView1.frame.size.height + bigView1.frame.origin.y + 10, frame.size.width, 50)];
     bigView2.layer.borderWidth = 1;
     bigView2.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1.0].CGColor;
     bigView2.backgroundColor = [UIColor whiteColor];
     [self addSubview:bigView2];
    
    
    UILabel *shop_AttrsList=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, bigView2.frame.size.width - 20, 40)];
    shop_AttrsList.text = @"";
    shop_AttrsList.textColor =[UIColor grayColor];
    self.shop_AttrsList = shop_AttrsList;
    [bigView2 addSubview:shop_AttrsList];
    
//    WuLog(@"%f",bigView2.frame.size.height + bigView2.frame.origin.y);
     /**
     STGoodListLabel *title1=[[STGoodListLabel alloc]initWithFrame:CGRectMake(0, 10, bigView1.frame.size.width/3, 15)];
     title1.text = @"邮费";
     title1.textColor =[UIColor grayColor];
     [bigView1 addSubview:title1];
     
     STGoodListLabel *shop_Postage=[[STGoodListLabel alloc]initWithFrame:CGRectMake(0, title1.frame.size.height + 10, bigView1.frame.size.width/3, 15)];
     shop_Postage.text = @"包邮";
     self.shop_Postage = shop_Postage;
     [bigView1 addSubview:shop_Postage];
     
     UIImageView *line11=[[UIImageView alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 3,(bigView1.frame.size.height - 30) * 0.5, 1, 30)];
     line11.image=[UIImage imageNamed:@"default_03"];
     [bigView1 addSubview:line11];
     
     UIImageView *line12=[[UIImageView alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 3 * 2,(bigView1.frame.size.height - 30) * 0.5, 1, 30)];
     line12.image=[UIImage imageNamed:@"default_03"];
     [bigView1 addSubview:line12];
     
     STGoodListLabel *title11=[[STGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 3, 10, bigView1.frame.size.width / 3, 15)];
     title11.text=@"销量";
     title11.textColor =[UIColor grayColor];
     [bigView1 addSubview:title11];
     
     STGoodListLabel *shop_Sale=[[STGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width/3, title1.frame.size.height + 10, bigView1.frame.size.width / 3, 15)];
     shop_Sale.text=@"41";
     self.shop_Sale = shop_Sale;
     [bigView1 addSubview:shop_Sale];
     
     STGoodListLabel *title21=[[STGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 3 * 2, 10, bigView1.frame.size.width / 3, 15)];
     title21.text=@"库存";
     title21.textColor =[UIColor grayColor];
     [bigView1 addSubview:title21];
     
     STGoodListLabel *shop_Stocks=[[STGoodListLabel alloc]initWithFrame:CGRectMake(bigView1.frame.size.width / 3 * 2, title1.frame.size.height + 10, bigView1.frame.size.width / 3, 15)];
     shop_Stocks.text=@"11";
     self.shop_Stocks = shop_Stocks;
     [bigView1 addSubview:shop_Stocks];
     */
    
    
    self.shop_Name.text = commodityDetails.shop_Name;
//    self.shop_Postage.text = commodityDetails.shop_Postage;
    self.shop_price_New.text = [NSString stringWithFormat:@"¥%@",commodityDetails.shop_price_New];
    self.shop_price_Old.text = [NSString stringWithFormat:@"¥%@",commodityDetails.shop_price_Old];
    self.shop_Sale.text = commodityDetails.shop_Sales;
    self.shop_Stocks.text = commodityDetails.shop_Stocks;
    self.shop_Type.text = commodityDetails.shop_Type;
    self.shop_Score.text = commodityDetails.shop_Score;
//    NSMutableString *shop_AttrsListStr = [NSMutableString string];
//    for (NSString *str in commodityDetails.shop_AttrsList) {
//        
//    }
    NSString *attrsList = [commodityDetails.shop_AttrsList componentsJoinedByString:@" "];
    self.shop_AttrsList.text = [NSString stringWithFormat:@"品牌：%@ %@",commodityDetails.shop_Brand,attrsList];
    
}

//- (void)wu_scrollerViewDidClicked:(NSUInteger)index URL:(NSString *)strURL
//{
//    WuLog(@"wu_scrollerViewDidClicked");
//}

//-(void)setCommodityDetails:(STCommodityDetails *)commodityDetails
//{
//    _commodityDetails = commodityDetails;
////    设置数据
////    self.shop_ImageView.image = [UIImage imageNamed:commodityDetails.shop_Image];
//    self.shop_Name.text = commodityDetails.shop_Name;
//    self.shop_Postage.text = commodityDetails.shop_Postage;
//    self.shop_price_New.text = commodityDetails.shop_price_New;
//    self.shop_price_Old.text = commodityDetails.shop_price_Old;
//    self.shop_Sale.text = commodityDetails.shop_Sales;
//    self.shop_Stocks.text = commodityDetails.shop_Stocks;
//    self.shop_Tax.text = commodityDetails.shop_Tax;
//}

@end
