//
//  ZWGoodsListCarCell.m
//  KLYB
//
//  Created by ZZWU on 15/12/10.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWGoodsListCarCell.h"
#import "ZWGoodsInfoCarItems.h"

@interface ZWGoodsListCarCell ()<UITextFieldDelegate>

/**
 *  商品图片
 */
@property(weak,nonatomic)UIImageView *goodsImage;

/**
 *  商品标题
 */
@property(weak,nonatomic)UILabel *goodsTitle;

/**
 *  商品单价
 */
@property(weak,nonatomic)UILabel *goodsPrice;

/**
 *  是否选中状态
 */
@property(assign,nonatomic)BOOL selectState;

/**
 *  商品个数
 */
@property(assign,nonatomic)NSInteger goodsNum;

//@property(nonatomic,weak)UITextField *numTextField;

@property(nonatomic,weak)UILabel *numLabel;

@property(nonatomic,weak)UIButton *selectBtn;

@end

@implementation ZWGoodsListCarCell

/**
 *  创建cell
 *
 */
+(instancetype)wu_cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GoodListCar";
    ZWGoodsListCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZWGoodsListCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
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
    UIButton *selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 20, 110)];
    [selectBtn setImage:[UIImage imageNamed:@"main_bottomBar_circleOpaque_normal_new"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"shopCar_choosed"] forState:UIControlStateSelected];
//    selectBtn.selected = self.selectState;
    self.selectBtn = selectBtn;
    [self addSubview:selectBtn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 110, 110)];
    [self addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"default_01"];
    self.goodsImage = imageView;
    
    CGFloat titleX = imageView.frame.origin.x + imageView.frame.size.width + 5;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 10, Screen_Width - titleX - 5, 40)];
    self.goodsTitle = title;
    title.numberOfLines = 0;
//    title.text = @"新生代雀氏纸尿裤新生代雀氏纸尿裤新生代雀氏纸尿裤新生代雀氏纸尿裤新生代雀氏纸尿裤新生代雀氏纸尿裤";
    title.font = [UIFont systemFontOfSize:13];
    [self addSubview:title];
    
    
    
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(titleX, title.frame.size.height + title.frame.origin.y + 5, 150, 25)];
    self.goodsPrice = price;
//    price.text = @"单价：$15.6";
    price.font = [UIFont systemFontOfSize:15];
    price.textColor = [UIColor redColor];
    [self addSubview:price];
    
    UILabel *sl_label=[[UILabel alloc]initWithFrame:CGRectMake(titleX, price.frame.size.height + price.frame.origin.y + 5, 40, 25)];
    sl_label.text=@"数量";
    sl_label.font=[UIFont systemFontOfSize:12];
    sl_label.textColor = [UIColor grayColor];
    sl_label.textAlignment = NSTextAlignmentCenter;
    sl_label.backgroundColor = [UIColor clearColor];
    sl_label.textAlignment = 0;
    
    [self addSubview:sl_label];
    //按钮
    CGFloat btnCutY = sl_label.frame.origin.y;
    //减
    UIButton *btnCut=[UIButton buttonWithType:0];
    btnCut.frame=CGRectMake(sl_label.frame.size.width + sl_label.frame.origin.x + 5, btnCutY, 25, 25);
    btnCut.tag = -1;
    [btnCut setImage: [UIImage imageNamed:@"camera_publish_delMark"] forState:UIControlStateNormal];
    [btnCut addTarget:self action:@selector(wu_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btnCut];
    
//    UITextField*  numTextField=[[UITextField alloc] initWithFrame:CGRectMake(btnCut.frame.origin.x + btnCut.frame.size.width + 5, btnCutY, 50, 25)];
//    numTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    numTextField.textAlignment = 1;
//    numTextField.delegate = self;
//    numTextField.returnKeyType = UIReturnKeyGo;
////    numTextField.text = @"1";
//    numTextField.textColor = [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
//    numTextField.keyboardType = UIKeyboardTypeDefault;
//    numTextField.userInteractionEnabled=YES;
//    numTextField.layer.borderColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
//    numTextField.layer.borderWidth = 1;
//    numTextField.backgroundColor=[UIColor whiteColor];
//    [self addSubview:numTextField];
//    self.numTextField = numTextField;
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(btnCut.frame.origin.x + btnCut.frame.size.width + 5, btnCutY, 60, 25)];
    [numLabel setTextColor:[UIColor blackColor]];
    numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel = numLabel;
    [self addSubview:numLabel];
    
    //加
    UIButton *btnAdd = [UIButton buttonWithType:0];
    btnAdd.tag = +1;
    btnAdd.frame = CGRectMake(numLabel.frame.origin.x + numLabel.frame.size.width + 5, btnCutY, 25, 25);
    [btnAdd setImage:[UIImage imageNamed:@"camera_publish_addMark"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(wu_buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    if (btnAdd.highlighted) {
//        [btnAdd setBackgroundImage:[UIImage imageNamed:@"default_02"] forState:UIControlStateHighlighted];
//    }
    
    [self addSubview:btnAdd];
}

//设置模型数据
-(void)setItems:(ZWGoodsInfoCarItems *)items
{
    _items = items;
//    if (self.items.imageName) {
//        self.goodsImage.image = [UIImage imageNamed:items.imageName];
//    }
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", httpResourcesAddress,items.imageURL]] placeholderImage:[UIImage imageNamed:@"jiankangshipin"]];
    self.goodsTitle.text = items.goodsTitle;
    self.goodsPrice.text = [NSString stringWithFormat:@"价格：%@",items.goodsPrice]; //items.goodsPrice;
    self.numLabel.text = [NSString stringWithFormat:@"%@",items.goodsNum];
    self.selectBtn.selected = items.selectState;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)wu_buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(wu_goodsListCarCell:buttonDidClick:)]) {
        [self.delegate wu_goodsListCarCell:self buttonDidClick:button];
    }
}

//-(void)btnCut:(id)sender
//{
//    if ([self.numTextField.text intValue] > 1)
//    {
//        self.numTextField.text=[NSString stringWithFormat:@"%d",[self.numTextField.text intValue]-1];
//    }
//}
//
////加
//-(void)btnAdd:(id)sender
//{
//    self.numTextField.text=[NSString stringWithFormat:@"%d",[self.numTextField.text intValue] + 1];
//}
//
////利用正则表达式验证
//-(BOOL)isValidateNumber:(NSString *)number
//{
//    BOOL res = YES;
//    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int i = 0;
//    while (i < number.length) {
//        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//        if (range.length == 0) {
//            res = NO;
//            NSLog(@"请输入数字");
//            break;
//        }
//        i++;
//    }
//    return res;
//}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    return [self isValidateNumber:string];
//    
//}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [self.numTextField resignFirstResponder];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"numTextFieldTextChange" object:textField];
//    return YES;
//}

@end
