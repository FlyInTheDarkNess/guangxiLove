//
//  LFHeaderCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/19.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LFHeaderCell.h"

@interface LFHeaderCell()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *LeftTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *RightTopImage;
@property (weak, nonatomic) IBOutlet UIImageView *FirstImage;
@property (weak, nonatomic) IBOutlet UIImageView *SecondImage;
@property (weak, nonatomic) IBOutlet UIImageView *ThirdImage;
@property (weak, nonatomic) IBOutlet UILabel *FirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *ThirdLabel;
@property (weak, nonatomic) IBOutlet UIView *BackGV;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
@implementation LFHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)Dic{
    [_BackGV setFrame:CGRectMake(15 *BILI_375, 5, 345 * BILI_375, 203 *BILI_375)];
    _BackGV.backgroundColor = [UIColor whiteColor];
    //设置边框
    {
        CALayer *layer = [_BackGV layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 5.0f;
        [layer setMasksToBounds:YES];
//        layer.borderWidth = 0.5f;
//        layer.borderColor = [[UIColor grayColor] CGColor];
    }
    [_LeftTopImage setFrame:CGRectMake(0, 0, 196 *BILI_375, 100*BILI_375)];
    [_RightTopImage setFrame:CGRectMake(_LeftTopImage.right + 3*BILI_375, 0, 146 *BILI_375, 100*BILI_375)];
    [_FirstImage setFrame:CGRectMake(0, _LeftTopImage.bottom + 3*BILI_375, 113 *BILI_375, 100*BILI_375)];
    [_SecondImage setFrame:CGRectMake(_FirstImage.right + 3*BILI_375, _LeftTopImage.bottom + 3*BILI_375, 113 *BILI_375, 100*BILI_375)];
    [_ThirdImage setFrame:CGRectMake(_SecondImage.right + 3*BILI_375, _LeftTopImage.bottom + 3*BILI_375, 113 *BILI_375, 100*BILI_375)];
    
    [_FirstLabel setFrame:CGRectMake(15*BILI_375, _BackGV.bottom + 10*BILI_375, 113 *BILI_375, 11)];
    [_SecondLabel setFrame:CGRectMake(_FirstLabel.right + 3*BILI_375, _BackGV.bottom + 10*BILI_375, 113 *BILI_375, 11)];
    [_ThirdLabel setFrame:CGRectMake(_SecondLabel.right + 3*BILI_375, _BackGV.bottom + 10*BILI_375, 113 *BILI_375, 11)];
    _FirstLabel.font = [UIFont systemFontOfSize:11];
    _SecondLabel.font = [UIFont systemFontOfSize:11];
    _ThirdLabel.font = [UIFont systemFontOfSize:11];
    NSLog(@"%f:%f:%f:%f",_FirstLabel.left,_FirstLabel.top,_FirstLabel.width,_FirstLabel.height);
    _FirstLabel.textColor  =[UIColor colorWithHexString:@"#222222"];
    _SecondLabel.textColor  =[UIColor colorWithHexString:@"#222222"];
    _ThirdLabel.textColor  =[UIColor colorWithHexString:@"#222222"];
    
    _LeftTopImage.image = [UIImage imageNamed:@"left1"];
    _RightTopImage.image = [UIImage imageNamed:@"right2"];
    _FirstImage.image = [UIImage imageNamed:@"top1"];
    _SecondImage.image = [UIImage imageNamed:@"top2"];
    _ThirdImage.image = [UIImage imageNamed:@"top3"];
    _FirstLabel.text = @"漓江";
    _SecondLabel.text = @"鼻象山";
    _ThirdLabel.text = @"龙脊梯田";
    
    _bottomLabel.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    _bottomLabel.text = @"";
    [_bottomLabel setFrame:CGRectMake(0, 213 *BILI_375 + 31, MY_WIDTH, 15)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
