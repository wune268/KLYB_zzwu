//
//  ZWPassWordField.h
//  KLYB
//
//  Created by ZZWU on 15/12/23.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWPassWordField : UITextField

- (instancetype)initWithFrame:(CGRect)frame
                  placeholder:(NSString *)placeholder;
+ (instancetype)passWordWithFrame:(CGRect)frame
                      placeholder:(NSString *)placeholder;

@end
