//
//  HomeTableViewCell.m
//  ZHSQ
//
//  Created by 赵中良 on 15/3/31.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imagView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLine;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setSeparatorInset:UIEdgeInsetsZero];
//    NSLog(@"主页资讯cell awakeFromNib：%@",_cellData);
    
}

- (void)setCellData:(NSDictionary *)cellData{
//    NSLog(@"主页资讯cell 加载%@",cellData);
    NSString *imageUrl = [[cellData objectForKey:@"pic"][0] objectForKey:@"thumbs_url"];
    NSString *itemImageUrl = [NSString stringWithFormat:@"%@",cellData[@"article_item_icon"]];
    NSString *title = [NSString stringWithFormat:@"%@",cellData[@"article_item_name"]];
    //时间
    NSString *stringTime =[NSString stringWithFormat:@"%@",cellData[@"article_date"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:stringTime];
    [formatter setDateFormat:@"MM/dd"];
    NSString *locationString=[formatter stringFromDate:dateTime];
    NSString *summary = [NSString stringWithFormat:@"%@",cellData[@"title"]];
    /*
     设置图片加载方式
     */
    //*************************
//    if (imageUrl.length > 0) {
//        NSString *itemIcon = [imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
//        [_imagView sd_setImageWithURL:[NSURL URLWithString:itemIcon] placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE] options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder];
//    }else{
//        NSString *itemIcon = [itemImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
//        [_imagView sd_setImageWithURL:[NSURL URLWithString:itemIcon] placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE] options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder];
//    }
    
    //*************************
    
    _imagView.contentMode = UIViewContentModeScaleAspectFill;
    _imagView.clipsToBounds = YES;
    _numberLabel.layer.cornerRadius = 7.5f;
    _numberLabel.layer.masksToBounds = YES;
//    _timeLabel.text = locationString;
    
//    _contentLabel.text = summary;
    _contentLabel.textColor = [UIColor colorWithHexString:@"9e9e9e"];
//    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor colorWithHexString:@"444444"];
    _timeLabel.textColor = [UIColor colorWithHexString:@"9e9e9e"];
    
    NSString *titleStr = [NSString stringWithFormat:@"%@",cellData[@"title"]];
    NSString *imageStr = [NSString stringWithFormat:@"%@",cellData[@"image"]];
    _titleLabel.text = titleStr;
    [_imagView setImage:[UIImage imageNamed:imageStr]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
