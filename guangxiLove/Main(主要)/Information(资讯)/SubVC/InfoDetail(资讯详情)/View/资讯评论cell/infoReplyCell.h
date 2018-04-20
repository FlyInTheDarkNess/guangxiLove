//
//  storeReplyCell.h
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@class infoReplyFrame,infoReplyModel;
@interface infoReplyCell : UITableViewCell

@property(nonatomic,strong)infoReplyFrame *replyFrame;

@property(nonatomic,weak) id <bringDelegate>bringDelegate;

@end
