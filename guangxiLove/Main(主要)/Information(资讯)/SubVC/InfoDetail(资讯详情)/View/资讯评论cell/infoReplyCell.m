//
//  storeReplyCell.m
//  ZHSQ
//
//  Created by 赵中良 on 16/1/25.
//  Copyright © 2016年 lacom. All rights reserved.
//

#import "infoReplyCell.h"
#import "infoReplyFrame.h"
#import "infoReplyModel.h"
#import "UIImageView+WebCache.h"

#define TitleFont [UIFont systemFontOfSize:15]

#define textFont [UIFont systemFontOfSize:14]

@interface infoReplyCell ()

/**
 *评论者头像
 **/
@property(nonatomic,weak)UIImageView *iconView;

/**
 *评论者昵称
 **/
@property(nonatomic,weak)UILabel *nameLabel;

/**
 *加v图标
 **/
@property(nonatomic,weak)UIImageView *VimgV;


/**
 *评分label
 **/
@property(nonatomic,weak)UILabel *scoreLabel;


/**
 *评论时间label
 **/
@property(nonatomic,weak)UILabel *timeLabel;

/**
 *返现钱数
 **/
@property(nonatomic,weak)UILabel *returnRMBLabel;

/**
 *评论内容
 **/
@property(nonatomic,weak)UILabel *replyLabel;

/**
 *点赞按钮
 **/
@property(nonatomic,weak)UIButton *zanBtn;

/**
 *评论内容
 **/
@property(nonatomic,weak)UIView *bottomView;

@end

@implementation infoReplyCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //1.添加评论者头像
        {
            UIImageView *img=[[UIImageView alloc]init];
            [self.contentView addSubview:img];
            self.iconView=img;
            //设置按钮边框
            {
                CALayer *layer = [self.iconView layer];
                layer.masksToBounds = YES;
                layer.cornerRadius = 10.0f;
                [layer setMasksToBounds:YES];
//                layer.borderWidth = 0.5f;
//                layer.borderColor = [[UIColor redColor] CGColor];
            }
            self.iconView.userInteractionEnabled = YES;
            // 单击的 Recognizer
            UITapGestureRecognizer* singleRecognizer;
            singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
            //点击的次数
            [singleRecognizer setNumberOfTouchesRequired:1];
            singleRecognizer.numberOfTapsRequired = 1;
            
            //给self.view添加一个手势监测；
            [self.iconView addGestureRecognizer:singleRecognizer];
        }
        
        //加v图标
        {
            UIImageView *img=[[UIImageView alloc]init];
            [self.contentView addSubview:img];
            self.VimgV=img;
        }
        
        //点赞按钮
        {
            UIButton *btn=[[UIButton alloc]init];
            [btn setTitleColor:[UIColor colorWithHexString:@"#8e8e8e"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.contentView addSubview:btn];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            self.zanBtn = btn;
        }

        
        //2.添加评论者昵称
        {
            UILabel *namelab=[[UILabel alloc]init];
            //在创建昵称的时候就要告诉它，将来要用15号字体显示
            namelab.font= [UIFont systemFontOfSize:12];
            namelab.textColor = [UIColor colorWithHexString:@"#222222"];
            [self.contentView addSubview:namelab];
            self.nameLabel=namelab;
        }
        
        
        //3.添加评论时间label
        {
            UILabel *fanxianlab=[[UILabel alloc]init];
            fanxianlab.font = [UIFont systemFontOfSize:12];
            fanxianlab.textAlignment = NSTextAlignmentLeft;
            fanxianlab.textColor = [UIColor colorWithHexString:@"#8e8e8e"];
            [self.contentView addSubview:fanxianlab];
            self.timeLabel=fanxianlab;
        }
        
        
        //4.添加返现钱数
        {
            UILabel *julilab=[[UILabel alloc]init];
            julilab.font=textFont;
            julilab.textAlignment = NSTextAlignmentRight;
            julilab.textColor = [UIColor grayColor];
            [self.contentView addSubview:julilab];
            self.returnRMBLabel=julilab;
        }
        
        //5.添加评分label
        {
            UILabel *julilab=[[UILabel alloc]init];
            julilab.font=TitleFont;
            julilab.textColor = [UIColor redColor];
            [self.contentView addSubview:julilab];
            self.scoreLabel=julilab;
            self.scoreLabel.hidden = YES;
        }
        //6.添加评论内容
        {
            UILabel *julilab=[[UILabel alloc]init];
            julilab.font=textFont;
            julilab.numberOfLines = 0;
            julilab.textColor = [UIColor colorWithHexString:@"#222222"];
            [self.contentView addSubview:julilab];
            self.replyLabel=julilab;
        }
        //11.添加黑条
        {
            UIView *view = [[UIView alloc]init];
            [self.contentView addSubview:view];
            view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.bottomView=view;
        }
    }
    return self;
}

-(void)setReplyFrame:(infoReplyFrame *)replyFrame{
    
    _replyFrame = replyFrame;
    //给子控件赋值数据
    [self settingData];
    //设置子控件的frame
    [self settingFrame];
}

-(void)settingData{
    
    NSString *itemIcon = [_replyFrame.replyData.icon_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
//    [self.iconView setImageWithURL:[NSURL URLWithString:itemIcon]
//              placeholderImage:[UIImage imageNamed:@"user_icon"]
//                       options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
//   usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.iconView setImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]];
//    [self.iconView sd_setImageWithURL:<#(nullable NSURL *)#> placeholderImage:<#(nullable UIImage *)#> options:<#(SDWebImageOptions)#>
//     sd_setImageWithURL:[NSURL URLWithString:itemIcon] placeholderImage:[UIImage imageNamed:@"user_icon"] options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
//          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.nameLabel.text = _replyFrame.replyData.feedback_content;
    self.nameLabel.text = _replyFrame.replyData.nickname;
    self.timeLabel.text = _replyFrame.replyData.Feedback_time;
    
    if ([_replyFrame.replyData.isvip isEqualToString:@"1"]) {
        self.VimgV.hidden = NO;
        NSString *itemIcon = [_replyFrame.replyData.vipicon_path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
        
//        [self.VimgV setImageWithURL:[NSURL URLWithString:itemIcon]
//                   placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
//                            options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
//        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }else{
        self.VimgV.hidden = YES;
    }

//    if ([_replyFrame.replyData.money_count integerValue]>100) {
//    self.returnRMBLabel.text = [NSString stringWithFormat:@"赚到%.2f元",[_replyFrame.replyData.money_count floatValue]];
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"赚到%.2f元",[_replyFrame.replyData.money_count floatValue]]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2,_replyFrame.replyData.money_count.length)];
        self.returnRMBLabel.attributedText = str;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f",[_replyFrame.replyData.feedback_star floatValue]];
    float score = [_replyFrame.replyData.feedback_star floatValue];
    
    self.replyLabel.text = _replyFrame.replyData.feedback_content;
    
    [self.zanBtn setImage:[UIImage imageNamed:@"info_zan_gray"] forState:UIControlStateNormal];
    [self.zanBtn setTitle:@"1234" forState:UIControlStateNormal];
}

-(void)settingFrame{
    self.iconView.frame = _replyFrame.iconViewF;
    self.nameLabel.frame = _replyFrame.iconViewF;
    self.nameLabel.frame = _replyFrame.nameLabelF;
    self.timeLabel.frame = _replyFrame.timeLabelF;
    self.returnRMBLabel.frame = _replyFrame.returnRMBLabelF;
    self.replyLabel.frame = _replyFrame.replyLabelF;
    self.bottomView.frame = _replyFrame.bottomViewF;
    self.VimgV.frame = _replyFrame.VimgVF;
    self.zanBtn.frame = _replyFrame.zanBtnF;
}



- (void)awakeFromNib {
    // Initialization code
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
//    [_bringDelegate bringWithItemId:_replyFrame.replyData.userid Type:1];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
