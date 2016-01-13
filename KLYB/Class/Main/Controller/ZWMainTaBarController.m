//
//  ZWMainTaBarController.m
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWMainTaBarController.h"
#import "ZWTaBarButton.h"
#import "ZWTaBar.h"
#import "ZWClassIfyingTableViewController.h"
#import "ZWBrandTableViewController.h"
#import "ZWHomeViewController.h"
#import "ZWMeViewController.h"
#import "ZWShopCarViewController.h"
#import "ZWNavigationController.h"

@interface ZWMainTaBarController ()<ZWTaBarDelegate>

@property(nonatomic,strong)ZWTaBar *customtabBar;

@end

@implementation ZWMainTaBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    设置taBbar
    [self wu_setTabBar];
//    创建子控制器
    [self wu_creatController];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    移除系统自带的tabbarbutton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

-(void)wu_setTabBar
{
//    设置tabbarbutton
    ZWTaBar *customtabBar = [[ZWTaBar alloc]init];
    customtabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customtabBar];
    self.customtabBar = customtabBar;
}

-(void)wu_creatController
{
    ZWHomeViewController *WaVc = [[ZWHomeViewController alloc]init]; 
    [self wu_setupChildViewController:WaVc title:@"首页" image:@"footer_icon_10" selectImage:@"footer_icon_10"];
    
    ZWBrandTableViewController *brandTableViewController = [[ZWBrandTableViewController alloc] init];
    [self wu_setupChildViewController:brandTableViewController title:@"品牌" image:@"footer_icon_4" selectImage:@"footer_icon_4"];
    
    ZWClassIfyingTableViewController *classIfyingTableViewController = [[ZWClassIfyingTableViewController alloc] init];
    [self wu_setupChildViewController:classIfyingTableViewController title:@"分类" image:@"footer_icon_6" selectImage:@"footer_icon_6"];
    
    ZWShopCarViewController *WeVc = [[ZWShopCarViewController alloc]init];
    [self wu_setupChildViewController:WeVc title:@"购物车" image:@"footer_icon_8" selectImage:@"footer_icon_8"];
    
    ZWMeViewController *WfVc = [[ZWMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self wu_setupChildViewController:WfVc title:@"我" image:@"footer_icon_2" selectImage:@"footer_icon_2"];
}

//  设置子控制器的标题图片
-(void)wu_setupChildViewController:(UIViewController *)childV
                         title:(NSString *)title
                         image:(NSString *)image
                   selectImage:(NSString *)selectImage
{
    childV.title = title;
    childV.tabBarItem.image = [UIImage imageNamed:image];
    childV.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    包装一个NavigationController导航控制器
    ZWNavigationController *nav = [[ZWNavigationController alloc]initWithRootViewController:childV];
    
    [self addChildViewController:nav];
    self.customtabBar.delegate = self;
    [self.customtabBar addTabBarButtonItem:childV.tabBarItem];
}

-(void)wu_tabBar:(ZWTaBar *)tabBar didSelectItemFrom:(long)from To:(long)to
{
    self.selectedIndex = to;
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
