//
//  IFMQCell.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/20.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "IFMQCell.h"


@interface IFMQCell ()
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *IFMQImageV;


@end

@implementation IFMQCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDic:(NSDictionary *)Dic{
    NSString *imageName = [NSString stringWithFormat:@"%@",Dic[@"image"]];
    _IFMQImageV.image = [UIImage imageNamed:imageName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
