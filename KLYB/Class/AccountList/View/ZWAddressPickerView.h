//
//  ZWAddressPickerView.h
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

#import "ZWAddressModel.h"

@class ZWAddressPickerView;

typedef void (^ZWAddressPickerViewBlock)(ZWAddressPickerView *view,UIButton *btn,ZWAddressModel *locate);

@interface ZWAddressPickerView : UIView

@property (copy, nonatomic)ZWAddressPickerViewBlock block;

//- (void)show;

@end
