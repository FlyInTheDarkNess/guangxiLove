//
//  SurveyRunTimeData.h
//  HenanOA
//
//  Created by 安雄浩的mac on 14-5-12.
//  Copyright (c) 2014年 北京博微志远信息技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyRunTimeData : NSObject
+ (SurveyRunTimeData*)sharedInstance;

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *password;

/**
 *邻居圈模块数组
 */
@property (nonatomic,strong) NSArray   *roundTypeArr;
//用户session
@property (nonatomic,strong) NSString *session;
//手机号码
@property (nonatomic,strong) NSString *mobilePhone;
//用户id
@property (nonatomic,strong) NSString *user_id;
/**
 *社区id
 */
@property (nonatomic,strong) NSString *community_id;
/**
 *城市id
 */
@property (nonatomic,strong) NSString *city_id;
/**
 *所在办事处
 */
@property (nonatomic,strong) NSString *agency_id;
/**
 *所在小区
 */
@property (nonatomic,strong) NSString *quarter_id;
/**
 *所在区县
 */
@property (nonatomic,strong) NSString *area_id;

// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;


//hud
+(void)showWithCustomView:(UIView *)view withMsg:(NSString *)aString;

+(void)showWithCustomView:(UIView *)view withDetailMsg:(NSString *)aString;

//根据code值提示信息
+(void)showWithView:(UIView *)view withRequestStr:(NSString *)aString;


/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSString *) dateString;
/*处理返回应该显示的时间*/
+ (NSString *) returnUploadTime:(NSString *)timeStr;
/*处理返回应该显示的时间(星期)*/
+ (NSString *) returnUploadXQTime:(NSString *)timeStr;

/*处理返回消息中的时间*/
+ (NSString *) returnUploadXXTime:(NSString *)timeStr;

/*处理返回大转盘中奖的时间*/
+ (NSString *) returnUploadYYTime:(NSString *)timeStr;

/*处理返回广告统计的时间*/
+ (NSString *) returndateTime:(NSDate *)date;

/*
 *转换json语句为NSString
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (NSString *)hexStringFromStr:(NSString *)string;

//给机密东西加密
+ (NSString *)jiaxingWithStr:(NSString *)str;

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;

//获取手机型号
+ (NSString *)platform;

//时间格式转化
+ (NSString *)getDateStr:(NSString *)dateStr WithDFomate:(NSString *)fommater toFommater:(NSString *)lastformmater;

+(float)fileSizeAtPath:(NSString *)path;

+(float)folderSizeAtPath:(NSString *)path;

+(NSString *)deleteSword:(NSString *)str;

+(NSString *)changeWithString:(NSString *)str;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

//当前为登录状态或者游客状态
+ (BOOL)isLoginIn;

//获取当前控制器
+ (UIViewController *)getCurrentViewController;

//获取tabbarcontroller
+(UIViewController *)getTabarController;

//格式化小数 四舍五入类型
+ (NSString *)decimalwithFormat:(NSString *)format floatV:(float)floatV;

+(NSArray *)getArrFromList:(NSArray *)dictArray withKey:(NSString *)KeyWord;

//获取当前网络状态
+ (NSString *)getNetworkType;

/*分享内容的类型
资讯分享：0
投票分享：1
笑脸e商家分享：2
帖子分享：3
直购商家：4
直购商品：５
优惠券：  6
大转盘：  7
 */
+ (void)shareWithimageArray:(NSArray *)imageArr shareUrl:(NSString *)shareurl shareTitle:(NSString *)sharetitle shareDetail:(NSString *)shareDetail Type:(NSString *)type;

//当前时区时间转化
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

+ (double)mxGetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE;

/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage;

+(void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number;

//获取时间差
+ (NSInteger)mxGetChaTimeDiff:(NSString*)timeS timeE:(NSString*)timeE;

/**
 * 根据广告内容跳转页面
 * @param controller 跳转前的控制器
 * @param actDic 广告内容dic
 */
+ (void)turnWithController:(UIViewController *)controller actDic:(NSDictionary *) actDic;

/**
 * 打开app后根据链接内容跳转页面
 * @param controller 跳转前的控制器
 * @param actDic 广告内容dic
 */
+ (void)turnWithController:(UIViewController *)controller UrlStr:(NSString *) urlStr;

+ (UIImage *)imageWithColor:(UIColor *)color;

@end
