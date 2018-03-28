//
//  LFindViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/8.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LFindViewController.h"
#import "CategoryAndHistoryVC.h"        //搜索页面
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>//轮播控件
#import "ImageBtn.h"
#import "ZZLMessagewController.h" //我的消息
#import "LFGoodsCell.h"   //商品cell
#import "LFHeaderCell.h"  //景点cell


@interface LFindViewController ()<UITableViewDataSource,UITableViewDelegate,
BHInfiniteScrollViewDelegate>
{
    BHInfiniteScrollView *actScrollView; //广告轮播控件
    UILabel *CountNumberLabel; //消息数字
}

@property (nonatomic,strong) UITableView *MTableView; //列表

@end

@implementation LFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self titleView]; //设置标题栏
    [self setRightItem]; //设置右上角消息按钮
    [self MTableViewInit];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置列表
- (void)MTableViewInit{
    _MTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH,MY_HEIGHT- 64 - 54) style:UITableViewStyleGrouped];
    _MTableView.delegate = self;
    _MTableView.dataSource = self;
    _MTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_MTableView];
    
    //注册cell
    [_MTableView registerNib:[UINib nibWithNibName:@"LFGoodsCell" bundle:nil] forCellReuseIdentifier:@"LFGoodsCell"];
    [_MTableView registerNib:[UINib nibWithNibName:@"LFHeaderCell" bundle:nil] forCellReuseIdentifier:@"LFHeaderCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 0;
            break;
        default:
            return 4;
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSString *reuseIdentifier = [NSString stringWithFormat:@"LFHeaderCell"];
        LFHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[LFHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        }
        cell.Dic = [NSDictionary dictionary];
        return cell;
    }else if(indexPath.section == 2){
        NSString *reuseIdentifier = [NSString stringWithFormat:@"LFGoodsCell"];
        LFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[LFGoodsCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        }
        cell.dic = [NSDictionary dictionary];
        return cell;
    }
    NSString *reuseIdentifier = [NSString stringWithFormat:@"row%ld-%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        /*
         广告条初始化
         */
        //**********************
        actScrollView =  [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, 0, 320 * BILI_m, 90  * BILI_375) Delegate:self ImagesArray:@[[UIImage imageNamed:kPLACEHOLDER_IMAGE],[UIImage imageNamed:kPLACEHOLDER_IMAGE]]];
        actScrollView.dotSize = 7;
        actScrollView.pageViewContentMode = UIViewContentModeScaleToFill;
        actScrollView.dotColor = [UIColor redColor];
        actScrollView.placeholderImage = [UIImage imageNamed:kPLACEHOLDER_IMAGE];
        actScrollView.dotSpacing = 10;
        actScrollView.pageControlAlignmentOffset = CGSizeMake(0, 10);
        return actScrollView;
    }
    UIView *view = [[UIView alloc]init];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"dddd"];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    if (section == 0) {
        cell.textLabel.text = @"景点·玩乐";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#8e8e8e"];
        cell.detailTextLabel.text = @"更多";
    }else if(section == 1){
        cell.textLabel.text = @"必买特产";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#8e8e8e"];
        cell.detailTextLabel.text = @"更多";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 213 *BILI_375 + 31 + 15;
    }
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 90  * BILI_375;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 50;
    }else if (section == 1){
        return 50;
    }
    return 0.01;
}



#pragma mark - 设置标题栏
- (void)titleView{
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 275*BILI_m, 30)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    //设置按钮边框
    {
        CALayer *layer = [grayView layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 15.0f;
        [layer setMasksToBounds:YES];
    }
    
    UIButton *titleV = [[UIButton alloc]initWithFrame:CGRectMake(10,0, grayView.width - 10, 30)];
    //设置按钮边框
    {
        CALayer *layer = [titleV layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 15.0f;
        [layer setMasksToBounds:YES];
    }
    
    
    
    UITextField *seachTextField = [[UITextField alloc]initWithFrame:CGRectMake(10,0, titleV.width - 50, 30)];
    seachTextField.borderStyle = UITextBorderStyleNone;
    seachTextField.text = @"  景点/美食/本地特产";
    seachTextField.font = [UIFont systemFontOfSize:12];
    seachTextField.textColor = [UIColor colorWithHexString:@"9e9e9e"];;
    
    UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    imV.contentMode = UIViewContentModeScaleAspectFit;
    imV.image = [UIImage imageNamed:@"home_search"];
    seachTextField.leftView = imV;
    seachTextField.textAlignment = NSTextAlignmentLeft;
    seachTextField.leftViewMode = UITextFieldViewModeAlways;
    seachTextField.userInteractionEnabled = NO;
    
    [grayView addSubview:titleV];
    [grayView addSubview:seachTextField];
    
    [titleV addTarget:self action:@selector(turnToSeach:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = grayView;
}

-(IBAction)turnToSeach:(id)sender
{
    NSLog(@"跳转搜索画面");
    CategoryAndHistoryVC *chVC = [CategoryAndHistoryVC new];
    chVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chVC animated:YES];
}

/**
 * 添加右上角item
 */
-(void)setRightItem{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *normalImgName = @"per_message";
    NSString *highlightedImgName = @"per_message";
    if (!normalImgName) {
        normalImgName = @"per_message";
    }
    if (!highlightedImgName) {
        highlightedImgName = @"per_message";
    }
    [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(turnToMessage:) forControlEvents:UIControlEventTouchUpInside];
    CountNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 8, 8)];
    CountNumberLabel.textColor = [UIColor whiteColor];
    CountNumberLabel.font = [UIFont systemFontOfSize:10];
    CountNumberLabel.textAlignment = NSTextAlignmentCenter;
    CountNumberLabel.backgroundColor = [UIColor whiteColor];
    CountNumberLabel.layer.masksToBounds = YES;
    CountNumberLabel.layer.cornerRadius = 4;
    CountNumberLabel.hidden = YES;
    CALayer *layer = [CountNumberLabel layer];
    [layer setCornerRadius:4.0f];
    [layer setMasksToBounds:YES];//设置边框可见
    layer.borderColor = [[UIColor redColor] CGColor];
    [layer setBorderWidth:0.5];
    CountNumberLabel.text = @"";
    [btn addSubview:CountNumberLabel];
    btn.frame = CGRectMake(10, 0, 58/2, 88/2);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.rightBarButtonItem = barItem;
    CountNumberLabel.hidden = YES;
}

-(IBAction)turnToMessage:(id)sender{
    ZZLMessagewController *MessageVC = [[ZZLMessagewController alloc]init];
    MessageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MessageVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
