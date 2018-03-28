//
//  HomeTableViewCell.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/31.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong) NSDictionary *cellData;//每条资讯的内容
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;



@end
