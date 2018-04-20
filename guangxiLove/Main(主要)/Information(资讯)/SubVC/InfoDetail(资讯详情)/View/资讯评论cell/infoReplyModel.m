//
//  storeReplyModel.m
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import "infoReplyModel.h"

@implementation infoReplyModel


//还差赚钱属性
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSString *feedback_id = [NSString stringWithFormat:@"%@",dict[@"feedback_id"]];
        NSString *feedback_content = [NSString stringWithFormat:@"%@",dict[@"feedback_content"]];
        NSString *feedback_star = [NSString stringWithFormat:@"%@",dict[@"feedback_star"]];
        NSString *feedback_time = [SurveyRunTimeData compareCurrentTime:[NSString stringWithFormat:@"%@",dict[@"feedback_time"]]];
        NSString *userid = [NSString stringWithFormat:@"%@",dict[@"userid"]];
        NSString *nickname = [NSString stringWithFormat:@"%@",dict[@"nickname"]];
        NSString *username = [NSString stringWithFormat:@"%@",dict[@"username"]];
        NSString *sex = [NSString stringWithFormat:@"%@",dict[@"sex"]];
        NSString *icon_path = [NSString stringWithFormat:@"%@",dict[@"icon_path"]];
        NSString *money_count = [NSString stringWithFormat:@"%@",dict[@"return_cash_total"]];
        NSString *isvip = [NSString stringWithFormat:@"%@",dict[@"isvip"]];
        NSString *vipicon_path = [NSString stringWithFormat:@"%@",dict[@"vipicon_path"]];
        _isvip = [SurveyRunTimeData changeWithString:isvip];
        _vipicon_path = [SurveyRunTimeData changeWithString:vipicon_path];

        _money_count = [SurveyRunTimeData changeWithString:money_count];
        _feedback_id = [SurveyRunTimeData changeWithString:feedback_id];
        _feedback_content = [SurveyRunTimeData changeWithString:feedback_content];
        _feedback_star = [SurveyRunTimeData changeWithString:feedback_star];
        _Feedback_time = [SurveyRunTimeData changeWithString:feedback_time];
        _userid = [SurveyRunTimeData changeWithString:userid];
        _nickname = [SurveyRunTimeData changeWithString:nickname];
        _username = [SurveyRunTimeData changeWithString:username];
        _sex = [SurveyRunTimeData changeWithString:sex];
        _icon_path = [SurveyRunTimeData changeWithString:icon_path];
    }
    return self;
}

-(instancetype)initWithModelData{
    if (self = [super init]) {
        NSString *feedback_id = [NSString stringWithFormat:@"%@",@"12"];
        NSString *feedback_content = [NSString stringWithFormat:@"%@",@"很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢很喜欢"];
        NSString *feedback_star = [NSString stringWithFormat:@"%@",@"sjdkf"];
        NSString *Feedback_time = [NSString stringWithFormat:@"%@",@"一分钟前 · 7回复"];
        NSString *userid = [NSString stringWithFormat:@"%@",@"123"];
        NSString *nickname = [NSString stringWithFormat:@"%@",@"翱翔暗夜"];
        NSString *username = [NSString stringWithFormat:@"%@",@"赵中良"];
        NSString *sex = [NSString stringWithFormat:@"%@",@"男"];
        NSString *icon_path = [NSString stringWithFormat:@"%@",@"sdkjlkjlksf"];
        NSString *money_count = [NSString stringWithFormat:@"%@",@"45.00"];
        _money_count = [SurveyRunTimeData changeWithString:money_count];
        _feedback_id = [SurveyRunTimeData changeWithString:feedback_id];
        _feedback_content = [SurveyRunTimeData changeWithString:feedback_content];
        _feedback_star = [SurveyRunTimeData changeWithString:feedback_star];
        _Feedback_time = [SurveyRunTimeData changeWithString:Feedback_time];
        _userid = [SurveyRunTimeData changeWithString:userid];
        _nickname = [SurveyRunTimeData changeWithString:nickname];
        _username = [SurveyRunTimeData changeWithString:username];
        _sex = [SurveyRunTimeData changeWithString:sex];
        _icon_path = [SurveyRunTimeData changeWithString:icon_path];
    }
    return self;
}



@end
