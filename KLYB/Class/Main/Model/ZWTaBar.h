//
//  ZWTaBar.h
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWTaBar;

@protocol ZWTaBarDelegate <NSObject>

@optional

-(void)wu_tabBar:(ZWTaBar *)tabBar didSelectItemFrom:(long)from To:(long)to;

@end

@interface ZWTaBar : UIView

-(void)addTabBarButtonItem:(UITabBarItem *)item;
@property(nonatomic,weak)id<ZWTaBarDelegate> delegate;

@end
