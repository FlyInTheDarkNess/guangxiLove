//
//  UserInfo.m
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "UserInfo.h"
#import "NSString+SringNull.h"

@implementation UserInfo
@synthesize roomLV;

-(id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr Session:(NSString *)Session{
    if (self = [super init]) {
        _personArr = PersonArr;
        NSLog(@"%@",PersonArr);
        _carArr = CarArr;
        _jdhArr = JdhArr;
        _addressArr = AddressArr;
        if (PersonArr.count > 0) {
            NSDictionary *userDic = PersonArr[0];
            _name = [NSString stringWithFormat:@"%@",userDic[@"name"]];
            _sex = [NSString stringWithFormat:@"%@",userDic[@"sex"]];
            _rank = [NSString stringWithFormat:@"%@",userDic[@"rank"]];
            _icon_path = [NSString stringWithFormat:@"%@",userDic[@"icon_path"]];
            _email = [NSString stringWithFormat:@"%@",userDic[@"email"]];
            _idnumber = [NSString stringWithFormat:@"%@",userDic[@"idnumber"]];
            _mobile_phone = [NSString stringWithFormat:@"%@",userDic[@"mobile_phone"]];
            _imei = [NSString stringWithFormat:@"%@",userDic[@"imei"]];
            _userId = [NSString stringWithFormat:@"%@",userDic[@"id"]];
            _nickName = [NSString stringWithFormat:@"%@",userDic[@"nickname"]];
            _memberLevel = [NSString stringWithFormat:@"%@",userDic[@"memlevel"]];
            _jfCount = [NSString stringWithFormat:@"%@",userDic[@"jf1"]];
        }
        AddressInfo *address;
        if (_addressArr.count > 0) {
            NSDictionary *dic = _addressArr[0];
            address = [[AddressInfo alloc]initWithAddress_id:dic[@"address_id"] City_id:dic[@"city_id"] City_name:dic[@"city_name"] Area_id:dic[@"area_id"] Area_name:dic[@"area_name"] Agency_id:dic[@"agency_id"] Agency_name:dic[@"agency_name"] Community_id:dic[@"community_id"] Community_name:dic[@"community_name"] Quarter_id:dic[@"quarter_id"] Quarter_name:dic[@"quarter_name"] Building_id:dic[@"building_id"] Building_name:dic[@"building_name"] Unit_id:dic[@"unit_id"] Unit_name:dic[@"unit_name"] Room_id:dic[@"room_id"] Room_name:dic[@"room_name"] Isdefaultshow:dic[@"isdefaultshow"] Charge_mode:dic[@"charge_mode"] Entity_class:dic[@"entity_class"]];
        }
        _currentAddress = address;
        _session = Session;
        _latitude = @"0";
        _longitude = @"0";
        
    }
    return self;
}

- (id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr ModuleArr:(NSArray *)ModuleArr Session:(NSString *)Session{
    if (self = [self initWithPersonArr:PersonArr CarArr:CarArr JdhArr:JdhArr AddressArr:AddressArr Session:Session]) {
        _moduleArr = [NSArray arrayWithArray:ModuleArr];
    }
    return self;
}

- (id)initWithDic:(NSDictionary *)requstDic{
    NSArray *person = [requstDic objectForKey:@"person_info"];
    NSArray *car_info = [requstDic objectForKey:@"car_info"];
    NSArray *jdh_info = [requstDic objectForKey:@"jdh_info"];
    NSArray *address_info = [requstDic objectForKey:@"address_info"];
    NSLog(@"地址详情：%@",address_info);
    NSArray *module_info = [requstDic objectForKey:@"module_info"];
    NSDictionary *pay_infoDic = [requstDic objectForKey:@"pay_info"];
    NSArray *authority = [requstDic objectForKey:@"authority"];
    NSLog(@"权限：%@",authority);
    _authority_status = @"";
    if (authority.count > 0) {
        NSDictionary *authoritydic =authority[0];
        NSString *authority_status = [NSString stringWithFormat:@"%@",authoritydic[@"authority_status"]];
        NSLog(@"权限：%@",authority_status);
        if ([authority_status isEmpty]) {
            _authority_status =authority_status;
        }
    }
    
    if (self = [self initWithPersonArr:person CarArr:car_info JdhArr:jdh_info AddressArr:address_info ModuleArr:module_info Session:[requstDic objectForKey:@"session"]]) {
        
        _latitude = @"0";
        _longitude = @"0";
        
    }
    return self;
}


//- (AddressInfo *)currentAddress{
//    AddressInfo *address;
//    if (_addressArr.count > 0) {
//        for (NSDictionary *dic in _addressArr) {
//            NSString *isdefaultshow = [NSString stringWithFormat:@"%@",dic[@"isdefaultshow"]];
//            if ([isdefaultshow isEqualToString:@"1"]) {
//                address = [[AddressInfo alloc]initWithAddress_id:dic[@"address_id"] City_id:dic[@"city_id"] City_name:dic[@"city_name"] Area_id:dic[@"area_id"] Area_name:dic[@"area_name"] Agency_id:dic[@"agency_id"] Agency_name:dic[@"agency_name"] Community_id:dic[@"community_id"] Community_name:dic[@"community_name"] Quarter_id:dic[@"quarter_id"] Quarter_name:dic[@"quarter_name"] Building_id:dic[@"building_id"] Building_name:dic[@"building_name"] Unit_id:dic[@"unit_id"] Unit_name:dic[@"unit_name"] Room_id:dic[@"room_id"] Room_name:dic[@"room_name"] Isdefaultshow:dic[@"isdefaultshow"] Charge_mode:dic[@"charge_mode"]];
//                break;
//            }
//        }
//    }
//    return address;
//}

-(id)init{
    self = [super init];
    _session = @"";
    return self;
}




@end
