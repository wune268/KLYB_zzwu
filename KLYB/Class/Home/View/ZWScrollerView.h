//
//  ZWScrollerView.h
//  KLYB
//
//  Created by ZZWU on 15/12/9.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWActivity;

@protocol ZWScrollerViewDelegate <NSObject>

@optional

-(void)wu_scrollerViewDidClicked:(NSUInteger)index
                        activity:(ZWActivity *)activity;

@end

@interface ZWScrollerView : UIView<UIScrollViewDelegate>

@property(nonatomic,weak)id<ZWScrollerViewDelegate> delegate;

-(id)initWithFrameRect:(CGRect)frame
            scrolArray:(NSArray *)array
                  type:(NSInteger) type;

//-(id)initWithFrameRect:(CGRect)frame type:(NSInteger) type;

@end
