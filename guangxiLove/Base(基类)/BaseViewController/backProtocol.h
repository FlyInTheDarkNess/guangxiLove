//
//  backProtocol.h
//  ZHSQ
//
//  Created by 赵中良 on 15/7/1.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol bringDelegate <NSObject>

@optional //可选实现的方法


- (void) BringWtihDic:(NSDictionary *)dic Type:(NSInteger)type;

- (void) bringWithItemId:(NSString *)itemid;//

- (void) bringWithItemId:(NSString *)itemid Type:(NSInteger)type;

- (void) bringWithItemData:(id)item Type:(NSInteger)type;

- (void) bringWithItemId:(NSString *)itemid dic:(NSDictionary *)dic Type:(NSInteger)type;

@end
