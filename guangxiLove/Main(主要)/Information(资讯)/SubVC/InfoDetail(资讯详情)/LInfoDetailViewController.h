//
//  LInfoDetailViewController.h
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/28.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ZZLBaseViewController.h"

@interface LInfoDetailViewController : ZZLBaseViewController

@property (nonatomic, strong) NSString *XiangQing_id; // 主贴id
@property (nonatomic, assign) BOOL IsWeb; // 是否为网页
@property (nonatomic, strong) NSDictionary *ZhuTie_Detail; // 主贴详情

@end
