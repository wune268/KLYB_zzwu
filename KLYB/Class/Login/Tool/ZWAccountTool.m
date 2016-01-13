//
//  ZWAccountTool.m
//  KLYB
//
//  Created by ZZWU on 16/1/6.
//  Copyright © 2016年 ShengTang. All rights reserved.
//

#import "ZWAccountTool.h"
#import "ZWUserAccount.h"

#define Wu_userAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAccount.data"]

@implementation ZWAccountTool

+ (void)saveAccount:(ZWUserAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:Wu_userAccountFile];
}

+ (ZWUserAccount *)account
{
    // 取出账号
    ZWUserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:Wu_userAccountFile];
    
    return account;
}

+ (void)removeAccount
{
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    [fileManager removeItemAtPath:Wu_userAccountFile error:nil];
}

@end
