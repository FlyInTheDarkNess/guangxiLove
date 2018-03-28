//
//  CollectionViewCell.h
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZLButton.h"

@interface GongnengCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *lable;
@property (nonatomic,strong)ZZLButton *btnDelete;
@property (nonatomic,strong)ZZLButton *btnAdd;
@property (nonatomic,strong)ZZLButton *btnYitianjia;
@property (nonatomic,weak) NSDictionary *CellData;
@property(nonatomic,strong)UIImageView *imageIcon;
@end
