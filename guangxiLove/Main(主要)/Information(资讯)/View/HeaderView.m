//
//  MainHeaderView.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "HeaderView.h"
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>//轮播控件

@interface HeaderView()<BHInfiniteScrollViewDelegate>
{
    
}

@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title downloads:(NSString *)downloads descripe:(NSString *)descripe {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        /*
         广告条初始化
         */
        //**********************
       BHInfiniteScrollView *actScrollView =  [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, 320 * BILI_m, 170  * BILI_375) Delegate:self ImagesArray:@[[UIImage imageNamed:kPLACEHOLDER_IMAGE],[UIImage imageNamed:kPLACEHOLDER_IMAGE]]];
        actScrollView.dotSize = 7;
        actScrollView.pageViewContentMode = UIViewContentModeScaleToFill;
        actScrollView.dotColor = [UIColor redColor];
        actScrollView.placeholderImage = [UIImage imageNamed:kPLACEHOLDER_IMAGE];
        actScrollView.dotSpacing = 10;
        actScrollView.pageControlAlignmentOffset = CGSizeMake(0, 10);
        [self addSubview:actScrollView];
        
        // 分栏器
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"政务问答", @"城市新闻",@"市民热议"]];
        self.segmentedControl.selectedSegmentIndex = 0;
        self.segmentedControl.selected = YES;
        self.segmentedControl.tintColor = [UIColor grayColor];
        [self addSubview:self.segmentedControl];
        
        CGFloat segmentControlWidthScale = 8 / 10.0;
        [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
//            make.top.equalTo(actScrollView.mas_bottom).mas_equalTo(-44);
            make.top.equalTo(actScrollView.mas_bottom).with.offset(10);
            make.width.mas_equalTo(self.width*segmentControlWidthScale);
        }];
        
        // 底边线
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, self.height-1, self.width, 1);
        line.backgroundColor = [UIColor grayColor].CGColor;
        [self.layer addSublayer:line];
    }
    return self;
}

/// 初始化一个UILabel
- (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    [label sizeToFit];
    return  label;
}

@end
