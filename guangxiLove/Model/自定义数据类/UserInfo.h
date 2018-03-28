//
//  UserInfo.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "JDH.h"
#import "AddressInfo.h"


@interface UserInfo : NSObject


@property (nonatomic,strong) NSString *session;  //
@property (nonatomic,strong) NSString *userId;   //用户id
@property (nonatomic,strong) NSString *nickName;  //用户名（网络昵称）

@property (nonatomic,strong) NSString *authority_status; //用户权限
/*
 用户姓名
 */
@property (nonatomic,strong) NSString *name;
/*
 用户性别
 */
@property (nonatomic,strong) NSString *sex;
/*
 用户权限
 */
@property (nonatomic,strong) NSString *rank;
/*
 用户头像地址
 */
@property (nonatomic,strong) NSString *icon_path;
/*
 用户邮箱
 */
@property (nonatomic,strong) NSString *email;
/*
 用户身份证号
 */
@property (nonatomic,strong) NSString *idnumber;
/*
 注册手机号码
 */
@property (nonatomic,strong) NSString *mobile_phone;
/*
 当前设备imei
 */
@property (nonatomic,strong) NSString *imei;

@property (nonatomic,strong) NSString *memberLevel;

@property (nonatomic,strong) NSString *jfCount;

@property (nonatomic,strong) NSString *YUECount;//钱包余额

@property (nonatomic,strong) NSString *YUETotalCount;

@property (nonatomic,strong) NSString *bagTotalCount;
/**
 * 经度
 **/
@property (nonatomic,strong) NSString *longitude; //经度

/**
 * 经度
 **/
@property (nonatomic,strong) NSString *latitude; //纬度

/**
 * 是否含有返现功能
 **/
@property (nonatomic,strong) NSString *isfanxian;

/*
 是否开通缴费
 */
@property (nonatomic,strong) NSString *jiaofei_status;

/*
 缴费区间
 */
@property (nonatomic,strong) NSString *jiaofei_paytime;

/*
 是否开通预存
 */
@property (nonatomic,strong) NSString *prestore;

/*
 是否开通预缴
 */
@property (nonatomic,strong) NSString *yujiao_status;


/*
 当前地址信息
 */
@property (nonatomic,strong) AddressInfo *currentAddress;

@property (nonatomic,strong) NSArray *personArr;

@property (nonatomic,strong) NSArray *carArr;

@property (nonatomic,strong) NSArray *jdhArr;

@property (nonatomic,strong) NSArray *addressArr;

@property (nonatomic,strong) NSArray *moduleArr;//邻居圈分类

@property (nonatomic,strong) NSString *partner;//支付宝合作账号

@property (nonatomic,strong) NSString *prikey;//商户私钥

@property (nonatomic,strong) NSString *seller;//支付宝账号

@property (nonatomic,strong) NSString *roomLV;//绑定房间等级

@property (nonatomic,strong) NSString *bankOpen;//银行卡支付方式

@property (nonatomic,strong) NSString *bankType;// 银行名称 1.建行 2 邮储

@property (nonatomic,strong) NSString *zfbOpen;//支付宝支付方式

// 发帖板块数据
@property (nonatomic,strong) NSArray *FaTie_Array;



- (id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr Session:(NSString *)Session;

- (id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr ModuleArr:(NSArray *)ModuleArr Session:(NSString *)Session;

//直接通过request初始化
- (id)initWithDic:(NSDictionary *)requstDic;

- (id)init;





























@end
