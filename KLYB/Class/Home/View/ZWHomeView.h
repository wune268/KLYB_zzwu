//
//  ZWHomeView.h
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWHomeView;
@class ZWActivity;
@class ZWTodayHot;

@protocol ZWHomeViewDelegate <NSObject>

-(void)wu_homeView:(ZWHomeView *)homeView
    buttonDidClick:(NSInteger)index
          activity:(ZWActivity *)activity;

@end

@interface ZWHomeView : UIView

@property(nonatomic,strong)NSArray *activityArray;
//@property(nonatomic,strong)NSArray *themePavilion;

- (instancetype)initWithFrame:(CGRect)frame
                     activity:(NSArray *)activity
                themePavilion:(NSArray *)themePavilion;

@property(nonatomic,weak)id<ZWHomeViewDelegate> delegate;
//@property(nonatomic,weak)ZWActivity *activity;
//@property(nonatomic,weak)ZWTodayHot *todayHot;

@end
