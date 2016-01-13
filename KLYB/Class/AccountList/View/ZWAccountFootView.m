//
//  ZWAccountFootView.m
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAccountFootView.h"
#import "ZWFootViewModel.h"

@interface ZWAccountFootView ()<UITextViewDelegate>

@property(nonatomic,weak)UILabel *accountPrice;

@property(nonatomic,weak)UILabel *labelYFDetail;

@property(nonatomic,weak)UILabel *labelYHDetail;

@end

@implementation ZWAccountFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self wu_creatView:frame];
    }
    return self;
}

- (void)wu_creatView:(CGRect)frame
{
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, frame.size.width - 20, 1)];
    line.image=[UIImage imageNamed:@"line-1"];
    [self addSubview:line];
    
    UILabel *labelYF = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 20)];
    labelYF.text = @"配送方式：";
    labelYF.font = [UIFont systemFontOfSize:12];
    labelYF.backgroundColor = [UIColor clearColor];
    labelYF.textColor = [UIColor grayColor];
    labelYF.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelYF];
    
    UILabel *labelYFDetail = [[UILabel alloc]initWithFrame:CGRectMake(labelYF.frame.size.width + labelYF.frame.origin.x + 5, labelYF.frame.origin.y, frame.size.width - labelYF.frame.size.width - labelYF.frame.origin.x - 30, 20)];
    labelYFDetail.text = @"免运费";
    labelYFDetail.font = [UIFont systemFontOfSize:12];
    labelYFDetail.backgroundColor = [UIColor clearColor];
    labelYFDetail.textColor = [UIColor redColor];
    labelYFDetail.textAlignment = NSTextAlignmentCenter;
    self.labelYFDetail = labelYFDetail;
    [self addSubview:labelYFDetail];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, labelYF.frame.size.height + labelYF.frame.origin.y + 10, frame.size.width - 20, 1)];
    line1.image=[UIImage imageNamed:@"line-1"];
    [self addSubview:line1];
    
    UILabel *accountText = [[UILabel alloc]initWithFrame:CGRectMake(20, line1.frame.origin.y + line1.frame.size.height + 10, 60, 20)];
    accountText.text = @"合      计：";
    accountText.font = [UIFont systemFontOfSize:12];
    accountText.backgroundColor = [UIColor clearColor];
    accountText.textColor = [UIColor grayColor];
    accountText.textAlignment = NSTextAlignmentCenter;
    [self addSubview:accountText];
    
    UILabel *accountPrice=[[UILabel alloc]initWithFrame:CGRectMake(accountText.frame.size.width + accountText.frame.origin.x + 5, line1.frame.origin.y + line1.frame.size.height + 5, frame.size.width - accountText.frame.size.width - accountText.frame.origin.x - 30, 30)];
    accountPrice.text = @"￥97.70";
    accountPrice.font=[UIFont systemFontOfSize:18];
    accountPrice.backgroundColor = [UIColor clearColor];
    accountPrice.textColor = [UIColor redColor];
    accountPrice.textAlignment = NSTextAlignmentCenter;
    self.accountPrice =accountPrice;
    [self addSubview:accountPrice];
    
    UIImageView *line2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, accountText.frame.size.height + accountText.frame.origin.y + 10, frame.size.width - 20, 1)];
    line2.image = [UIImage imageNamed:@"line-1"];
    [self addSubview:line2];
    
    UILabel *labelYH = [[UILabel alloc]initWithFrame:CGRectMake(20, line2.frame.size.height + line2.frame.origin.y + 10, 60, 20)];
    labelYH.text = @"本店优惠：";
    labelYH.font = [UIFont systemFontOfSize:12];
    labelYH.backgroundColor = [UIColor clearColor];
    labelYH.textColor = [UIColor grayColor];
    labelYH.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labelYH];
    
    UILabel *labelYHDetail = [[UILabel alloc]initWithFrame:CGRectMake(labelYH.frame.size.width + labelYH.frame.origin.x + 5,line2.frame.size.height + line2.frame.origin.y + 10, frame.size.width - labelYH.frame.size.width - labelYH.frame.origin.x - 30, 20)];
    labelYHDetail.text = @"暂无可用优惠券";
    labelYHDetail.font = [UIFont systemFontOfSize:12];
    labelYHDetail.backgroundColor = [UIColor clearColor];
    labelYHDetail.textColor = [UIColor redColor];
    labelYHDetail.textAlignment = NSTextAlignmentCenter;
    self.labelYHDetail = labelYHDetail;
    [self addSubview:labelYHDetail];
    
    WuLog(@"--------------%f",labelYHDetail.frame.size.height + labelYHDetail.frame.origin.y);
    
//    UIImageView *line2=[[UIImageView alloc]initWithFrame:CGRectMake(10, labelYHDetail.frame.size.height + labelYHDetail.frame.origin.y + 10, frame.size.width - 20, 1)];
//    line2.image=[UIImage imageNamed:@"line-1"];
//    [self addSubview:line2];
//    
//    UILabel *labelLY = [[UILabel alloc]initWithFrame:CGRectMake(20, line2.frame.size.height + line2.frame.origin.y + 10, frame.size.width - 40, 20)];
//    labelLY.text=@"给卖家留言：";
//    labelLY.font=[UIFont boldSystemFontOfSize:12];
//    labelLY.backgroundColor=[UIColor clearColor];
//    labelLY.textColor = [UIColor grayColor];
//    labelLY.textAlignment=NSTextAlignmentLeft;
//    [self addSubview:labelLY];
//    
//    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10,labelLY.frame.size.height+labelLY.frame.origin.y+5, frame.size.width - 20,100)];
//    textView.backgroundColor=[UIColor clearColor];
//    textView.alpha=1.0;
//    textView.layer.borderColor= [[UIColor redColor] CGColor];
//    textView.layer.borderWidth = 1;
//    textView.layer.cornerRadius = 4;
//    textView.font = [UIFont systemFontOfSize:12];
//    textView.textColor = [UIColor grayColor];
//    textView.showsVerticalScrollIndicator = YES;
////    textView.showsHorizontalScrollIndicator = YES;
//    textView.scrollEnabled = YES;
//    textView.bouncesZoom = YES;
//    textView.canCancelContentTouches = YES;
//    textView.clearsContextBeforeDrawing = YES;
//    textView.userInteractionEnabled = YES;
//    textView.returnKeyType = UIReturnKeyDone;
//    self.textView = textView;
//    textView.delegate = self;
//    [self addSubview:textView];
//    
//    UILabel *labelTS = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 90, textView.frame.size.height + textView.frame.origin.y + 5, 80,20)];
//    labelTS.text=@"最多300个文字";
//    labelTS.font=[UIFont boldSystemFontOfSize:10];
//    labelTS.backgroundColor=[UIColor clearColor];
//    labelTS.textColor = [UIColor grayColor];
//    labelTS.textAlignment = NSTextAlignmentLeft;
//    [self addSubview:labelTS];
}

- (void)setFootitems:(ZWFootViewModel *)footitems
{
    _footitems = footitems;
    self.accountPrice.text = [NSString stringWithFormat:@"¥:%0.2f",[footitems.totalPrice doubleValue]];
    self.labelYFDetail.text = [NSString stringWithFormat:@"%@\t邮费：¥:%0.2f",footitems.sendTtyle, [footitems.postage doubleValue]];
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        [self.textView resignFirstResponder];
//        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//    }
//    
//    return YES;
//}
//
//-(void)textViewDidBeginEditing:(UITextView *)textView
//{
////    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIKeyboardWillShow" object:nil];
//}

//-(void)textViewDidEndEditing:(UITextView *)textView
//{
//    
//}

@end
