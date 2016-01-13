//
//  ZWFindPasswordViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWFindPasswordViewController.h"
#import "ZWAnimationView.h"

@interface ZWFindPasswordViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *userName;
@property(nonatomic,strong)UITextField *codeName;
@property(nonatomic,strong)UITextField *ID_Name;
@property(nonatomic,weak)UIView *findPasswordView;
@property(nonatomic,weak)UIButton *getCodeName;

@end

@implementation ZWFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wu_creatView];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)wu_creatView
{
    CGFloat findPasswordViewX = 0;
    CGFloat findPasswordViewY = 214;
    CGFloat findPasswordViewW = Screen_Width;
    CGFloat findPasswordViewH = Screen_Height - findPasswordViewY - 64;
    
    UIView *findPasswordView = [[UIView alloc] initWithFrame:CGRectMake(findPasswordViewX, findPasswordViewY, findPasswordViewW, findPasswordViewH)];
    findPasswordView.backgroundColor = [UIColor clearColor];
    self.findPasswordView = findPasswordView;
    [self.view addSubview:self.findPasswordView];
    
    UITextField *userName = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, findPasswordViewW - 60, 40)];
    userName.placeholder = @"请输入帐号";
    userName.returnKeyType = UIReturnKeyNext;
    userName.keyboardType = UIKeyboardTypeNumberPad;
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.enablesReturnKeyAutomatically = YES;
    userName.clearButtonMode = UITextFieldViewModeAlways;
    userName.delegate = self;
    self.userName = userName;
    [findPasswordView addSubview:userName];
    
    CGFloat pading = userName.frame.size.width - 80;
    
    UITextField *codeName = [[UITextField alloc] initWithFrame:CGRectMake(30, 50, pading, 40)];
    codeName.placeholder = @"请输入验证码";
    codeName.keyboardType = UIKeyboardTypeNumberPad;
    codeName.returnKeyType = UIReturnKeyNext;
    codeName.borderStyle = UITextBorderStyleRoundedRect;
    codeName.enablesReturnKeyAutomatically = YES;
    codeName.clearButtonMode = UITextFieldViewModeAlways;
    codeName.delegate = self;
    self.codeName = codeName;
    [findPasswordView addSubview:codeName];
    
    UIButton *getCodeName = [[UIButton alloc] initWithFrame:CGRectMake(pading + 40, 50, 70, 40)];
    [getCodeName setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeName.titleLabel.font = [UIFont systemFontOfSize:13];
    [getCodeName addTarget:self action:@selector(wu_getCodeNameClick:) forControlEvents:UIControlEventTouchUpInside];
    [getCodeName.layer setCornerRadius:5];
    getCodeName.backgroundColor = [UIColor grayColor];
    self.getCodeName = getCodeName;
    [findPasswordView addSubview:getCodeName];
    
    UITextField *ID_Name = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, findPasswordViewW - 60, 40)];
    ID_Name.placeholder = @"请输入身份证号码";
    ID_Name.delegate = self;
    ID_Name.secureTextEntry = YES;
    ID_Name.borderStyle = UITextBorderStyleRoundedRect;
    ID_Name.returnKeyType = UIReturnKeyNext;
    ID_Name.enablesReturnKeyAutomatically = YES;
    self.ID_Name = ID_Name;
    [findPasswordView addSubview:ID_Name];
    
    UIButton *findButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 150, findPasswordViewW - 60, 35)];
    [findButton setTitle:@"找回" forState:UIControlStateNormal];
    [findButton setTitle:@"找回" forState:UIControlStateHighlighted];
    [findButton addTarget:self action:@selector(wu_findButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [findButton.layer setCornerRadius:5];
    findButton.backgroundColor = [UIColor grayColor];
    [findPasswordView addSubview:findButton];
    
    UIButton *backToLogin = [[UIButton alloc] initWithFrame:CGRectMake(30, Screen_Height - 64, 70, 30)];
    [backToLogin setTitle:@"返回登录" forState:UIControlStateNormal];
    [backToLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backToLogin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    backToLogin.titleLabel.font = [UIFont systemFontOfSize:11];
    [backToLogin addTarget:self action:@selector(wu_backToLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [backToLogin.layer setCornerRadius:5];
    
    [self.view addSubview:backToLogin];
}

- (void)wu_getCodeNameClick:(UIButton *)button
{
    WuLog(@"getCodeNameClick");
    [ZWAnimationView wu_shakeAnimationForView:self.findPasswordView];
}

- (void)wu_findButtonClick:(UIButton *)button
{
    WuLog(@"findButtonClick");
}

- (void)wu_backToLoginClick:(UIButton *)button
{
    WuLog(@"backToLoginClick");
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self wu_resignOneResponder];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self wu_resignOneResponder];
}

-(void)wu_resignOneResponder
{
    [self.userName resignFirstResponder];
    [self.ID_Name resignFirstResponder];
    [self.codeName resignFirstResponder];
}

//倒数
- (void)wu_reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0)
    {
        [self.getCodeName setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCodeName.enabled = YES;
    }
    else
    {
        int i = [second intValue];
        NSString *text=[NSString stringWithFormat:@"%2i秒后重发",i];
        [self.getCodeName setTitle:text forState:UIControlStateNormal];
        [self performSelector:@selector(wu_reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i - 1] afterDelay:1];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    WuLog(@"textFieldDidEndEditing");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
