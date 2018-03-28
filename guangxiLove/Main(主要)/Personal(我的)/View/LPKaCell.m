//
//  LPKaCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/20.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LPKaCell.h"

@interface LPKaCell ()
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *CardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *countlabel;
@property (weak, nonatomic) IBOutlet UIImageView *nextImV;
@property (weak, nonatomic) IBOutlet UIButton *FirstBtn;
@property (weak, nonatomic) IBOutlet UIButton *SecondBtn;
@property (weak, nonatomic) IBOutlet UIButton *ThirdBtn;

@end

@implementation LPKaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)dic{
    
    //设置按钮边框
    {
        _FirstBtn.backgroundColor = [UIColor colorWithHexString:@"#21de5f"];
        [_FirstBtn setFrame:CGRectMake(15, self.contentView.height - 40*BILI_375, 120*BILI_375, 50 *BILI_375)];
        [_FirstBtn setTitle:@"身份证" forState:UIControlStateNormal];
        [_FirstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 50)];
        [_FirstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _FirstBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        CALayer *layer = [_FirstBtn layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0f;
        [layer setMasksToBounds:YES];
    }
    
    //设置按钮边框
    {
        _SecondBtn.backgroundColor = [UIColor colorWithHexString:@"#19a0e5"];
        [_SecondBtn setFrame:CGRectMake(_FirstBtn.right + 15, self.contentView.height - 40*BILI_375, 120*BILI_375, 50 *BILI_375)];
        [_SecondBtn setTitle:@"驾驶证" forState:UIControlStateNormal];
        [_SecondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 50)];
        [_SecondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _SecondBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        CALayer *layer = [_SecondBtn layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0f;
        [layer setMasksToBounds:YES];
    }
    //设置按钮边框
    {
        _ThirdBtn.backgroundColor = [UIColor colorWithHexString:@"#fbd22c"];
        [_ThirdBtn setFrame:CGRectMake(_SecondBtn.right + 15, self.contentView.height - 40*BILI_375, 120*BILI_375, 50 *BILI_375)];
        [_ThirdBtn setTitle:@"社保卡" forState:UIControlStateNormal];
        [_ThirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 50)];
        [_ThirdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ThirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        CALayer *layer = [_ThirdBtn layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0f;
        [layer setMasksToBounds:YES];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
