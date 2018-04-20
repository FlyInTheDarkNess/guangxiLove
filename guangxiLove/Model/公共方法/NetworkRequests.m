//
//  NetworkRequests.m
//  HappyFaceOneFamily
//
//  Created by 刘春浩 on 16/1/19.
//  Copyright © 2016年 刘春浩. All rights reserved.
//

#import "NetworkRequests.h"
#import <sys/sysctl.h>

@implementation NetworkRequests

+ (NetworkRequests *)defaultNetworkRequests
{
    static NetworkRequests *Net = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Net = [[NetworkRequests alloc] init];
    });
    return Net;
}



/*16进制___转___字符串*/
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    
    return unicodeString;
    
    
}

/*字符串___转___16进制*/
+ (NSString *)hexStringFromString:(NSString *)string{
    
    NSData *mD = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str1 = [[NSString alloc]initWithData:mD encoding:NSUTF8StringEncoding];
    NSString *str = [self handleSpaceAndEnterElementWithString:str1];
    NSData *myD = [str dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",[hexStr uppercaseString],newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",[hexStr uppercaseString],newHexStr];
    }
    return hexStr;
}



/*Json___转___Json字符串*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self handleSpaceWithString:str];
    
}



/*Json字符串___转___Json*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
    }
    return dic;
}






/*
 * 字符串___去掉___空格,回车
 */
+ (NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr
{
    
    
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
    
    return realSre2;
    
}
+ (NSString *)handleSpaceWithString:(NSString *)sourceStr
{
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    
    NSLog(@"参数合并后--------%@",realSre2);
    
    return realSre2;
    
}


// 计算字符串自适应
+ (CGFloat)p_heightWithString:(NSString *)aString marker:(NSString *)marker weight:(CGFloat)weight height:(CGFloat)height fount:(CGFloat)fount {
    
    if ([marker isEqualToString:@"weight"]) {
        
        CGRect r = [aString boundingRectWithSize:CGSizeMake(99999999999, /*高度*/height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fount]} context:nil];
        
        return r.size.width;
    }else if ([marker isEqualToString:@"height"]) {
        
        CGRect r = [aString boundingRectWithSize:CGSizeMake(/*宽度*/weight, 99999999999) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fount]} context:nil];
        
        return r.size.height;
    }
    return 0;
}


/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSString *)dateString1 dateString2:(NSString *)dateString2 XiTong:(NSString *)XiTong
{
//  开始时间:2017/1/3 17:30:00-------结束时间:2017/1/11 22:00:00-------系统时间:2017/1/20 16:26:15/
    NSLog(@"开始时间:%@-------结束时间:%@-------系统时间:%@",dateString1,dateString2,XiTong);
    
//    dateString1 = @"2017/1/20 16:53:00";
//    
//    XiTong = @"2017/1/20 16:56:00";
//    
//    dateString2 = @"2017/1/20 16:56:00";
    
    /*
     * 开始时间
     */
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSDate *compareDate1 = [dateFormatter1 dateFromString:dateString1];
    NSTimeInterval  timeInterval1 = [compareDate1 timeIntervalSinceNow];
    NSLog(@"开始时间%@",compareDate1);
    NSLog(@"开始时间timeInterval1:%f",timeInterval1);
    
    /*
     * 结束时间
     */
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSDate *compareDate2 = [dateFormatter2 dateFromString:dateString2];
    NSTimeInterval  timeInterval2 = [compareDate2 timeIntervalSinceNow];
    NSLog(@"结束时间%@",compareDate2);
    NSLog(@"结束时间timeInterval2:%f",timeInterval2);
    
    
    /*
     * 系统时间
     */
    NSDateFormatter *dateFormatter3 = [[NSDateFormatter alloc] init];
    [dateFormatter3 setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSDate *compareDate3 = [dateFormatter3 dateFromString:XiTong];
    NSTimeInterval  timeInterval3 = [compareDate3 timeIntervalSinceNow];
    NSLog(@"系统时间%@",compareDate3);
    NSLog(@"系统时间timeInterval3:%f",timeInterval3);
    
    
    
    NSString *Status;
    
    
    // 0-->即将开始    1-->正在进行   2-->已结束
    
    if (timeInterval1 > timeInterval3) {
        Status = @"0";
    }else if (timeInterval2 < timeInterval3) {
        Status = @"2";
    }else if (timeInterval2 > 0) {
        Status = @"1";
    }else {
        Status = @"2";
    }
    return  Status;
}


/**
 * @param source_image   需要压缩的图片
 * @param maxSize   压缩图片的KB的最大值
 * @return 压缩完图片的二进制
 
 */
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

/*
 * 获取手机型号
 */
+ (NSString *)platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


/*
 * 去除字符串前后空格
 */
+ (NSString *)String_Dele_Blank:(NSString *)String {
    
    int First = 0;
    int Last = 0;
    
    NSLog(@"11111111---%@----%lu",String,(unsigned long)[String length]);
    
    // 循环算出开头的空格数
    for (int i = 0; i < [String length]; i++) {
        
        NSString *Str = [String substringWithRange:NSMakeRange(i, 1)];
        
        if ([Str isEqualToString:@" "]) {
            First += 1;
        } else {
            break;
        }
    }
    
    // 去掉开头的空格
    if (First > 0) {
        String = [String substringFromIndex:First];
    }
    
    
    
    NSLog(@"22222------%@----%lu",String,(unsigned long)[String length]);
    
    // 循环算出结尾的空格数
    for (int i = 0; i < [String length]; i++) {
        
        NSString *Str = [String substringWithRange:NSMakeRange([String length] - i - 1, 1)];
        
        if ([Str isEqualToString:@" "]) {
            Last += 1;
        } else {
            break;
        }
    }
    
    // 去掉结尾的空格
    if (Last > 0) {
        String = [String substringToIndex:[String length] - Last];
    }
    
    NSLog(@"333333------%@----%lu",String,(unsigned long)[String length]);
    
    return String;
}

/*
 * 更改固定字符在字符串中的颜色
 */
+ (NSAttributedString *)Change_String_Color_SearchStr:(NSString *)SearchStr ModelStr:(NSString *)ModelStr {
    
    NSRange range = {0,ModelStr.length};
    
    NSMutableAttributedString *Attr = [[NSMutableAttributedString alloc] initWithString:ModelStr];
    
    NSError *error;
    
    NSRegularExpression *express = [NSRegularExpression regularExpressionWithPattern:SearchStr options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray<NSTextCheckingResult *> * result = [express matchesInString:ModelStr options:0 range:range];
    
    for (NSTextCheckingResult * match in result) {
        NSRange range = [match range];
        [Attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    NSAttributedString *attrString = [Attr copy];
    
    
    return attrString;
}






@end
