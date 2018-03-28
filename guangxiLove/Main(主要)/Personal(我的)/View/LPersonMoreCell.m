//
//  LPersonMoreCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/20.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LPersonMoreCell.h"

@interface LPersonMoreCell (){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *PImV;
@property (weak, nonatomic) IBOutlet UILabel *PLabel;

@end

@implementation LPersonMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setNameStr:(NSString *)nameStr{
    _PLabel.text = nameStr;
    if ([nameStr isEqualToString:@"我的主页"]) {
        [_PImV setImage:[UIImage imageNamed:@"per_home"]];
    }else if ([nameStr isEqualToString:@"收藏"]){
        [_PImV setImage:[UIImage imageNamed:@"per_shoucang"]];
    }else if ([nameStr isEqualToString:@"订单"]){
        [_PImV setImage:[UIImage imageNamed:@"per_order"]];
    }else if ([nameStr isEqualToString:@"设置"]){
        [_PImV setImage:[UIImage imageNamed:@"per_set"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
