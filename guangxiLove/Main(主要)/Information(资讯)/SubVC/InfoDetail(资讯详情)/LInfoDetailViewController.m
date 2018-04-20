 //
//  LInfoDetailViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/28.
//  Copyright © 2018年 赵中良. All rights reserved.
//
#define viewSize self.view.frame.size
#define viewWidth viewSize.width
#define viewHeight viewSize.height

#import "LInfoDetailViewController.h"
#import "LInfoDetailHeaderCell.h" //评论Header
#import "infoReplyCell.h"   //评论cell
#import "infoReplyFrame.h"
#import "infoReplyModel.h"


@interface LInfoDetailViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UIScrollView *tableHeadView; //
    
    BOOL isRefresh;
}

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation LInfoDetailViewController
@synthesize IsWeb;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    IsWeb = NO;
    
    

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //注册cell
    [tableView registerNib:[UINib nibWithNibName:@"LInfoDetailHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LInfoDetailHeaderCell"];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    if (IsWeb) {
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = self.view.bounds;
        webView.delegate = self;
        webView.scrollView.delegate = self;
        webView.scrollView.bounces = NO;
        webView.backgroundColor = [UIColor redColor];
        self.webView = webView;
        tableView.tableHeaderView = webView;
        [self loadHtml];
    }else{
        tableView.tableHeaderView = [self tableHeadView];
    }
    
    isRefresh = YES;
    
}

-(UIScrollView *)tableHeadView{
    tableHeadView = nil;
    if (!tableHeadView) {
        tableHeadView = [[UIScrollView alloc]init];
        self.view.backgroundColor = [UIColor whiteColor];;
        tableHeadView.backgroundColor = [UIColor whiteColor];
        UIView *headView = [self headViewInit];
        [tableHeadView addSubview:headView];
        UIView *contentView = [self contentViewInit];
        [tableHeadView addSubview:contentView];
//        [tableHeadView addSubview:[self footViewInit]];
        [tableHeadView setFrame:CGRectMake(0, 0, MY_WIDTH, headView.frame.size.height + contentView.frame.size.height + 40)];
    }
    return tableHeadView;
}

//懒加载
-(UIView *)headView{
    if (!_headView) {
        return [self headViewInit];
    }
    return _headView;
}

//懒加载
-(UIView *)contentView{
    if (!_contentView) {
        return [self contentViewInit];
    }
    return _contentView;
}


-(UIView *)headViewInit{
    
    UIView *headView = [[UIView alloc]init];
    // 帖子是否已收藏   0:未收藏过 1:收藏过
    //        if ([detailDict[@"isfavorite"] isEqualToString:@"0"]) {
    //            ShouCang_Y_N = NO;
    //        }else if ([detailDict[@"isfavorite"] isEqualToString:@"1"]) {
    //            ShouCang_Y_N = YES;
    //        }
    //主标题
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, MY_WIDTH - 30, 100)];
    titleLab.numberOfLines = 0;
    titleLab.backgroundColor = [UIColor clearColor];
    
    titleLab.textColor = [UIColor blackColor];
    titleLab.text = @"天使载人见大山东矿机弗拉可视对讲福利卡简单来说开发";
    
    //title修改为左对齐
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = [UIFont systemFontOfSize:24];
    titleLab.textColor = [UIColor colorWithHexString:@"#444444"];
    CGSize headerSize = [titleLab boundingRectWithSize:CGSizeMake(MY_WIDTH - 30, 100)];
    NSLog(@"标题frame：%f，%f",headerSize.width ,headerSize.height );
    
    [titleLab setFrame:CGRectMake(15, 10, MY_WIDTH - 30, headerSize.height)];
    //
    
    //发布工作室
    UILabel *subTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, titleLab.frame.size.height + 20, (MY_WIDTH - 20)/2, 20)];
    subTitleLab.font = [UIFont systemFontOfSize:11];
    subTitleLab.textColor = [UIColor lightGrayColor];
    
    
    subTitleLab.backgroundColor = [UIColor clearColor];
    //判断发布人或机构是否存在
    /*
     if (detailDict[@"article_source"] && ![detailDict[@"nickname"] isEqualToString:@""])
     {
     //修改“爆“为“报” 中间添加空格】
     subTitleLab.text = [NSString stringWithFormat:@"%@",detailDict[@"nickname"]];
     }
     else
     {
     subTitleLab.text = detailDict[@"article_source"];
     }
     */
    subTitleLab.text = @"广西头条";
    [subTitleLab sizeToFit];
    
    
    UILabel *numberlabel = [[UILabel alloc]initWithFrame:CGRectMake(subTitleLab.right + 10, subTitleLab.top+1, 100, 11)];
    numberlabel.font = [UIFont systemFontOfSize:11];
    numberlabel.textColor = [UIColor colorWithHexString:@"#9e9e9e"];
    numberlabel.text = [NSString stringWithFormat:@"人气:%@",@"199999"];
    
    //发布时间
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(MY_WIDTH/2, titleLab.frame.size.height + 20, (MY_WIDTH - 30)/2, 13)];
    timeLab.font = [UIFont systemFontOfSize:11];
    
    timeLab.textColor = [UIColor lightGrayColor];
    
    timeLab.backgroundColor = [UIColor clearColor];
    timeLab.text = [SurveyRunTimeData returnUploadTime:@"2018/04/02 18:03:01"];
    timeLab.textAlignment  = NSTextAlignmentRight;
    [headView addSubview:titleLab];
    [headView addSubview:subTitleLab];
    [headView addSubview:timeLab];
    //        [headView addSubview:ImageV];
    [headView addSubview:numberlabel];
    
    [headView setFrame:CGRectMake(0, 0, MY_WIDTH, titleLab.frame.size.height + 50)];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height - 0.5, MY_WIDTH, 0.5)];
    lineView.backgroundColor = [SurveyRunTimeData colorWithHexString:@"#eeeeee"];
    [headView addSubview:lineView];
    
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}


-(UIView *)contentViewInit{
    UIView *conview;
    NSLock *writeLock = [[NSLock alloc] init];
    
    [writeLock lock];
    
    conview = [[UIView alloc]init];
    conview.backgroundColor = [UIColor clearColor];
//    NSArray *picArr = [NSArray arrayWithArray:detailDict[@"pic"]];
    NSArray *picArr = @[@"1",@"2",@"3",@"4"];
    
    float picContentHeight = 100;
    if (picArr.count != 0) {
        for (int i = 0 ; i < picArr.count; i++) {
            NSDictionary *picDict = [NSDictionary dictionary];
            __block float imageHeight = 0;
            if (1) {
                imageHeight = 180;
                UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10  + picContentHeight, MY_WIDTH - 30, imageHeight)];
                NSString *itemIcon = [@"http://mmbiz.qpic.cn/mmbiz_jpg/wFwvdkmQK8uZV8W8yBye9bbSk7Ic9a2Ff1cnJiab5vPxTzWJFQ3vG7zHyQZDu8IBUaBaK1rG1KGUPF4UUOssYMA/640?wx_fmt=jpeg&wxfrom=5&wx_lazy=1" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
                [picImageView sd_setImageWithURL:[NSURL URLWithString:itemIcon] placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (!error) {
                        imageHeight = ((MY_WIDTH - 30)/image.size.width) * image.size.height;
                        if (i == picArr.count - 1 && isRefresh) {
                            isRefresh = NO;
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.tableView setTableHeaderView:[self tableHeadView]];
                            });
                        }
                        //                        [previewArr addObject:image];
                    }
                }];
                [picImageView setFrame:CGRectMake(15, 10 + picContentHeight, MY_WIDTH - 30, imageHeight)];
                
                picImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForImageZoom:)];
                picImageView.contentMode = UIViewContentModeScaleAspectFit;
                [picImageView addGestureRecognizer:tap];
                
                [conview addSubview:picImageView];
                picImageView = nil;
                
            }
            
            //视频
            /*
             else if([detailDict[@"video_url"] length] != 0){
             imageHeight = 180;
             UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10 + picContentHeight, kViewwidth - 30, imageHeight)];
             NSString *video_pic = [NSString stringWithFormat:@"%@",detailDict[@"video_pic"]];
             if (video_pic.length > 0) {
             }
             else{
             video_pic = [NSString stringWithFormat:@"%@",detailDict[@"video_pic_thumbs"]];
             }
             NSString *itemIcon = [video_pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
             [picImageView setImageWithURL:[NSURL URLWithString:itemIcon]
             placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
             options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
             usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
             [conview addSubview:picImageView];
             
             UIImageView *videoplayImage = [[UIImageView alloc]initWithFrame:CGRectMake(picImageView.frame.size.width / 2 - 24, picImageView.frame.size.height / 2 - 24, 48, 48)];
             [videoplayImage setImage:[UIImage imageNamed:@"videoplay0523"] ];
             [picImageView addSubview:videoplayImage];
             picImageView.userInteractionEnabled = YES;
             UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForImage:)];
             [picImageView addGestureRecognizer:tap];
             }
             */
            
            UILabel *picContLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, MY_WIDTH - 30, 20)];
            picContLab.tag = i+1000;
            picContLab.backgroundColor = [UIColor clearColor];
            picContLab.textColor = [UIColor darkTextColor];
            picContLab.textColor = [SurveyRunTimeData colorWithHexString:@"#444444"];
            
            picContLab.font = [UIFont systemFontOfSize:15];
            picContLab.text = [NSString stringWithFormat:@"第%d张图",i];
            CGSize headerSize = [picContLab boundingRectWithSize:CGSizeMake(MY_WIDTH - 30, 100)];
            [picContLab setFrame:CGRectMake(picContLab.left, picContLab.top, headerSize.width, headerSize.height)];
            
            picContentHeight =  20 + imageHeight  + picContLab.frame.size.height + picContentHeight;
            
            [conview addSubview:picContLab];
            picContLab = nil;
        }
    }
    
    UILabel * detailContentLab = [[UILabel alloc]initWithFrame:CGRectMake(15, picContentHeight + 20, MY_WIDTH - 30, 20)];
    detailContentLab.tag = 100;
    
    detailContentLab.font = [UIFont systemFontOfSize:15];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:@"djfalkjdflkajsdlfkjaldkfjas;djfakjdfakdjsflkadsjflkjasldkfjlasjdflkajsdlfjlasdjflakj"];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:6];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [@"djfalkjdflkajsdlfkjaldkfjas;djfakjdfakdjsflkadsjflkjasldkfjlasjdflkajsdlfjlasdjflakj" length])];
    [detailContentLab setAttributedText:attributedString1];
    
    detailContentLab.backgroundColor = [UIColor clearColor];
    
    detailContentLab.textColor = [UIColor blackColor];

    detailContentLab.textColor = [SurveyRunTimeData colorWithHexString:@"#444444"];
    CGSize headerSize = [detailContentLab boundingRectWithSize:CGSizeMake(MY_WIDTH - 30, 100)];
    [detailContentLab setFrame:CGRectMake(detailContentLab.left, detailContentLab.top, headerSize.width, headerSize.height)];
//    [self labelSizeToFitHeight:detailContentLab withWidth:kViewwidth - 30 withy:picContentHeight + 10];
//    UILabel *label = (UILabel*)[contentView viewWithTag:100];
//    if (label) {
//        label.hidden = YES;
//    }
    [conview addSubview:detailContentLab];
    [conview setFrame:CGRectMake(0, conview.frame.size.height, MY_WIDTH, picContentHeight + detailContentLab.frame.size.height + 30)];
    
    [writeLock unlock];
    
    return conview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    LInfoDetailHeaderCell *cell;
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LInfoDetailHeaderCell" owner:self options:nil];
        cell = nib[0];
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
    return cell;
}


//-(UIView *)footViewInit{
//
//
//
//    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height + contentView.frame.size.height, kViewwidth, 40)];
//    //尾
//
//    plNumLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kViewwidth / 2 - 20, 20)];
//    plNumLab.text = [NSString stringWithFormat:@" 热门评论:%d条",(int)idList.count];
//    plNumLab.font = [UIFont systemFontOfSize:13 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
//    plNumLab.textColor = [SurveyRunTimeData colorWithHexString:@"#444444"];
//    plNumLab.hidden = YES;
//
//    zan_btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 12, 16, 16)];
//    NSString *zan = [NSString stringWithFormat:@"%@",detailDict[@"isup"]];
//    if ([zan isEqualToString:@"0"]) {
//        [zan_btn setBackgroundImage:[UIImage imageNamed:@"zixun_zan_gray"] forState:UIControlStateNormal];
//    }else{
//        [zan_btn setBackgroundImage:[UIImage imageNamed:@"zixun_zan"] forState:UIControlStateNormal];
//    }
//    [zan_btn addTarget:self action:@selector(zan:) forControlEvents:UIControlEventTouchUpInside];
//    [footView addSubview:zan_btn];
//
//    upNumLab = [[UILabel alloc]initWithFrame:CGRectMake(zan_btn.right + 5, 10, 80, 20)];
//    upNumLab.text = [NSString stringWithFormat:@"%@",detailDict[@"count4up"]];
//    upNumLab.textColor = [SurveyRunTimeData colorWithHexString:@"#9e9e9e"];
//    upNumLab.font = [UIFont systemFontOfSize:13 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
//
//    UIButton *jubao = [[UIButton alloc]initWithFrame:CGRectMake(MY_WIDTH - 50, 10, 40, 20)];
//
//    UILabel *jubaolabel = [[UILabel alloc]initWithFrame:jubao.frame];
//    jubaolabel.text = @"举报";
//    jubaolabel.textAlignment = NSTextAlignmentCenter;
//    jubaolabel.font = [UIFont systemFontOfSize:13];
//    jubaolabel.textColor = [SurveyRunTimeData colorWithHexString:@"#9e9e9e"];
//    [jubao addTarget:self action:@selector(jubao:) forControlEvents:UIControlEventTouchUpInside];
//
//    downNumLab = [[UILabel alloc]initWithFrame:CGRectMake(kViewwidth - kViewwidth/4, 10, 80, 20)];
//    downNumLab.text = [NSString stringWithFormat:@"踩:%@",detailDict[@"count4down"]];
//    downNumLab.font = [UIFont systemFontOfSize:15 * [[NSUserDefaults standardUserDefaults] floatForKey:kFontType]];
//    downNumLab.hidden = YES;
//    //        if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsNight]) {
//    //            plNumLab.textColor = nightTextColor;
//    //            upNumLab.textColor = nightTextColor;
//    //            downNumLab.textColor = nightTextColor;
//    //        }else{
//    //            plNumLab.textColor = daytimeTextColor;
//    //            upNumLab.textColor = daytimeTextColor;
//    //            downNumLab.textColor = daytimeTextColor;
//    //        }
//
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 0.5)];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    {
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5f, kViewwidth, 0.5)];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        [footView addSubview:lineView];
//    }
//
//
//    [footView addSubview:plNumLab];
//    [footView addSubview:upNumLab];
//    [footView addSubview:downNumLab];
//    [footView addSubview:lineView];
//    [footView addSubview:jubao];
//    [footView addSubview:jubaolabel];
//    return footView;
//}


#pragma mark 加载html
- (void)loadHtml{
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webView.detectsPhoneNumbers = YES;//自动检测网页上的电话号码，单击可以拨打


    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.208xs.com/dingdian/21_21317/n9513306.html"]]];

//    _webView
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"details" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
//    [_webView loadHTMLString:htmlString baseURL:baseURL];
    
}

#pragma mark tableView 行高
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cell";
    infoReplyCell *cell = (infoReplyCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[infoReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    infoReplyModel *model = [[infoReplyModel alloc]initWithModelData];
    infoReplyFrame *frame = [[infoReplyFrame alloc]init];
    frame.replyData = model;
    cell.replyFrame = frame;
//    ce
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    infoReplyModel *model = [[infoReplyModel alloc]initWithModelData];
    infoReplyFrame *frame = [[infoReplyFrame alloc]init];
    frame.replyData = model;
    return frame.cellHight;
}


#pragma mark scrollview delegate (计算contentOffset的值，根据上下距离来决定bounces)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat top = scrollView.contentOffset.y;
    
    NSLog(@"top = %f,height = %f",top,_tableView.contentSize.height - viewHeight - 100);
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (top > (_tableView.contentSize.height - viewHeight - 100)) {
            _tableView.bounces = YES;
        }else{
            _tableView.bounces = NO;
        }
    }else if(scrollView == _webView.scrollView){
        if (top > 30) {
            _tableView.bounces = NO;
        }else{
            _tableView.bounces = YES;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
