//
//  ZWThemePavilionButton.h
//  KLYB
//
//  Created by ZZWU on 15/12/17.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWThemePavilion.h"

@interface ZWThemePavilionButton : UIButton

//@property(nonatomic,weak)ZWThemePavilion *themePavilion;

+ (instancetype)buttonWithFrame:(CGRect)frame
                  themePavilion:(ZWThemePavilion *)themePavilion;

- (instancetype)initWithFrame:(CGRect)frame
                themePavilion:(ZWThemePavilion *)themePavilion;

//+ (instancetype)buttonWithFrame:(CGRect)frame;
//
//- (instancetype)initWithFrame:(CGRect)frame;


@end
