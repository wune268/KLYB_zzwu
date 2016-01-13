//
//  AppDelegate.m
//  KLYB
//
//  Created by ZW on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWMainTaBarController.h"
#import "ZWSubmitOrdersViewController.h"

#import "ZWAccountTool.h"
#import "ZWUserAccount.h"
#import "ZWUserLoginHttpTool.h"
#import "CommonFunc.h"
#import "ZWUserLoginKeyItems.h"

#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    window.bounds = [UIScreen mainScreen].bounds;
    ZWMainTaBarController *ZWMController = [[ZWMainTaBarController alloc] init];
    window.rootViewController = ZWMController;
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    [self.window makeKeyAndVisible];
    
    ZWUserAccount *account = [ZWAccountTool account];
    if (account) {
        [ZWUserLoginHttpTool wu_getKeyWithparams:nil success:^(ZWUserLoginKeyItems *keyItems) {
//            self.keyItems = keyItems;
//            WuLog(@"keyItemskeyItems-----%@",keyItems.status);
//            [self wu_setUserLogin];
            WuLog(@"--currentThread--%@",[NSThread currentThread]);
//            ZWUserAccount *account = [ZWAccountTool account];
            if ([keyItems.status isEqualToString:@"success"]) {
                NSString *password = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@%@",keyItems.keyExponent, [CommonFunc textFromBase64String:account.password]]];
                WuLog(@"%@",[CommonFunc textFromBase64String:account.password]);
                NSString *username = account.userName;
                NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"account", password, @"password", nil];
                [ZWUserLoginHttpTool wu_postLoginWithparams:param success:^(id json) {
                    WuLog(@"%@----------json",json);
                    WuLog(@"--currentThread--%@",[NSThread currentThread]);
                } failure:^(NSError *error) {
                    
                }];
            }
        } failure:^(NSError *error) {
            WuLog(@"%@",error);
        }];
    }
    
    return YES;
}

//-(void)wu_getKeyForUserLogin
//{
//    STUserAccount *account = [STAccountTool account];
//    if (account) {
//        [STUserLoginHttpTool wu_getKeyWithparams:nil success:^(STUserLoginKeyItems *keyItems) {
//            self.keyItems = keyItems;
//            WuLog(@"keyItemskeyItems-----%@",keyItems.status);
//            [self wu_setUserLogin];
//            WuLog(@"--currentThread--%@",[NSThread currentThread]);
//        } failure:^(NSError *error) {
//            WuLog(@"%@",error);
//        }];
//    }
//}
//
//- (void)wu_setUserLogin
//{
//    STUserAccount *account = [STAccountTool account];
//    if ([self.keyItems.status isEqualToString:@"success"]) {
//        NSString *password = [CommonFunc base64StringFromText:[NSString stringWithFormat:@"%@%@",self.keyItems.keyExponent, [CommonFunc textFromBase64String:account.password]]];
//        WuLog(@"%@",[CommonFunc textFromBase64String:account.password]);
//        NSString *username = account.userName;
//        NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:username, @"account", password, @"password", nil];
//        [STUserLoginHttpTool wu_postLoginWithparams:param success:^(id json) {
//            WuLog(@"%@----------json",json);
//            WuLog(@"--currentThread--%@",[NSThread currentThread]);
//        } failure:^(NSError *error) {
//            
//        }];
//    }
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        WuLog(@"支付完成－－－－resultDic = %@, url = %@",resultDic,url);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipayResult" object:nil userInfo:resultDic];
    }];
    
    return YES;
}

@end
