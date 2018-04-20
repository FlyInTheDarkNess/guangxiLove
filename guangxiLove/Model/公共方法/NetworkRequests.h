//
//  NetworkRequests.h
//  HappyFaceOneFamily
//
//  Created by 刘春浩 on 16/1/19.
//  Copyright © 2016年 刘春浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequests : NSObject


+ (NetworkRequests *)defaultNetworkRequests;

/* 网络的状态(0断开网络, 1流量, 2WiFi)*/
@property (nonatomic, assign) int NetWorkStatus;

// 店铺管理Header高度设置
//@property (nonatomic, assign) int ShopManageHeader;

/*16进制___转___字符串*/
+ (NSString *)stringFromHexString:(NSString *)hexString;

/*字符串___转___16进制*/
+ (NSString *)hexStringFromString:(NSString *)string;

/*Json___转___Json字符串*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/*Json字符串___转___Json*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*
 * 字符串___去掉___空格,回车
 */
+ (NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr;


/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSString *)dateString1 dateString2:(NSString *)dateString2 XiTong:(NSString *)XiTong;

/**
 * 计算指定时间与当前的时间差
 * @param source_image   需要压缩的图片
 * @param maxSize   压缩图片的KB的最大值
 * @return 压缩完图片的二进制
 */
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

/*
 * 获取手机型号
 */
+ (NSString *)platform;


/*
 * 字符串自适应
 */
+ (CGFloat)p_heightWithString:(NSString *)aString marker:(NSString *)marker weight:(CGFloat)weight height:(CGFloat)height fount:(CGFloat)fount;

/*
 * 去除字符串前后空格
 */
+ (NSString *)String_Dele_Blank:(NSString *)String;

/*
 * 更改固定字符在字符串中的颜色
 */
+ (NSAttributedString *)Change_String_Color_SearchStr:(NSString *)SearchStr ModelStr:(NSString *)ModelStr;

@end
