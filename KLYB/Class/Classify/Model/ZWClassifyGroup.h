//
//  ZWClassifyGroup.h
//  KLYB
//
//  Created by ZZWU on 15/12/21.
//  Copyright © 2015年 ShengTang. All rights reserved.
//

@interface ZWClassifyGroup : NSObject

@property(nonatomic,copy)NSString *classifyID;
@property(nonatomic,copy)NSString *classifyLevel;
@property(nonatomic,copy)NSString *classifyName;
@property(nonatomic,strong)NSArray *classifySub;

@end
