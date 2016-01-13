//
//  ZWPayStyleItems.h
//  KLYB
//
//  Created by ZZWU on 15/12/22.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWPayStyleItems : NSObject

@property(nonatomic,copy)NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemsWithDict:(NSDictionary *)dict;

- (NSString *)wu_description;

@end
