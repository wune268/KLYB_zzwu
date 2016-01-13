//
//  ZWAccountViewController.h
//  KLYB
//
//  Created by ZZWU on 15/12/11.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@class ZWAddressItems;
@class ZWPayStyleItems;
@class ZWAccountParams;

@interface ZWAccountViewController : UITableViewController

@property (nonatomic, strong) ZWAddressItems *addressItems;

@property (nonatomic, strong) ZWPayStyleItems *payStyleItems;

@property(nonatomic, strong) ZWAccountParams *accountParams;

@end
