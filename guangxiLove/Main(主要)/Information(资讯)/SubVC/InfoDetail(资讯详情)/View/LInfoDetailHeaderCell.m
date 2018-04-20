//
//  LInfoDetailHeaderCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/4/13.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LInfoDetailHeaderCell.h"

@interface LInfoDetailHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *pinglunLabel;
@end

@implementation LInfoDetailHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
