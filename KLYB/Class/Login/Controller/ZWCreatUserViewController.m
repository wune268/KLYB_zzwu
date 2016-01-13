//
//  ZWCreatUserViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWCreatUserViewController.h"
#import "ZWPassWordField.h"
#import "ZWClipCircleView.h"
#import "ZWAnimationView.h"
#import "NSString+Hash.h"

#define SEC 60

@interface ZWCreatUserViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *codeName;
@property(nonatomic,strong)ZWPassWordField *passWord1;
@property(nonatomic,strong)ZWPassWordField *passWord2;
@property(nonatomic,weak)UIView *creatLoginView;
@property(nonatomic,strong)UIButton *codeBtn;
@property(nonatomic,assign)int randomNum;
@property(nonatomic,weak)UIImageView *icon;

@end

@implementation ZWCreatUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self wu_creatView];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)wu_creatView
{
    CGFloat creatLoginViewX = 0;
    CGFloat creatLoginViewY = 214;
    CGFloat creatLoginViewW = Screen_Width;
    CGFloat creatLoginViewH = Screen_Height - creatLoginViewY - 64;
    
    ZWClipCircleView *iconView = [[ZWClipCircleView alloc] initWithFrame:CGRectMake((Screen_Width - 130) * 0.5, 74, 130, 130)];
    iconView.borderColor = [UIColor blackColor];
    iconView.borderWidth = 5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:iconView.bounds];
    //    iconView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"qqstar4"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wu_selectIcon:)];
    self.icon = imageView;
    [iconView addGestureRecognizer:tap];
    [iconView addSubview:imageView];
    [self.view addSubview:iconView];
    
    UIView *creatLoginView = [[UIView alloc] initWithFrame:CGRectMake(creatLoginViewX, creatLoginViewY, creatLoginViewW, creatLoginViewH)];
    creatLoginView.backgroundColor = [UIColor clearColor];
    self.creatLoginView = creatLoginView;
    [self.view addSubview:self.creatLoginView];
    UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, creatLoginViewW - 60, 40)];
    userName.placeholder = @"请输入帐号注册";
    userName.returnKeyType = UIReturnKeyNext;
    userName.keyboardType = UIKeyboardTypeNumberPad;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.enablesReturnKeyAutomatically = YES;
    userName.clearButtonMode = UITextFieldViewModeAlways;
    userName.delegate = self;
    self.userName = userName;
    
    CGFloat pading = userName.frame.size.width - 80;
    
    UITextField *codeName = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, pading, 40)];
    codeName.placeholder = @"请输入验证码";
    codeName.keyboardType = UIKeyboardTypeNumberPad;
    codeName.returnKeyType = UIReturnKeyNext;
    codeName.borderStyle = UITextBorderStyleRoundedRect;
    codeName.enablesReturnKeyAutomatically = YES;
    codeName.clearButtonMode = UITextFieldViewModeAlways;
    codeName.tag = 888;
    codeName.delegate = self;
    self.codeName = codeName;
    
    UIButton *getCodeName = [[UIButton alloc] initWithFrame:CGRectMake(pading + 40, 50, 70, 40)];
    [getCodeName setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeName.titleLabel.font = [UIFont systemFontOfSize:13];
    [getCodeName addTarget:self action:@selector(wu_getCodeNameClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCodeName.layer setCornerRadius:5];
    getCodeName.backgroundColor = [UIColor grayColor];
    self.codeBtn = getCodeName;
    
    ZWPassWordField *passWord1 = [[ZWPassWordField alloc] initWithFrame:CGRectMake(30, 100, creatLoginViewW - 60, 40) placeholder:@"请输入密码"];
    passWord1.delegate = self;
    self.passWord1 = passWord1;
    
    ZWPassWordField *passWord2 = [[ZWPassWordField alloc] initWithFrame:CGRectMake(30, 150, creatLoginViewW - 60, 40) placeholder:@"请再次确认密码" ];
    passWord2.delegate = self;
    self.passWord2 = passWord2;
    
    UIButton *userCreat = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, creatLoginViewW - 60, 35)];
    [userCreat setTitle:@"注册" forState:UIControlStateNormal];
    [userCreat setTitle:@"注册" forState:UIControlStateHighlighted];
    [userCreat addTarget:self action:@selector(wu_creatUserClick:) forControlEvents:UIControlEventTouchUpInside];
    [userCreat.layer setCornerRadius:5];
    userCreat.backgroundColor = [UIColor grayColor];
    
    UIButton *userLogin = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 100, Screen_Height - 64, 70, 30)];
    [userLogin setTitle:@"返回登录" forState:UIControlStateNormal];
    [userLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [userLogin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    userLogin.titleLabel.font = [UIFont systemFontOfSize:11];
    [userLogin addTarget:self action:@selector(wu_userLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [userLogin.layer setCornerRadius:5];
    
    [self.creatLoginView addSubview:userCreat];
    [self.creatLoginView addSubview:userName];
    [self.creatLoginView addSubview:passWord1];
    [self.creatLoginView addSubview:passWord2];
    [self.creatLoginView addSubview:codeName];
    [self.creatLoginView addSubview:getCodeName];
    [self.view addSubview:userLogin];
}

-(void)wu_selectIcon:(UITapGestureRecognizer *)tap
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 分别3个创建操作
    UIAlertAction *camaraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 普通按键
        [self wu_actionDidDismissWithButtonIndex:0];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 红色按键
        [self wu_actionDidDismissWithButtonIndex:1];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // 取消按键
        [self wu_actionDidDismissWithButtonIndex:2];
    }];
    
    // 添加操作（顺序就是呈现的上下顺序）
    [alertController addAction:camaraAction];
    [alertController addAction:photoAction];
    [alertController addAction:cancelAction];
    
    // 呈现警告视图
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)wu_actionDidDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sType = UIImagePickerControllerSourceTypePhotoLibrary;
    switch (buttonIndex) {
        case 0:
//            相机
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                sType = UIImagePickerControllerSourceTypeCamera;
            }
            else
            {
                sType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        case 1:
//            相册
            sType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 2:
//            取消
            return;
            break;
    }
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.sourceType = sType;
    imagePick.delegate = self;
    [self presentViewController:imagePick animated:YES completion:nil];
}

#pragma 相机的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.icon.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self wu_resignOneResponder];
    return YES;
}

-(void)wu_getCodeNameClick:(UIButton *)button
{
    [self wu_resignOneResponder];
    self.randomNum = (arc4random() % 10000);
    if (self.userName.text.length == 0)
    {
        [ZWAnimationView wu_shakeAnimationForView:self.creatLoginView];
        [MBProgressHUD showError:@"请输入手机号码！"];
    }
    else if(self.userName.text.length == 11)
    {
//        获取倒计时
        [self performSelector:@selector(wu_reflashGetKeyBt:) withObject:[NSNumber numberWithInt:SEC] afterDelay:0];
        self.codeBtn.enabled = NO;
    }
}

-(void)wu_creatUserClick:(UIButton *)button
{
    [self wu_resignOneResponder];
    
    if (self.userName.text.length == 0 || self.passWord1.text.length == 0 || self.passWord2.text.length == 0 || self.codeName.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码或密码"];
        [ZWAnimationView wu_shakeAnimationForView:self.creatLoginView];
    }
    else if (self.passWord1.text.length == 0 || self.passWord2.text.length == 0)
    {
        [MBProgressHUD showError:@"用户名或密码为空"];
        [ZWAnimationView wu_shakeAnimationForView:self.creatLoginView];
    }
    else if (self.userName.text.length == 11)
    {
        if ([self.passWord1.text isEqualToString:self.passWord2.text])
        {
            
        }
        else
        {
            [MBProgressHUD showError:@"两次输入的密码不一致"];
            [ZWAnimationView wu_shakeAnimationForView:self.creatLoginView];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self wu_resignOneResponder];
}

-(void)wu_resignOneResponder
{
    [self.userName resignFirstResponder];
    [self.passWord1 resignFirstResponder];
    [self.passWord2 resignFirstResponder];
    [self.codeName resignFirstResponder];
}

//倒数
- (void)wu_reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0)
    {
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = YES;
    }
    else
    {
        int i = [second intValue];
        NSString *text=[NSString stringWithFormat:@"%2i秒后重发",i];
        [self.codeBtn setTitle:text forState:UIControlStateNormal];
        [self performSelector:@selector(wu_reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 888) {
        if (self.codeName.text.length) {
            
        }
    }
}

-(void)wu_requestHttpWithString:(NSString *)postURL httpBody:(NSDictionary *)dictBody contentType:(NSString *)Type key:(NSString *)key
{
    
}

-(void)wu_userLoginClick:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
