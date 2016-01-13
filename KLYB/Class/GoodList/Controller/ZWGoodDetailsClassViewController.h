//
//  ZWThirdClassViewController.h
//  KLYB
//
//  Created by ZZWU on 15/12/7.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWClassRequestPrams;
@class ZWBrandRequestParams;
@class ZWSearchShopParams;
@class ZWActivityParams ;

@interface ZWGoodDetailsClassViewController : UIViewController

@property(nonatomic,strong)ZWClassRequestPrams *classRequestPrams;

@property(nonatomic,strong)ZWBrandRequestParams *brandRequestParams;

@property(nonatomic,strong)ZWSearchShopParams *searchShopParams;

@property(nonatomic,strong)ZWActivityParams *activityParams;

@end
