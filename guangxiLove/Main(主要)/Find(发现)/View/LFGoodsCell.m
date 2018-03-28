//
//  LFGoodsCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/19.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LFGoodsCell.h"

@interface LFGoodsCell ()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
@property (weak, nonatomic) IBOutlet UIImageView *RightImage;

@end


@implementation LFGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic{
    [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"#eeeeee"]];
    [_leftImage setFrame:CGRectMake(0, 0, 375.0f/2 * BILI_375-0.5, 200 * BILI_375 - 1)];
    [_RightImage setFrame:CGRectMake(_leftImage.right+1, 0, 375.0f/2 * BILI_375-0.5, 200 * BILI_375 - 1)];
    [_leftImage setImage:[UIImage imageNamed:@"LF_goods1"]];
    [_RightImage setImage:[UIImage imageNamed:@"LF_goods2"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
