//
//  storeReplyModel.h
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoReplyModel : NSObject

/**
 *  笑脸e家评论id
 */
@property(nonatomic,copy)NSString *feedback_id;

/**
 *  笑脸e家评论内容
 */
@property(nonatomic,copy)NSString *feedback_content;

/**
 *  笑脸e家星级评价
 */
@property(nonatomic,copy)NSString *feedback_star;

/**
 *  笑脸e家评论时间
 */
@property(nonatomic,copy)NSString *Feedback_time;

/**
 *  笑脸e家评论者id
 */
@property(nonatomic,copy)NSString *userid;

/**
 *  笑脸e家评论者昵称
 */
@property(nonatomic,copy)NSString *nickname;

/**
 *  笑脸e家评论者姓名
 */
@property(nonatomic,copy)NSString *username;


/**
 *  笑脸e家评论者性别
 */
@property(nonatomic,copy)NSString *sex;


/**
 *  笑脸e家评论者头像地址
 */
@property(nonatomic,copy)NSString *icon_path;

/**
 *  赚得钱数
 */
@property(nonatomic,copy)NSString *money_count;

/**
 *  是否加v
 */
@property(nonatomic,copy)NSString *isvip;

/**
 *  v图标地址
 */
@property(nonatomic,copy)NSString *vipicon_path;




-(instancetype)initWithDict:(NSDictionary *)dict;

-(instancetype)initWithModelData;

@end
