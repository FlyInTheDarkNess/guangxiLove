//
//  SurveyRunTimeData.m
//  HenanOA
//
//  Created by 安雄浩的mac on 14-5-12.
//  Copyright (c) 2014年 北京博微志远信息技术有限公司 All rights reserved.
//

#import "SurveyRunTimeData.h"
#import <sys/sysctl.h>

#define DEFAULT_VOID_COLOR [UIColor whiteColor]


static SurveyRunTimeData *sharedObj = nil;


@implementation SurveyRunTimeData


+ (SurveyRunTimeData*)sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj =  [[SurveyRunTimeData alloc] init];
            
        }
    }
    return sharedObj;
}
+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}
- (id) copyWithZone:(NSZone *)zone //第四步
{
    return self;
}
- (id)init
{
    @synchronized(self) {
        
        return self;
    }
}

+ (void)altShow:(NSString *)msg{
    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

// 十六进制转换为普通字符串的。
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
    //NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;


}


//去掉空格，回车
+ (NSString *)handleSpaceAndEnterElementWithString:(NSString *)sourceStr
{
    
    
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
    
    
    
//    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    NSString *realSre4 = [realSre3 stringByReplacingOccurrencesOfString:@"(" withString:@""];
//    
//    NSString *realSre5 = [realSre4 stringByReplacingOccurrencesOfString:@")" withString:@""];

//    NSArray *array = [realSre componentsSeparatedByString:@"\n"];
//    NSString *str = [array componentsJoinedByString:@"\\n"];
    
    NSLog(@"合并后：%@",realSre2);
    return realSre2;

}

+ (NSString *)handleSpaceWithString:(NSString *)sourceStr
{
    NSString *realSre = [sourceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\t" withString:@" "];
    
//    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    return realSre2;
    
}

//普通字符串转换为十六进制的。（单纯转化）
+ (NSString *)hexStringFromStr:(NSString *)string{
    
    
//    NSString *str = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSData *mD = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str1 = [[NSString alloc]initWithData:mD encoding:NSUTF8StringEncoding];
    NSString *str = [self handleSpaceAndEnterElementWithString:str1];
    NSData *myD = [str dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    }
//    NSLog(@"加密后：%@",hexStr);
    return hexStr;
    
}

//普通字符串转换为十六进制的。（传json）
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

/**
 * 返回当前时间
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */

+(NSString *) compareCurrentTime:(NSString *) dateString

{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
  
    NSDate *compareDate= [dateFormatter dateFromString:dateString];
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

/*处理返回应该显示的时间*/
+ (NSString *) returnUploadTime:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date= [dateFormatter dateFromString:timeStr];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDateFormatter *yourformatter = [[NSDateFormatter alloc]init];
    
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1) {
        
            
            [yourformatter setDateFormat:@"HH:mm"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        
        [yourformatter setDateFormat:@"HH:mm"];
        
        timeString = [NSString stringWithFormat:@"今天 %@",[yourformatter stringFromDate:date]];
        
        NSTimeInterval secondPerDay = 24*60*60;
        
        NSDate * yesterDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
        
        NSCalendar * calendar = [NSCalendar currentCalendar];
        
        unsigned uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents * souretime = [calendar components:uintFlags fromDate:date];
        
        NSDateComponents * yesterday = [calendar components:uintFlags fromDate:yesterDay];
        
        if (souretime.year == yesterday.year && souretime.month == yesterday.month && souretime.day == yesterday.day){
            
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
        }
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        
        int num = [timeString intValue];
        
        if (num < 2) {
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }else if(num == 2){
            
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }else if (num > 2 && num <7){
            
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            //            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            
            //            timeString = [NSString stringWithFormat:@"1周前"];
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }else if(num > 10){
            
            [yourformatter setDateFormat:@"MM/dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }
        
    }
    
    
    return timeString;
}

/*处理返回应该显示的时间*/
+ (NSString *) returnUploadXQTime:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date= [dateFormatter dateFromString:timeStr];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDateFormatter *yourformatter = [[NSDateFormatter alloc]init];
    
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1) {
        
        
        [yourformatter setDateFormat:@"HH:mm"];
        
        timeString = [NSString stringWithFormat:@"今天 %@",[yourformatter stringFromDate:date]];
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        [yourformatter setDateFormat:@"HH:mm"];
        
        timeString = [NSString stringWithFormat:@"今天 %@",[yourformatter stringFromDate:date]];
        
        NSTimeInterval secondPerDay = 24*60*60;
        
        NSDate * yesterDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
        
        NSCalendar * calendar = [NSCalendar currentCalendar];
        
        unsigned uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents * souretime = [calendar components:uintFlags fromDate:date];
        
        NSDateComponents * yesterday = [calendar components:uintFlags fromDate:yesterDay];
        
        if (souretime.year == yesterday.year && souretime.month == yesterday.month && souretime.day == yesterday.day){
            
            [yourformatter setDateFormat:@"HH:mm"];
            
            timeString = [NSString stringWithFormat:@"昨天 %@",[yourformatter stringFromDate:date]];
        }
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            [yourformatter setDateFormat:@"HH:mm"];
            
            timeString = [NSString stringWithFormat:@"昨天 %@",[yourformatter stringFromDate:date]];
            
        }else if(num == 2){
            
            [yourformatter setDateFormat:@"HH:mm"];
            
            timeString = [NSString stringWithFormat:@"前天 %@",[yourformatter stringFromDate:date]];
            
        }else if (num > 2 && num <7){
            
            // 周几和星期几获得
            NSCalendar*calendar = [NSCalendar currentCalendar];
            NSDateComponents *comps;
            comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                    
                               fromDate:date];
            
            NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
            NSString *str;
            switch (weekday) {
                case 1:
                    str = @"星期日";
                    break;
                case 2:
                    str = @"星期一";
                    break;
                case 3:
                    str = @"星期二";
                    break;
                case 4:
                    str = @"星期三";
                    break;
                case 5:
                    str = @"星期四";
                    break;
                case 6:
                    str = @"星期五";
                    break;
                case 7:
                    str = @"星期六";
                    break;
                    
                default:
                    break;
            }
            [yourformatter setDateFormat:@" HH:mm"];
            
            timeString = [NSString stringWithFormat:@"%@%@",str,[yourformatter stringFromDate:date]];
            //            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            
            //            timeString = [NSString stringWithFormat:@"1周前"];
            [yourformatter setDateFormat:@"MM月dd日 HH:mm"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }else if(num > 10){
            
            [yourformatter setDateFormat:@"MM月dd日 HH:mm"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
            
        }
        
    }
    
    
    return timeString;
}

/*处理返回消息中的时间*/
+ (NSString *) returnUploadXXTime:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date= [dateFormatter dateFromString:timeStr];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDateFormatter *yourformatter = [[NSDateFormatter alloc]init];
    
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1) {
        
        
        [yourformatter setDateFormat:@"HH:mm"];
        
        timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        [yourformatter setDateFormat:@"HH:mm"];
        
        timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
        
        NSTimeInterval secondPerDay = 24*60*60;
        
        NSDate * yesterDay = [NSDate dateWithTimeIntervalSinceNow:-secondPerDay];
        
        NSCalendar * calendar = [NSCalendar currentCalendar];
        
        unsigned uintFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
        
        NSDateComponents * souretime = [calendar components:uintFlags fromDate:date];
        
        NSDateComponents * yesterday = [calendar components:uintFlags fromDate:yesterDay];
        
        if (souretime.year == yesterday.year && souretime.month == yesterday.month && souretime.day == yesterday.day){
            
            [yourformatter setDateFormat:@"YYYY.MM.dd"];
            
            timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
        }
    }else{
        [yourformatter setDateFormat:@"YYYY.MM.dd"];
        
        timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
    }
    
    return timeString;
}

/*处理返回大转盘中奖的时间*/
+ (NSString *) returnUploadYYTime:(NSString *)timeStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *date= [dateFormatter dateFromString:timeStr];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDateFormatter *yourformatter = [[NSDateFormatter alloc]init];
    
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    
    [yourformatter setDateFormat:@"YYYY-MM-dd"];
    
    timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
    
    
    return timeString;
}

/*处理返回广告统计的时间*/
+ (NSString *) returndateTime:(NSDate *)date
{
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDateFormatter *yourformatter = [[NSDateFormatter alloc]init];
    
    //    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    
    [yourformatter setDateFormat:@"YYYY-MM-dd-hh"];
    
    timeString = [NSString stringWithFormat:@"%@",[yourformatter stringFromDate:date]];
    
    
    return timeString;
}












/*
 *转换json语句为NSString
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [self handleSpaceWithString:str];
}

+ (NSString *)jiaxingWithStr:(NSString *)str{
    if (str.length == 1) {
        return str;
    }else if (str.length == 2){
        NSString *string = [str substringToIndex:1];
        NSString *laststr = [NSString stringWithFormat:@"%@*",string];
        return laststr;
    }
    else if(str.length > 2){
        int num = str.length/3;
        int number = str.length%3;
        NSString *string = [str substringWithRange:NSMakeRange(num, num + number)];
        NSString *str1 = @"*";
        for (int n = 1; n < number + num; n++) {
            str1 = [NSString stringWithFormat:@"%@*",str1];
        }
       NSString *laststr = [str stringByReplacingOccurrencesOfString:string withString:str1];
        return laststr;
    }else{
        return str;
    }
    
    return str;
}

//判断是否为整形：

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

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
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
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
    
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    if (kDevice_Is_iPhoneX) {
        return @"iPhone X";
    }
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    if (MY_WIDTH == 375&&MY_HEIGHT == 812) {
        return @"iPhone X";
    }
    
    return platform;
}

//时间格式转化
+ (NSString *)getDateStr:(NSString *)dateStr WithDFomate:(NSString *)fommater toFommater:(NSString *)lastformmater{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: fommater];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat: lastformmater];
    NSString *str = [dateFormatter2 stringFromDate:date];
    return str;
}

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[SurveyRunTimeData fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}


-(NSString*)getDocumentsPath
{
    //获取Documents路径
    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString*path=[paths objectAtIndex:0];
    NSLog(@"path:%@",path);
    return path;
}

+(NSString *)deleteSword:(NSString *)str{
    NSString *realSre = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *realSre1 = [realSre stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSString *realSre2 = [realSre1 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    NSString *realSre3 = [realSre2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return realSre3;
}

+(NSString *)changeWithString:(NSString *)str{
    NSString *string;
    if ([str isEmpty]) {
        string = [NSString stringWithFormat:@"%@",str];
    }else{
        string = @"";
    }
    return string;
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



//当前为登录状态或者游客状态
+ (BOOL)isLoginIn{
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    NSString *myString_zhanghao = [userDefaulte stringForKey:@"denglu_zhanghao"];
    NSString *myString_mima = [userDefaulte stringForKey:@"denglu_mima"];
    if ([myString_mima isEmpty]&&[myString_zhanghao isEmpty]) {
        return YES;
    }
    return NO;
}

+(UIViewController *)getCurrentViewController{
//    UIViewController *result = nil;
//
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//    return result;
    
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

+(UIViewController *)getTabarController{
        UIViewController *result = nil;
    
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        if (window.windowLevel != UIWindowLevelNormal)
        {
            NSArray *windows = [[UIApplication sharedApplication] windows];
            for(UIWindow * tmpWin in windows)
            {
                if (tmpWin.windowLevel == UIWindowLevelNormal)
                {
                    window = tmpWin;
                    break;
                }
            }
        }
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UITabBarController class]])
            result = nextResponder;
        else
            result = window.rootViewController;
        return result;
}


//格式化小数 四舍五入类型
+ (NSString *)decimalwithFormat:(NSString *)format floatV:(float)floatV{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setPositiveFormat:format];
    return [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

+(NSArray *)getArrFromList:(NSArray *)dictArray withKey:(NSString *)KeyWord{
    NSArray *_dataArray = dictArray;
    NSMutableArray *_titleArray = [NSMutableArray array];
    //首先把原数组中数据的日期取出来放入timeArr
    NSMutableArray *timeArr=[NSMutableArray array];
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *currentDict=obj;
        NSString *currentStr1=[NSString stringWithFormat:@"%@",[currentDict objectForKey:KeyWord]];
        [timeArr addObject:currentStr1];
    }];
    //使用asset把timeArr的日期去重
    NSSet *set = [NSSet setWithArray:timeArr];
    NSArray *userArray = [set allObjects];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];//yes升序排列，no,降序排列
    //按日期降序排列的日期数组
    NSArray *myary = [userArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    //此时得到的myary就是按照时间降序排列拍好的数组
    _titleArray=[NSMutableArray array];
    //遍历myary把_titleArray按照myary里的时间分成几个组每个组都是空的数组
    [myary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arr=[NSMutableArray array];
        [_titleArray addObject:arr];
        
    }];
    //遍历_dataArray取其中每个数据的日期看看与myary里的那个日期匹配就把这个数据装到_titleArray 对应的组中
    [_dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *currentDict=obj;
        NSString *currentStr1=[NSString stringWithFormat:@"%@",[currentDict objectForKey:KeyWord]];
        for (NSString *str in myary)
        {
            if([str isEqualToString:currentStr1])
            {
                NSMutableArray *arr=[_titleArray objectAtIndex:[myary indexOfObject:str]];
                [arr addObject:currentDict];
            }
        }
        
    }];
    NSLog(@"%@",_titleArray);
    return _titleArray;
}



+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

+ (double)mxGetStringTimeDiff:(NSString*)timeS timeE:(NSString*)timeE{
    double timeDiff = 0.0;
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSDate *dateS = [formatters dateFromString:timeS];
    NSDateFormatter *formatterE = [[NSDateFormatter alloc]init];
    [formatterE setDateFormat:@"yyyy/M/d HH:mm:ss"];
    NSDate *dateE = [formatterE dateFromString:timeE];
    timeDiff = [dateE timeIntervalSinceDate:dateS ];
    
    timeDiff = [dateE timeIntervalSinceNow];
    //单位秒
    return timeDiff;
}

//获取时间差
+ (NSInteger)mxGetChaTimeDiff:(NSString*)timeS timeE:(NSString*)timeE{
    NSInteger timeDiff = 0;
    NSDateFormatter *formatters = [[NSDateFormatter alloc]init];
    [formatters setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dateS = [formatters dateFromString:timeS];
    NSDateFormatter *formatterE = [[NSDateFormatter alloc]init];
    [formatterE setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dateE = [formatterE dateFromString:timeE];
    timeDiff = [dateE timeIntervalSinceDate:dateS ];
    //单位秒
    return timeDiff;
}


/**
 *  计算文本的宽高
 *
 *  @param str     需要计算的文本
 *  @param font    文本显示的字体
 *  @param maxSize 文本显示的范围
 *
 *  @return 文本占用的真实宽高
 */
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}

/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width < 1080&&height<1080) {
        return sourceImage;
    }
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}



+ (NSString *)getNetworkType
{
    NSLog(@"长%f，宽%f",MY_WIDTH,MY_HEIGHT);
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKeyPath:@"statusBar"];
    NSString *network = @"";
    NSString *platform = [SurveyRunTimeData platform];
    if ([platform isEqualToString:@"iPhone X"]) {
        //        iPhone X
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                network = [subview valueForKeyPath:@"originalText"];
            }
        }
    }else {
        //        非 iPhone X
        UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [foregroundView subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                switch (networkType) {
                    case 0:
                        network = @"NONE";
                        break;
                    case 1:
                        network = @"2G";
                        break;
                    case 2:
                        network = @"3G";
                        break;
                    case 3:
                        network = @"4G";
                        break;
                    case 5:
                        network = @"WIFI";
                        break;
                    default:
                        break;
                }
            }
        }
    }
    if ([network isEqualToString:@""]) {
        network = @"NO DISPLAY";
    }
    return network;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}



@end
