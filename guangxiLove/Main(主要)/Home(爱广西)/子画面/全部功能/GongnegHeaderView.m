//
//  GongnegHeaderView.m
//  ZHSQ
//
//  Created by 赵中良 on 2017/5/22.
//  Copyright © 2017年 lacom. All rights reserved.
//

#import "GongnegHeaderView.h"

@interface GongnegHeaderView ()
@property (nonatomic,strong)UILabel *Namelabel;

@end

@implementation GongnegHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加内部控件
        //imageview
        CGFloat totalWidth = self.frame.size.width;
        CGFloat totalHeight = self.frame.size.height;
        
        //lable
       
        
    }
    return self;
}

-(void)setNameStr:(NSString *)nameStr{
    if (!_Namelabel) {
        _Namelabel = [[UILabel alloc] init];
        _Namelabel.font = [UIFont systemFontOfSize:14];
        _Namelabel.frame = CGRectMake(10, 20, 100, 14);
        [self addSubview:_Namelabel];
    }
    _Namelabel.text = nameStr;
}

@end
