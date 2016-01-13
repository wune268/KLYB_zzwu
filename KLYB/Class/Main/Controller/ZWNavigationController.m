//
//  ZWNavigationController.m
//  KLYB
//
//  Created by ZZWU on 15/12/18.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWNavigationController.h"

@interface ZWNavigationController ()

@end

@implementation ZWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationBar.barTintColor = [UIColor colorWithRed:242/255.0 green:141/255.0 blue:57/255.0 alpha:1.0];
    [self.navigationBar setTintColor:[UIColor colorWithRed:242/255.0 green:141/255.0 blue:57/255.0 alpha:1.0]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
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
