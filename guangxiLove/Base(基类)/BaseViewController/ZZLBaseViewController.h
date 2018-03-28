//
//  ZZLBaseViewController.h
//  ZHSQ
//
//  Created by 赵中良 on 15/9/15.
//  Copyright (c) 2015年 lacom. All rights reserved.
//
// 待完善 

#import <UIKit/UIKit.h>
#import "URL.h"
#import "UserInfo.h"
#import "backProtocol.h"

/*
 使用枚举来判断当前左键的类型
 */
typedef NS_ENUM(NSInteger, ButtonType)
{
    //以下是枚举成员
    ButtonTypeBack = 0,//返回键
    ButtonTypeGouwuche = 1,//购物车
    ButtonTypeNone = 2,//没有
};

typedef enum {
    //以下是枚举成员
    ViewTurnTypeBack = 0,     //添加缴费地址
    ViewTurnTypeYouke = 1,    //游客快速登录
    ViewTurnTypeXiaoQu = 2,   //添加小区
    ViewTurnTypeRoom = 3,     //添加房间(物业报修)
    ViewTurnTypeD = 4,     //最新登录流程
    ViewTurnType,             //跳转默认
} ViewTurnTypes;              //枚举名称

@interface ZZLBaseViewController : UIViewController

@property (nonatomic,assign) ButtonType leftButtonType;//navigation左键类型

@property (nonatomic,assign) ButtonType rightButtonType;//navigation右键类型

@end
