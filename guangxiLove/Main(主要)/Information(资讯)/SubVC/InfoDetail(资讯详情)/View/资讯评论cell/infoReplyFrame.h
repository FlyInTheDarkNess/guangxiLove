//
//  storeReplyFrame.h
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "infoReplyModel.h"

@interface infoReplyFrame : NSObject

/**
 *评论者头像
 **/
@property(nonatomic,assign)CGRect iconViewF;



/**
 *加v图标
 **/
@property(nonatomic,assign)CGRect VimgVF;

/**
 *点赞按钮
 **/
@property(nonatomic,assign)CGRect zanBtnF;

/**
 *评论者昵称
 **/
@property(nonatomic,assign)CGRect nameLabelF;

/**
 *评论时间label
 **/
@property(nonatomic,assign)CGRect timeLabelF;

/**
 *返现钱数
 **/
@property(nonatomic,assign)CGRect returnRMBLabelF;

/**
 *评论内容
 **/
@property(nonatomic,assign)CGRect replyLabelF;

/**
 *底部灰条
 **/
@property(nonatomic,assign)CGRect bottomViewF;

/**
 *行高
 **/
@property(nonatomic,assign)CGFloat cellHight;

/**
 *e家数据
 **/
@property(nonatomic,strong)infoReplyModel *replyData;

@end
