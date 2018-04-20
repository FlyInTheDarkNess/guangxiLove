//
//  storeReplyFrame.m
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import "infoReplyFrame.h"

#define YYNameFont [UIFont systemFontOfSize:15]

#define textFont [UIFont systemFontOfSize:14]

@implementation infoReplyFrame

-(void)setReplyData:(infoReplyModel *)replyData{
    _replyData = replyData;
    
    //1.设置评论者头像frame
    CGFloat padding=10;
    CGFloat iconViewX=15;
    CGFloat iconViewY= 20;
    CGFloat iconViewW= 20;
    CGFloat iconViewH= 20;
    
    self.iconViewF=CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    self.VimgVF = CGRectMake(iconViewX + iconViewW * 3 / 4, iconViewY + iconViewH *3/4, iconViewW / 4, iconViewH /4);
    
    //设置评论者昵称frame
    CGFloat nameLabelX=CGRectGetMaxX(self.iconViewF)+15;
    self.nameLabelF = CGRectMake(nameLabelX, 20, 150, 20);
    
    //点赞按钮frame
    CGFloat zanBtnX = MY_WIDTH - 15 - 80;
    CGFloat zanBtnY = 20;
    self.zanBtnF = CGRectMake(zanBtnX, zanBtnY, 80, 12);

    //设置评论内容
    CGFloat contentY = CGRectGetMaxY(self.iconViewF)+15;
    CGFloat contentX = 15;
    CGSize ruleSize=[self sizeWithString:_replyData.feedback_content font:textFont maxSize:CGSizeMake(MY_WIDTH - 15 - contentX,MAXFLOAT)];
    self.replyLabelF = CGRectMake(contentX, contentY, ruleSize.width , ruleSize.height);
    
    
    //设置评论时间frame
    CGFloat fanxianY = CGRectGetMaxY(self.replyLabelF)+10;
    CGFloat fanxianLabelX = 15;
    self.timeLabelF = CGRectMake(fanxianLabelX, fanxianY, MY_WIDTH - fanxianLabelX - 20, 12);
    
    
    self.bottomViewF = CGRectMake(15, CGRectGetMaxY(self.timeLabelF) + 15, MY_WIDTH, 1);
    
    self.cellHight = CGRectGetMaxY(self.bottomViewF);
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
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size =  [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}



@end
