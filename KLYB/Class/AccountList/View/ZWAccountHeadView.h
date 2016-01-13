//
//  ZWAccountHeadView.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWAccountHeadView;
@class ZWAddressItems;
@class ZWPayStyleItems;
@class ZWAccountPayTypeList;
@class ZWAccountAddressItems;

@protocol ZWAccountHeadViewDelegate <NSObject>

@optional

-(void)wu_accountHeadView:(ZWAccountHeadView *)accountHeadView buttonClick:(UIButton *)button;

@end

@interface ZWAccountHeadView : UIView

@property (nonatomic, strong) ZWAddressItems *addressItem;
@property (nonatomic, strong) ZWPayStyleItems *payStyleItem;
@property(nonatomic,weak)id<ZWAccountHeadViewDelegate> delegate;
@property (nonatomic, strong) ZWAccountAddressItems *accountAddressItems;
@property (nonatomic, strong) ZWAccountPayTypeList *accountPayTypeList;

@end
