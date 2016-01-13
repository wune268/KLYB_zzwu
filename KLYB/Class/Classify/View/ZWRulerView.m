//
//  ZWRulerView.m
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWRulerView.h"

@interface ZWRulerView ()<UITextFieldDelegate>

@property(nonatomic,weak)UIButton *btnNine;
@property(nonatomic,weak)UIButton *btnNine1;
@property(nonatomic,assign)BOOL isTouch;
@property(nonatomic,assign)NSInteger touchID;
@property(nonatomic,assign)NSInteger touchID1;

@end

@implementation ZWRulerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isTouch=NO;
        self.touchID1=0;
        self.touchID=0;
        UIView *backgroudView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
        backgroudView.layer.borderWidth=1;
        backgroudView.layer.cornerRadius = 0;
        backgroudView.layer.borderColor=[UIColor colorWithRed:.98 green:.98 blue:.98 alpha:1.0].CGColor;
        backgroudView.backgroundColor=[UIColor whiteColor];
        [self addSubview:backgroudView];
        
        UILabel *c_label=[[UILabel alloc]initWithFrame:CGRectMake(65, 30/2-20/2, self.frame.size.width - 130, 20)];
        c_label.text=@"选择颜色,尺寸";
        c_label.font=[UIFont boldSystemFontOfSize:16];
        c_label.backgroundColor=[UIColor clearColor];
        c_label.textColor =[UIColor redColor];
        c_label.textAlignment=1;
        c_label.numberOfLines=0;
        [backgroudView addSubview:c_label];
        
        UIImageView *imageLine=[[UIImageView alloc]initWithFrame:CGRectMake(10, 31, self.frame.size.width - 20, 1)];
        imageLine.image=[UIImage imageNamed:@"default_02"];
        [backgroudView addSubview:imageLine];
        
        UIImageView *imageHead=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 71, 72)];
        imageHead.image=[UIImage imageNamed:@"default_02"];
        //        imageHead.layer.borderWidth=1;
        //        imageHead.layer.cornerRadius = 0;
        //        imageHead.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        imageHead.backgroundColor=[UIColor whiteColor];
        [backgroudView addSubview:imageHead];
        
        
        UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(imageHead.frame.size.width+imageHead.frame.origin.x + 10, imageHead.frame.origin.y, self.frame.size.width - 20 - 75 - 10, 40)];
        title_label.text=@"韩版白色蝴蝶结腰带超甜美小香风蕾丝乡花连衣裙";
        title_label.font=[UIFont systemFontOfSize:14];
        title_label.backgroundColor=[UIColor clearColor];
        title_label.textColor = [UIColor blackColor];
        title_label.textAlignment=0;
        title_label.numberOfLines=2;
        [backgroudView addSubview:title_label];
        
        UILabel *p_label=[[UILabel alloc]initWithFrame:CGRectMake(title_label.frame.origin.x, title_label.frame.origin.y+title_label.frame.size.height, 100, 20)];
        p_label.text=@"￥120.78";
        p_label.font=[UIFont systemFontOfSize:14];
        p_label.backgroundColor=[UIColor clearColor];
        p_label.textColor = [UIColor redColor];
        p_label.textAlignment=0;
        p_label.numberOfLines=2;
        [backgroudView addSubview:p_label];
        
        UILabel *k_label=[[UILabel alloc]initWithFrame:CGRectMake(p_label.frame.origin.x+p_label.frame.size.width, p_label.frame.origin.y, 100, 20)];
        k_label.text=@"(库存234件)";
        k_label.font=[UIFont systemFontOfSize:14];
        k_label.backgroundColor=[UIColor clearColor];
        k_label.textColor = [UIColor grayColor];
        k_label.textAlignment=0;
        k_label.numberOfLines=2;
        [backgroudView addSubview:k_label];
        
        UILabel *ys_label=[[UILabel alloc]initWithFrame:CGRectMake(10, backgroudView.frame.size.height+backgroudView.frame.origin.y, 40, 20)];
        ys_label.text=@"颜色";
        ys_label.font=[UIFont systemFontOfSize:14];
        ys_label.textColor =[UIColor blackColor];
        ys_label.backgroundColor=[UIColor clearColor];
        ys_label.textAlignment=0;
        
        [self addSubview:ys_label];
        
        
        for (int i=0; i<9; i++)
        {
            UIButton *btnNine=[[UIButton alloc]initWithFrame:CGRectMake((i%5)*(self.frame.size.width-15)/5+10, floor(i/5)*(self.frame.size.width)/10+5+ys_label.frame.size.height+ys_label.frame.origin.y, (self.frame.size.width-30-15)/5, (self.frame.size.width-30-15)/10)];
            btnNine.backgroundColor=[UIColor whiteColor];
            btnNine.layer.borderWidth=1;
            btnNine.layer.cornerRadius = 4;
            btnNine.titleLabel.font=[UIFont systemFontOfSize:14];
            btnNine.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
            btnNine.tag=i+1000;
            [btnNine setTitle:@"白色" forState:0];
            [btnNine setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
            [btnNine addTarget:self action:@selector(btnNine:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnNine];
            self.btnNine = btnNine;
            
        }
        UIImageView *imageLine1=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.btnNine.frame.size.height+self.btnNine.frame.origin.y+5, 320, 1)];
        imageLine1.image= [UIImage imageNamed:@"default_02"];
        [self addSubview:imageLine1];
        
        UILabel *cm_label=[[UILabel alloc]initWithFrame:CGRectMake(10, imageLine1.frame.size.height+imageLine1.frame.origin.y+5, 40, 20)];
        cm_label.text=@"尺码";
        cm_label.font=[UIFont systemFontOfSize:14];
        cm_label.textColor = [UIColor grayColor];
        cm_label.backgroundColor=[UIColor clearColor];
        cm_label.textAlignment=0;
        
        [self addSubview:cm_label];
        
        
        for (int i=0; i<8; i++)
        {
            UIButton *btnNine1=[[UIButton alloc]initWithFrame:CGRectMake((i%5)*(self.frame.size.width-15)/5+10, floor(i/5)*(self.frame.size.width)/10+5+cm_label.frame.size.height+cm_label.frame.origin.y, (self.frame.size.width-30-15)/5, (self.frame.size.width-30-15)/10)];
            btnNine1.backgroundColor=[UIColor whiteColor];
            btnNine1.layer.borderWidth=1;
            btnNine1.layer.cornerRadius = 4;
            btnNine1.titleLabel.font=[UIFont systemFontOfSize:14];
            btnNine1.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
            btnNine1.tag=i+10000;
            [btnNine1 setTitle:@"S" forState:0];
            [btnNine1 setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
            [btnNine1 addTarget:self action:@selector(btnNine1:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btnNine1];
            self.btnNine1 = btnNine1;
            
        }
        UIImageView *imageLine2=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.btnNine1.frame.size.height+self.btnNine1.frame.origin.y+5, 320, 1)];
        imageLine2.image= [UIImage imageNamed:@"default_02"];
        [self addSubview:imageLine2];
        
        UILabel *sl_label=[[UILabel alloc]initWithFrame:CGRectMake(10, imageLine2.frame.size.height+imageLine2.frame.origin.y, 40, 20)];
        sl_label.text=@"数量";
        sl_label.font=[UIFont systemFontOfSize:14];
        sl_label.textColor = [UIColor grayColor];
        sl_label.backgroundColor=[UIColor clearColor];
        sl_label.textAlignment=0;
        
        [self addSubview:sl_label];
        //按钮
        //减
        UIButton *btnCut=[UIButton buttonWithType:0];
        btnCut.frame=CGRectMake(10, sl_label.frame.size.height+sl_label.frame.origin.y, 35, 35);
        btnCut.tag=-99;
        [btnCut setImage: [UIImage imageNamed:@"default_02"] forState:0];
        [btnCut addTarget:self action:@selector(btnCut:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btnCut];
        
        UITextField*  numTextField=[[UITextField alloc]initWithFrame:CGRectMake(btnCut.frame.size.width+btnCut.frame.origin.x+1, btnCut.frame.origin.y+3,59,28)];
        numTextField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        numTextField.textAlignment=1;
        numTextField.delegate=self;
        numTextField.returnKeyType=UIReturnKeyDone;
        numTextField.text=@"1";
        numTextField.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        numTextField.tag=-100;
        numTextField.keyboardType=UIKeyboardTypeDefault;
        numTextField.userInteractionEnabled=YES;
        //        numTextField.background=BundleImage(@"number_frame.png");
        numTextField.layer.borderColor=[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0].CGColor;
        numTextField.layer.borderWidth=1;
        numTextField.backgroundColor=[UIColor whiteColor];
        [numTextField addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [numTextField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [self addSubview:numTextField];
        
        //加
        UIButton *btnAdd=[UIButton buttonWithType:0];
        btnAdd.frame=CGRectMake(numTextField.frame.origin.x+numTextField.frame.size.width+3,btnCut.frame.origin.y+3, 30, 28);
        [btnAdd setBackgroundImage:[UIImage imageNamed:@"default_02"] forState:0];
        [btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
        if (btnAdd.highlighted) {
            [btnAdd setBackgroundImage:[UIImage imageNamed:@"default_02"] forState:0];
        }
        btnAdd.tag=-101;
        [self addSubview:btnAdd];
        
        UIView *view_bar =[[UIView alloc]initWithFrame:CGRectMake(0, 396, self.frame.size.width, 44)];
        view_bar.backgroundColor=[UIColor whiteColor];
        view_bar.layer.borderColor=[UIColor colorWithRed:.9 green:.9  blue:.9  alpha:1.0].CGColor;
        view_bar.layer.borderWidth=1;
        [self addSubview:view_bar];
        
        
        UIButton*btnAddShopCar=[UIButton buttonWithType:0];
        btnAddShopCar.frame=CGRectMake(20, 0, 80, 44);
        btnAddShopCar.backgroundColor=[UIColor clearColor];
        [btnAddShopCar addTarget:self action:@selector(addShopCar:) forControlEvents:UIControlEventTouchUpInside];
        [btnAddShopCar setImage:[UIImage imageNamed:@"default_02"] forState:0];
        [view_bar addSubview:btnAddShopCar];
        
        UIButton*btnShop=[UIButton buttonWithType:0];
        btnShop.frame=CGRectMake(20+80+20+80, 44/2-28/2, 100, 28);
        btnShop.backgroundColor=[UIColor clearColor];
        [btnShop addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];
        [btnShop setImage:[UIImage imageNamed:@"default_02"] forState:0];
        [view_bar addSubview:btnShop];       
        
    }
    return self;
}

//立即购买
-(void)shopping:(id)sender
{
    [self.superview removeFromSuperview];
}

//添加购物车
-(void)addShopCar:(id)sender
{
    WuLog(@"商品成功添加购物车");
//    UIAlertController *addFriendController = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"添加成功！现在前往购物车？" preferredStyle:UIAlertControllerStyleAlert];
//    
//    [addFriendController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [addFriendController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [self.navigationController presentViewController:addFriendController animated:YES completion:^{
//        
//    }];
}


#pragma mark keyboard methods

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.frame;
//    frame.origin.y =148;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.frame = frame;
    [UIView commitAnimations];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *field;
    [self keyboardWillHide:nil];
    
    //    for (int i=0; i<[_marrayAll count]; i++)
    //    {
    field=(UITextField*)[self viewWithTag:100000];
//    UILabel*label=(UILabel*)[self viewWithTag:10000000];
    
    if (textField.tag==field.tag)
    {
        //            //            [self keyboardWillShow:nil];
        
        //            label.text= [NSString stringWithFormat:@"%.2f", [[_arrayPrice objectAtIndex:i]  floatValue]*[field.text floatValue]];
    }else if(textField.tag >= 100003)
    {
        [self keyboardWillShow:nil];
        
    }
    
    //    }
    
    
}

//利用正则表达式验证
-(BOOL)isValidateNumber:(NSString *)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

- (void) textFieldBegin:(id)sender
{
    UITextField *t = (UITextField*)sender;
    WuLog(@"%li",(long)t.tag);
    
}


- (void) textFieldDone:(id)sender
{
    [self keyboardWillHide:Nil];
    [sender resignFirstResponder];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self isValidateNumber:string];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITextField*field;
    [self keyboardWillShow:nil];
    //    for (int i=0; i<[_marrayAll count]; i++)
    //    {
    field=(UITextField*)[self viewWithTag:100000];
//    UILabel*label=(UILabel*)[self viewWithTag:10000000];
    
    if (textField.tag==field.tag)
    {
        
    }
    else if(textField.tag >= 100001)
    {
        [self keyboardWillShow:nil];
        
    }
}

-(void)btnNine:(id)sender
{
    
    UIButton *button=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self viewWithTag:self.touchID];
    btn1.backgroundColor=[UIColor whiteColor];
    
    if (self.touchID>0) {
        
        [btn1 setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
    }
    [button setTitleColor:[UIColor whiteColor] forState:0];
    
    if (button.tag==self.touchID) {
        UIButton *btn=(UIButton*)[self viewWithTag:self.touchID];
        btn.backgroundColor=[UIColor clearColor];
        
    }else{
        
        button.backgroundColor=[UIColor redColor];
        self.touchID = button.tag;
    }
}
-(void)btnNine1:(id)sender
{
    UIButton *button=(UIButton*)sender;
    UIButton *btn1=(UIButton*)[self viewWithTag:self.touchID1];
    btn1.backgroundColor=[UIColor whiteColor];
    
    if (self.touchID1 > 0) {
        
        [btn1 setTitleColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0] forState:0];
    }
    [button setTitleColor:[UIColor whiteColor] forState:0];
    
    if (button.tag == self.touchID1) {
        
        UIButton *btn = [self viewWithTag:self.touchID1];
        btn.backgroundColor=[UIColor clearColor];
        
    }
    else
    {
        button.backgroundColor= [UIColor redColor];
        self.touchID1=button.tag;
    }
}

-(void)btnCut:(id)sender
{
    UITextField*field=(UITextField* )[self viewWithTag:-100 ];
    if ([field.text intValue] > 1)
    {
        field.text=[NSString stringWithFormat:@"%d",[field.text intValue]-1];
    }
}

//加
-(void)btnAdd:(id)sender
{
    UITextField*field=(UITextField* )[self viewWithTag:-100];
    field.text=[NSString stringWithFormat:@"%d",[field.text intValue] + 1];
}

@end
