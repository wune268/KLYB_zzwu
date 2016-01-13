//
//  ZWUserLoginViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWUserLoginViewController.h"
#import "ZWPassWordField.h"
#import "ZWClipCircleView.h"
#import "ZWAnimationView.h"
//#import "NSString+Hash.h"
#import "ZWCreatUserViewController.h"
#import "ZWNavigationController.h"
#import "ZWFindPasswordViewController.h"
#import "ZWUserLoginHttpTool.h"
#import "ZWUserLoginKeyItems.h"
#import "ZWUserAccount.h"
#import "ZWAccountTool.h"

// 加密
//#import "DataSigner.h"
//#import "ZWEncryptRSA.h"
//#import "RSAEncryption.h"
//#import "ZWRSA.h"
//#import "SecKeyWrapper.h"
//#import "Base64Data.h"
#import "CommonFunc.h"

@interface ZWUserLoginViewController ()<UITextFieldDelegate>

@property(nonatomic,weak)UITextField *userName;
@property(nonatomic,weak)ZWPassWordField *passWord;
@property(nonatomic,weak)UIView *loginView;
@property(nonatomic,strong)ZWUserLoginKeyItems *keyItems;

@end

@implementation ZWUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"欢迎登录快乐翼佰";
    [self wu_creatView];
    
    [ZWUserLoginHttpTool wu_getKeyWithparams:nil success:^(ZWUserLoginKeyItems *keyItems) {
        self.keyItems = keyItems;
        WuLog(@"%@----keyItems",keyItems);
    } failure:^(NSError *error) {
        WuLog(@"%@",error);
    }];
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
    CGFloat loginViewX = 0;
    CGFloat loginViewY = 265;
    CGFloat loginViewW = Screen_Width;
    CGFloat loginViewH = Screen_Height - loginViewY - 64;
    
    ZWClipCircleView *iconView = [[ZWClipCircleView alloc] initWithFrame:CGRectMake((Screen_Width - 150) * 0.5, 90, 150, 150)];
    iconView.borderColor = [UIColor blackColor];
    iconView.borderWidth = 5;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:iconView.bounds];
    imageView.image = [UIImage imageNamed:@"qqstar4"];
    [iconView addSubview:imageView];
    [self.view addSubview:iconView];
    
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(loginViewX, loginViewY, loginViewW, loginViewH)];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    
    UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, loginViewW - 60, 40)];
    userName.placeholder = @"请输入账号登陆";
    userName.returnKeyType = UIReturnKeyNext;
    userName.keyboardType = UIKeyboardTypeNumberPad;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.enablesReturnKeyAutomatically = YES;
    userName.clearButtonMode = UITextFieldViewModeAlways;
    userName.delegate = self;
    self.userName = userName;
    
    ZWPassWordField *passWord = [[ZWPassWordField alloc] initWithFrame:CGRectMake(30, 50, loginViewW - 60, 40) placeholder:@"请输入密码"];
    passWord.delegate = self;
    self.passWord = passWord;
    
    UIButton *userLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, loginViewW - 60, 40)];
    [userLogin setTitle:@"登陆" forState:UIControlStateNormal];
    [userLogin addTarget:self action:@selector(wu_userLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [userLogin.layer setCornerRadius:5];
    userLogin.backgroundColor = [UIColor grayColor];
    
    UIButton *userNoPassword = [[UIButton alloc] initWithFrame:CGRectMake(30, Screen_Height - 64, 70, 30)];
    [userNoPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [userNoPassword setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [userNoPassword setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    userNoPassword.titleLabel.font = [UIFont systemFontOfSize:11];
    [userNoPassword addTarget:self action:@selector(wu_userNoPasswordClick:) forControlEvents:UIControlEventTouchUpInside];
    [userNoPassword.layer setCornerRadius:5];
    
    UIButton *creatUser = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 100, Screen_Height - 64, 70, 30)];
    [creatUser setTitle:@"新用户" forState:UIControlStateNormal];
    [creatUser setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [creatUser setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    creatUser.titleLabel.font = [UIFont systemFontOfSize:11];
    [creatUser addTarget:self action:@selector(wu_creatUserClick:) forControlEvents:UIControlEventTouchUpInside];
    [creatUser.layer setCornerRadius:5];
    
    [loginView addSubview:userLogin];
    [loginView addSubview:userName];
    [loginView addSubview:passWord];
    [self.view addSubview:creatUser];
    [self.view addSubview:userNoPassword];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    return YES;
}

-(void)wu_userLoginClick:(UIButton *)button
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    if (!self.keyItems) {
        [ZWAnimationView wu_shakeAnimationForView:self.loginView];
        
        [MBProgressHUD showError:@"网络出错，请重启应用程序！"];
        return;
    }
    if (self.userName.text.length == 0 || self.passWord.text.length == 0)
    {
        [ZWAnimationView wu_shakeAnimationForView:self.loginView];
        
        [MBProgressHUD showError:@"账号或密码为空！"];
    }
    else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccuss" object:nil userInfo:nil];
        }];
        NSString *username = self.userName.text;
        WuLog(@"%@",self.keyItems.keyModulus);
//        id<DataSigner> signer = CreateRSADataSigner([NSString stringWithFormat:@"%@",self.keyItems.keyModulus]);
//        NSString *password = [signer signString:[NSString stringWithFormat:@"%@",self.passWord.text]];
//        NSString *password = [RSAEncryption encryptString:[NSString stringWithFormat:@"%@",self.passWord.text] publicKey:[NSString stringWithFormat:@"%@",self.keyItems.keyModulus]];
//        NSString *pubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEChqe80lJLTTkJD3X3Lyd7Fj+zuOhDZkjuLNPog3YR20e5JcrdqI9IFzNbACY/GQVhbnbvBqYgyql8DfPCGXpn0+XNSxELIUw9Vh32QuhGNr3/TBpechrVeVpFPLwyaYNEk1CawgHCeQqf5uaqiaoBDOTqeox88Lc1ld7MsfggQIDAQAB";
//        NSString *pubkey = @"t/vmUiPKYnGI84GCwo2dUiFSlK+j0L5Dpo2uColFpraxUyT+3mdpt/JWRzNVzRfYAhtJNsuo3+W5ZaNrLf+nkWVa6TMUA5QsQzYDQbgjmfLEy+yIq8YOS0O3JdE+jeZwdM8+B+cRujVMAe0sWHkvCqqi3ZnMLVbzc/98Vr22lCB4Xs3MCtthq82YCfifZY+uABcb3pwr2d/nbmHeXT2Y/jjGPsIB+9yfcxISjIr66OL4lX3C6Rfqp+n709kWDNNEHl0jGV31QBSv8ezIo3pKLUZdpZMYRc1ZjPWcp/JK3DEejOqVwGRJR7u1twrFJu2V1Szw9PC3tGVyC54aUEvz3Q==";
//        NSString *
        
//        NSData *publicKey = [NSData dataFromBase64String:[NSString stringWithFormat:@"%@",self.keyItems.keyModulus]];
//        NSData *usernamm = [[NSString stringWithFormat:@"%@",self.passWord.text] dataUsingEncoding: NSUTF8StringEncoding];
//        NSData *newKey= [SecKeyWrapper encrypt:usernamm publicKey:publicKey];
//        NSString *password = [newKey base64EncodedString];
        NSString *password = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@%@",self.keyItems.keyExponent,self.passWord.text]];
//        NSString *password = [STRSA encryptString:[NSString stringWithFormat:@"%@",self.passWord.text] publicKey:self.keyItems.keyModulus];
        WuLog(@"%@__password",password);
        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"account", password, @"password", nil];
        [ZWUserLoginHttpTool wu_postLoginWithparams:param success:^(id json) {
            WuLog(@"登录成功－－——%@",json);
            ZWUserAccount *account = [[ZWUserAccount alloc] init];
            account.userName = username;
            account.password = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@", self.passWord.text]];
            [ZWAccountTool saveAccount:account];
        } failure:^(NSError *error) {
            WuLog(@"登录失败");
        }];
    }
}

//- (NSString *)encryptWithSontent:(NSString *)content
//{
//    NSData *publicKey = [NSData dataFromBase64String:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCtkjDEKiKBvg7ps9Cvv1mt2gfnm"];
//    NSData *usernamm = [content dataUsingEncoding: NSUTF8StringEncoding];
//    NSData *newKey= [SecKeyWrapper encrypt:usernamm publicKey:publicKey];
//    NSString *result = [newKey base64EncodedString];
//    return result;
//}

//-(void)wu_requestHttpWithString:(NSString *)postURL httpBody:(NSDictionary *)dictBody contentType:(NSString *)Type key:(NSString *)key
//{
//    
//}
//
//-(void)wu_GetUserText:(NSString *)token
//{
//    
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}

- (void)wu_userNoPasswordClick:(UIButton *)button
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    ZWFindPasswordViewController *findPasswordViewController = [[ZWFindPasswordViewController alloc] init];
    findPasswordViewController.title = @"找回密码";
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:findPasswordViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

-(void)wu_creatUserClick:(UIButton *)button
{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
    ZWCreatUserViewController *creatUserViewController = [[ZWCreatUserViewController alloc] init];
    creatUserViewController.title = @"注册新用户";
    ZWNavigationController *nav = [[ZWNavigationController alloc] initWithRootViewController:creatUserViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
