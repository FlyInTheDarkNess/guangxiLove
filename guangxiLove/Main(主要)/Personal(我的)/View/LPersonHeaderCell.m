//
//  LPersonHeaderCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/20.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LPersonHeaderCell.h"

@interface LPersonHeaderCell ()

@property (weak, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *RenzhengImV;
@property (weak, nonatomic) IBOutlet UILabel *RenzhengLabel;
@property (weak, nonatomic) IBOutlet UIImageView *IconIMV;
@property (weak, nonatomic) IBOutlet UIImageView *NextImV;

@end

@implementation LPersonHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDic:(NSDictionary *)Dic{
    _NickNameLabel.text = @"发横财";
    _IconIMV.image = [UIImage imageNamed:@"avater"];
    //设置按钮边框
    {
        CALayer *layer = [_IconIMV layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = _IconIMV.width/2;
        [layer setMasksToBounds:YES];
        layer.borderWidth = 0.5f;
        layer.borderColor = [[UIColor colorWithHexString:@"#eeeeee"] CGColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
