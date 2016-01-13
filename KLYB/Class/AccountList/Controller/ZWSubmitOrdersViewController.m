//
//  ZWSubmitOrdersViewController.m
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWSubmitOrdersViewController.h"

@interface ZWSubmitOrdersViewController ()

@end

@implementation ZWSubmitOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *success = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    success.text = @"支付成功";
    success.textAlignment = NSTextAlignmentCenter;
    success.center = self.view.center;
    [self.view addSubview:success];
    
    UIButton *succeButton = [[UIButton alloc] initWithFrame:CGRectMake(success.frame.origin.x, success.frame.size.height + success.frame.origin.y + 20, 150, 40)];
    [succeButton setTitle:@"返回首页" forState:UIControlStateNormal];
    [succeButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [succeButton setBackgroundColor:[UIColor redColor]];
    [succeButton addTarget:self action:@selector(wu_succeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:succeButton];
}

- (void)dealloc
{
    WuLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wu_succeButtonClick:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
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
