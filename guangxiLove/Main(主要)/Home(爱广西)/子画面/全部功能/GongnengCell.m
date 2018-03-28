//
//  CollectionViewCell.m
//  UICollectionViewCell的移动
//
//  Created by 程金伟 on 16/7/18.
//  Copyright © 2016年 juzhi. All rights reserved.
//

#import "GongnengCell.h"

@interface GongnengCell ()



@end


@implementation GongnengCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加内部控件
        //imageview
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        //btn
        
        
        _imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake((totalWidth - 35)/2, 0, 35, 35)];
        _imageIcon.image = [UIImage imageNamed:@"icon.png"];
        [self addSubview:_imageIcon];
        
        
        //lable
        _lable = [[UILabel alloc] init];
        _lable.font = [UIFont systemFontOfSize:11];
        _lable.frame = CGRectMake(0, _imageIcon.frame.origin.y + _imageIcon.frame.size.height + 4, totalWidth, 11);
//        self.layer.borderColor = [[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1] CGColor];
//        self.layer.borderWidth = 0.5f;
        self.tintColor = [UIColor redColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_lable];
        
        _btnDelete = [[ZZLButton alloc]init];
        _btnDelete.frame = CGRectMake(totalWidth-22, 0, 22, 22);
        [_btnDelete setBackgroundImage:[UIImage imageNamed:@"main_delete"] forState:UIControlStateNormal];
        [self addSubview:_btnDelete];
        
        _btnAdd = [[ZZLButton alloc]init];
        _btnAdd.frame = CGRectMake(totalWidth-22, 0, 22, 22);
        [_btnAdd setBackgroundImage:[UIImage imageNamed:@"main_add"] forState:UIControlStateNormal];
        [self addSubview:_btnAdd];
        
        _btnYitianjia = [[ZZLButton alloc]init];
        _btnYitianjia.frame = CGRectMake(totalWidth-22, 0, 22, 22);
        [_btnYitianjia setBackgroundImage:[UIImage imageNamed:@"main_yitianjia"] forState:UIControlStateNormal];
        [self addSubview:_btnYitianjia];
    }
    return self;
}

-(void)setCellData:(NSDictionary *)CellData{
    
}


@end
