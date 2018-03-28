//
//  LHomeViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/8.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LHomeViewController.h"
#import "ZZLMessagewController.h"       //我的消息
#import "ZZLCityChoeseViewController.h" //选择城市
#import "CategoryAndHistoryVC.h"        //搜索页面
#import "ZZLFreeWiFiViewController.h"   //免费Wifi
#import "ToDoViewController.h"          //待办事项
#import <BHInfiniteScrollView/BHInfiniteScrollView.h>//轮播控件
#import "ZZLAllViewController.h"

#define TitleView (@"titleView")  //
#define ActivityView (@"activityView")
#define InformationView (@"informationView")
#define MJCollectionViewCellIdentifier (@"cell")

#import "TableViewCell.h"
#import "HomeTableViewCell.h"
#import "ImageBtn.h"


@interface LHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,BHInfiniteScrollViewDelegate,bringDelegate>
{
    UITableView *MtableView;
    UIScrollView *itemScrollView;//分类项目
    UIPageControl *itemPageControl;
    
    NSArray *mainItemArr;//功能键数据
    NSArray *itemImageArr;//8个功能图片名称arr
    NSArray *itemTitleArr;//8各功能标题名称
    
    NSMutableArray *imageVArr;//广告arr
    
    NSMutableArray *arr_infoa;//资讯数据arr
    
    NSMutableArray *arr_count;//本地存储未读数量
    
    NSString *gonggao_count;//公告通知未读数量显示
    
    NSTimer *timer;//广告图片滑动定时器
    NSInteger timeCount;//广告图片滑动参数
    
    NSMutableArray *sectionArr; //
    UILabel *CountNumberLabel;  //我的消息提示数字
    
    NSDictionary *HD_left_dic;  //活动专区左广告数据
    NSDictionary *HD_rightTop_dic;  //活动专区右上广告数据
    NSDictionary *HD_rightBottom_dic;  //活动专区右上广告数据
    
    NSString *zhigoutuanId;  //直购团id
    BHInfiniteScrollView *actScrollView;
    ImageBtn *titleBtn;//标题btn
    

}

@property (nonatomic,strong) NSArray *titleArr; //资讯标题
@property (nonatomic,strong) NSArray *infoImageArr; //资讯图片

@end

@implementation LHomeViewController
@synthesize CityName;

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

-(NSArray *)infoImageArr{
    if (!_infoImageArr) {
        _infoImageArr = [NSArray array];
    }
    return _infoImageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self NormalIpget];
    zhigoutuanId = @"";
    gonggao_count = @"";
    
    sectionArr = [NSMutableArray arrayWithObjects:TitleView,ActivityView,InformationView,nil];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MtableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,self.view.height - 64 - 44) style:UITableViewStyleGrouped];
    MtableView.delegate = self;
    MtableView.dataSource = self;
    [self.view addSubview:MtableView];
    MtableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(ViewRefresh)];
    
    //注册cell
    [MtableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    
    [self setRightItem];  //添加消息按钮
    NSArray *arr;
    if ([CityName isEqualToString:@"桂林"]) {
        arr= [NSArray arrayWithObjects:[UIImage imageNamed:@"桂林1"],[UIImage imageNamed:@"桂林2"],[UIImage imageNamed:@"桂林3"],nil];
    }else{
        arr = [NSArray arrayWithObjects:[UIImage imageNamed:@"梧州1"],[UIImage imageNamed:@"梧州2"],[UIImage imageNamed:@"梧州3"],nil];
    }

    /*
     广告条初始化
     */
    //**********************
    
    
    actScrollView =  [BHInfiniteScrollView infiniteScrollViewWithFrame:CGRectMake(0, -54, 320 * BILI_m, 95 * BILI_m) Delegate:self ImagesArray:arr];
    actScrollView.dotSize = 7;
    actScrollView.pageViewContentMode = UIViewContentModeScaleToFill;
    actScrollView.dotColor = [UIColor redColor];
    actScrollView.placeholderImage = [UIImage imageNamed:kPLACEHOLDER_IMAGE];
    actScrollView.dotSpacing = 10;
    actScrollView.pageControlAlignmentOffset = CGSizeMake(0, 10);
    actScrollView.tag = 1;
    actScrollView.backgroundColor = [UIColor clearColor];
    itemScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, actScrollView.bottom, 320 * BILI_m, 160 * BILI_m)];
    itemScrollView.scrollEnabled = NO;
    itemScrollView.delegate = self;
    itemScrollView.tag = 2;
    itemImageArr = @[@"main_top1",@"main_top2",@"main_top3",@"main_top4",@"main_top5",@"main_top6",@"main_top7",@"main_top8",];
    itemTitleArr = @[@"公积金查询",@"社保查询",@"个税查询",@"生活缴费",@"违章查询",@"预约挂号",@"办事查询",@"全部",];
    
    imageVArr = [NSMutableArray array];
    
    //主页主功能键
    mainItemArr = [NSArray array];
    
    //设置标题栏
    [self titleView];
    
    //************************
    /*
     功能pagecontrol
     */
    //************************
    itemPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 270 * BILI_m, MY_WIDTH, 20)];
    itemPageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    itemPageControl.pageIndicatorTintColor = [UIColor groupTableViewBackgroundColor];
    itemPageControl.hidden = YES;

    // 马上进入刷新状态
    [MtableView.mj_header beginRefreshing];
    
    /*
    [ZZLAdvert addrequestForAdvert]; //获取开屏广告
     */
    UILabel *WarnningLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, 20)];
    WarnningLabel.text = @"本APP免流量费，请放心使用";
    WarnningLabel.font = [UIFont systemFontOfSize:12];
    WarnningLabel.textAlignment = NSTextAlignmentCenter;
    WarnningLabel.textColor = [UIColor whiteColor];
    WarnningLabel.backgroundColor = [UIColor colorWithHexString:@"#21de5f" alpha:0.8];
    [self.view addSubview:WarnningLabel];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WarnningLabel.hidden = YES;
    });
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
    
    titleBtn = [[ImageBtn alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [titleBtn setTitleColor:[UIColor colorWithHexString:@"#9e9e9e"] forState:UIControlStateNormal];
    [titleBtn resetdata:@"梧州" :[UIImage imageNamed:@"home_down"]];
    
    UIButton *titleV = [[UIButton alloc]initWithFrame:CGRectMake(titleBtn.right + 10,0, grayView.width - titleBtn.width - 10, 30)];
    //设置按钮边框
    {
        CALayer *layer = [titleV layer];
        layer.masksToBounds = YES;
        layer.cornerRadius = 15.0f;
        [layer setMasksToBounds:YES];
    }
    UILabel *graylabel = [[UILabel alloc]initWithFrame:CGRectMake(titleBtn.right + 3, 5, 1, 20)];
    graylabel.backgroundColor = [UIColor grayColor];
    
    
    
    UITextField *seachTextField = [[UITextField alloc]initWithFrame:CGRectMake(titleBtn.right + 10,0, titleV.width - 50, 30)];
    seachTextField.borderStyle = UITextBorderStyleNone;
    seachTextField.text = @"查找服务";
    seachTextField.font = [UIFont systemFontOfSize:12];
    seachTextField.textColor = [UIColor colorWithHexString:@"9e9e9e"];;

    UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    imV.contentMode = UIViewContentModeScaleAspectFit;
    imV.image = [UIImage imageNamed:@"home_search"];
    seachTextField.leftView = imV;
    seachTextField.textAlignment = NSTextAlignmentLeft;
    seachTextField.leftViewMode = UITextFieldViewModeAlways;
    seachTextField.userInteractionEnabled = NO;
    
    [grayView addSubview:titleBtn];
    [grayView addSubview:titleV];
    [grayView addSubview:seachTextField];
    [grayView addSubview:graylabel];
    
    [titleV addTarget:self action:@selector(turnToSeach:) forControlEvents:UIControlEventTouchUpInside];
    [titleBtn addTarget:self action:@selector(cityChose:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = grayView;
}

/**
 * 选择城市
 */
-(IBAction)cityChose:(id)sender{
    NSLog(@"选择城市");
    ZZLCityChoeseViewController *CityChoseVC = [[ZZLCityChoeseViewController alloc]init];
    CityChoseVC.Bringdelegate = self;
    CityChoseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CityChoseVC animated:YES];
}

-(IBAction)turnToSeach:(id)sender
{
    NSLog(@"跳转搜索画面");
    CategoryAndHistoryVC *chVC = [CategoryAndHistoryVC new];
    chVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

//ip拼接
- (void)NormalIpget{
    //接口拼接
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *shakeIp = (NSString *)[userDefaults objectForKey:ShakeIp];
    NSString *fxip = (NSString *)[userDefaults objectForKey:Fxip];
    NSString *ip = (NSString *)[userDefaults objectForKey:City_Address];
    NSString *personalcenter = (NSString *)[userDefaults objectForKey:Personalcenter];
    NSString *voteIP = (NSString *)[userDefaults objectForKey:ToupaioIp];
    if (![fxip isEmpty]) {
        NSString *ipstr = [NSString stringWithFormat:@"%@",ip];
        fxip = [ipstr stringByReplacingOccurrencesOfString:@"8088" withString:@"8081"];
    }
    if (![shakeIp isEmpty]) {
        NSString *ipstr = [NSString stringWithFormat:@"%@",ip];
        shakeIp = [ipstr stringByReplacingOccurrencesOfString:@"8088" withString:@"8082"];
    }
    if (![personalcenter isEmpty]) {
        NSString *ipstr = [NSString stringWithFormat:@"%@",ip];
        NSLog(@"%@",ipstr);
        personalcenter = [ipstr stringByReplacingOccurrencesOfString:@"8088" withString:@"8083"];
    }
    if (![voteIP isEmpty]) {
        NSString *ipstr = [NSString stringWithFormat:@"%@",ip];
        NSLog(@"%@",ipstr);
        voteIP = [ipstr stringByReplacingOccurrencesOfString:@"8088" withString:@"8085"];
    }
    
    [userDefaults setObject:voteIP forKey:ToupaioIp];
    [userDefaults setObject:fxip forKey:Fxip];
    [userDefaults setObject:shakeIp forKey:ShakeIp];
    [userDefaults setObject:personalcenter forKey:Personalcenter];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"---%@",personalcenter);
}

- (void)viewDidAppear:(BOOL)animated{
    /*
     设置title为小区名
     */
    //***********
    self.navigationItem.title = @"爱广西";
    if (arr_infoa.count >0){
        [self ViewRefresh];
    }
    
}

- (void)ViewRefresh{
    
    NSLog(@"接收通知");
    [self getHomeActData];
    [self startRequestForItemArr];
    [self AddCommunityMessageData];
    [self requestForPersonInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [MtableView.mj_header endRefreshing];
    return sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *sectionTitle = sectionArr[section];
    if ([sectionTitle isEqualToString:TitleView]) {
        return 0;
    }else if([sectionTitle isEqualToString:ActivityView]){
        return 1;
    }else if([sectionTitle isEqualToString:InformationView]){
        return self.titleArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *sectionTitle = sectionArr[indexPath.section];
    if ([sectionTitle isEqualToString:TitleView]) {
        //广告栏不含有cell
    }else if([sectionTitle isEqualToString:ActivityView]){
        //活动栏含有一个cell
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //设置按钮边框
        {
            cell.leftBtn.backgroundColor = [UIColor whiteColor];
            CALayer *layer = [cell.leftBtn layer];
            layer.masksToBounds = YES;
            layer.cornerRadius = 5.0f;
            [layer setMasksToBounds:YES];
            layer.borderWidth = 0.5f;
            layer.borderColor = [[UIColor grayColor] CGColor];
        }
        {
            CALayer *layer = [cell.rightBtn layer];
            cell.rightBtn.backgroundColor = [UIColor whiteColor];
            layer.cornerRadius = 5.0f;
            layer.masksToBounds = YES;
            [layer setMasksToBounds:YES];
            layer.borderWidth = 0.5f;
            layer.borderColor = [[UIColor grayColor] CGColor];
        }
        
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
        return cell;
    }

    // 其余为资讯cell
    static NSString *reuseId = @"infocell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell = nib[0];
    }
    NSString *title = self.titleArr[indexPath.row];
    NSString *imageName = self.infoImageArr[indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title,@"title",imageName,@"image",nil];
    cell.cellData = dic;
    NSDictionary *countDic;
    for (int mum = 0; mum < arr_count.count; mum++) {
        NSDictionary *onedic = arr_count[mum];
        if ([onedic[@"article_item_id"] isEqualToString:dic[@"article_item_id"]]) {
            countDic = onedic;
        }
    }
    if (countDic) {
        NSLog(@"数字label：%@,%d",arr_count,(int)indexPath.row);
        if (arr_count.count > indexPath.row) {
            NSString *str = [NSString stringWithFormat:@"%@",countDic[@"count"]];
            NSInteger number = [str integerValue];
            if (number > 9) {
                cell.numberLabel.text = @"9+";
                cell.numberLabel.hidden = NO;
            }
            else if(number == 0){
                cell.numberLabel.text = @"0";
                cell.numberLabel.hidden = YES;
            }
            else{
                cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)number];
                cell.numberLabel.hidden = NO;
            }
        }
    }else{
        cell.numberLabel.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    /*
     点击后回复
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *sectionTitle = sectionArr[indexPath.section];
    if ([sectionTitle isEqualToString:TitleView]) {
        return;
    }else if([sectionTitle isEqualToString:ActivityView]){
        return;
    }else if([sectionTitle isEqualToString:InformationView]){
    }
    
    //资讯跳转
    /*
    AXHSQDynamicViewController *sqDyVCtr = [[AXHSQDynamicViewController alloc]initWithNibName:nil bundle:nil withTitle:Title_label withType:Article_type_id];
    UINavigationController *NAVCtr = [[UINavigationController alloc]initWithRootViewController:sqDyVCtr];
    [self presentViewController:NAVCtr animated:YES completion:NULL];
     */
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *sectionTitle = sectionArr[section];
    if ([sectionTitle isEqualToString:TitleView]) {
        UIView *view;
        view = [self setHeaderView];
        return view;
    }else if([sectionTitle isEqualToString:ActivityView]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ActivityView];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ActivityView];
//            cell.backgroundColor = [UIColor whiteColor];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.textLabel.font = [UIFont systemFontOfSize:14];
//            cell.textLabel.textColor = [UIColor colorWithHexString:@"#444444"];
//            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
//            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#9e9e9e"];
//
//            //添加手势
//            UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc]init];
//            [tapg addTarget:self action:@selector(turnToActivityView)];
//            tapg.numberOfTapsRequired=1;
//            [cell setUserInteractionEnabled:YES];
//            [cell addGestureRecognizer:tapg];
        }
//        cell.textLabel.text = @"活动专区";
//        cell.detailTextLabel.text = @"更多>";
        return cell;
    }else if([sectionTitle isEqualToString:InformationView]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:InformationView];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:InformationView];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#444444"];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#9e9e9e"];
//            //添加手势
//            UITapGestureRecognizer *tapg = [[UITapGestureRecognizer alloc]init];
//            [tapg addTarget:self action:@selector(turnToPostView)];
//            tapg.numberOfTapsRequired=1;
//            [cell setUserInteractionEnabled:YES];
//            [cell addGestureRecognizer:tapg];
        }
        cell.textLabel.text = @"城市新闻";
//        cell.detailTextLabel.text = @"更多";
        return cell;
    }
    UIView *view;
    view = [[UIView alloc]init];
    return view;
}

/*跳转活动专区*/
-(void)turnToActivityView{
    
    /*
    HuodongMainViewController *HDLVc = [[HuodongMainViewController alloc]init];
    HDLVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:HDLVc animated:YES];
     */
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = sectionArr[section];
    if ([sectionTitle isEqualToString:TitleView]) {
        NSLog(@"%f",itemScrollView.bottom);
        return itemScrollView.bottom;
    }else if([sectionTitle isEqualToString:ActivityView]){
        return 0.01;
    }else if([sectionTitle isEqualToString:InformationView]){
        return 40;
    }
    return 0.1;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *sectionTitle = sectionArr[indexPath.section];
    if ([sectionTitle isEqualToString:TitleView]) {
        return 0.1;
    }else if([sectionTitle isEqualToString:ActivityView]){
        return 100;
    }else if([sectionTitle isEqualToString:InformationView]){
        return 70;
    }
    return 70
    ;
}
- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSString *sectionTitle = sectionArr[section];
    if ([sectionTitle isEqualToString:TitleView]) {
        return 0.1;
    }else if([sectionTitle isEqualToString:ActivityView]){
        return 5;
    }else if([sectionTitle isEqualToString:InformationView]){
        return 5;
    }
    return 0.1;
}

- (UITableViewCell *)setHeaderView{
    UITableViewCell *headerView = [[UITableViewCell alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:actScrollView];
    [headerView addSubview:itemScrollView];
    [headerView addSubview:itemPageControl];
    [itemScrollView removeAllSubviews];

    
    [itemScrollView setContentSize:CGSizeMake(640 * BILI_m,132 * BILI_m)];
    itemScrollView.pagingEnabled = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80 * BILI_m, 66 * BILI_m);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    for (int num = 0;num < 2; num ++) {
        UICollectionView *Collection = [[UICollectionView alloc]initWithFrame:CGRectMake(320 * num * BILI_m, 0, 320 * BILI_m, 132 * BILI_m) collectionViewLayout:layout];
        Collection.bounces = NO;
        Collection.scrollEnabled = NO;
        Collection.delegate = self;
        Collection.dataSource = self;
        
        Collection.backgroundColor = [UIColor whiteColor];
        Collection.alwaysBounceVertical = YES;
        [Collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJCollectionViewCellIdentifier];
        Collection.tag = num;
        [itemScrollView addSubview:Collection];
    }
    itemPageControl.numberOfPages = 2;
    itemPageControl.userInteractionEnabled = NO;
    //通过滚动的偏移量来判断目前页面所对应的小白点
    itemPageControl.currentPage = 0;
    /*
     黑线
     */
    //***********************
    UILabel *bottomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, itemScrollView.bottom - 5, MY_WIDTH, 5.0f)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [headerView addSubview:bottomLine];
    
    //***********************
    return headerView;
}


#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mainItemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJCollectionViewCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *dic = mainItemArr[indexPath.row];
    if (cell.subviews.count < 3) {
        UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake((80 * BILI_m - 35)/2, (66 * BILI_m - 50)/2, 35, 35)];
        NSString *imgStr = itemImageArr[indexPath.row];
//        [imagV sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE] options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder];
        [imagV setImage:[UIImage imageNamed:imgStr]];
        
        [cell.contentView addSubview:imagV];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imagV.bottom + 4, 80 * BILI_m, 11)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = itemTitleArr[indexPath.row];
        label.textColor = [UIColor colorWithHexString:@"#444444"];
        [cell.contentView addSubview:label];
        label.font = [UIFont systemFontOfSize:11];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 15, 15)];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.layer.cornerRadius = 7.5f;
        countLabel.layer.masksToBounds = YES;
        countLabel.tag = 100;
        countLabel.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:countLabel];
        countLabel.hidden = YES;
        
        //自动布局设置
        /*
        imagV.sd_layout
        .leftSpaceToView(cell.contentView, (80 * BILI_m - 35)/2)
        .topSpaceToView(cell.contentView,(66 * BILI_m - 50)/2)
        .heightIs(35)
        .widthIs(35);
        
        //自动布局设置
        label.sd_layout
        .leftSpaceToView(cell.contentView, 0)
        .topSpaceToView(imagV,4)
        .heightIs(11)
        .widthIs(80 * BILI_m);
        
        //自动布局设置
        countLabel.sd_layout
        .leftSpaceToView(imagV, -5)
        .topSpaceToView(imagV,-10)
        .heightIs(15)
        .widthIs(15);
         */
        
    }
    if ([dic[@"id"] isEqualToString:@"1"]) {
        UILabel *countLabel = (UILabel *)[cell.contentView viewWithTag:100];
        countLabel.text = gonggao_count;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.textColor = [UIColor whiteColor];
        countLabel.hidden = NO;
        NSInteger number = [gonggao_count integerValue];
        if (number > 9) {
            countLabel.text = @"9+";
            countLabel.hidden = NO;
        }
        else if(number == 0){
            countLabel.text = @"0";
            countLabel.hidden = YES;
        }
        else{
            countLabel.text = [NSString stringWithFormat:@"9+"];
            countLabel.hidden = NO;
        }
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 7) {
        ZZLAllViewController *allVC = [[ZZLAllViewController alloc]init];
        allVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:allVC animated:YES];
    }else{
        ZZLFreeWiFiViewController *freeWifi = [[ZZLFreeWiFiViewController alloc]init];
        freeWifi.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:freeWifi animated:YES];
        return;
    }
}




/*
 获取广告图片信息
 */
-(void)getHomeActData{
    /*
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *device_brand =[userDefaults objectForKey:User_device_brand];//存储品牌
    NSString *mobileModel = [userDefaults objectForKey:User_device_model];//手机型号
    NSString *yunyingshangStr = [userDefaults objectForKey:User_telecom_operators];//运营商
    NSString *Os = [userDefaults objectForKey: User_os];//手机系统
    NSString *os_Version =[userDefaults objectForKey:User_os_version];//系统型号
    NSString *net_type = [userDefaults objectForKey: User_device_net_type];//接入网络
    NSString *url_version = [userDefaults objectForKey: User_if_version];//接口版本
    NSString *longitude = [userDefaults objectForKey: User_longitude];//经度
    NSString *latitude = [userDefaults objectForKey: User_latitude];//纬度
    NSString *appCurVersion = [userDefaults objectForKey: User_app_version];//App 版本号
    NSString *andoid_ios = [userDefaults objectForKey: User_andoid_ios];//终端类型
    NSString *ip = [userDefaults objectForKey: User_device_ip];//终端类型
    //当前时间
    //*******************************
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy/MM/dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSLog(@"当前时间：%@",dateStr);
    
    if ([user.session isEmpty]) {
        
    }else{
        user.session = @"";
    }
    NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"area_id\":\"%@\",\"agency_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\",\"ad_position_model\":\"0\",\"session\":\"%@\",\"device_brand\":\"%@\",\"device_model\":\"%@\",\"imei\":\"%@\",\"telecom_operators\":\"%@\",\"os\":\"%@\",\"os_version\":\"%@\",\"ip\":\"%@\",\"net_type\":\"%@\",\"if_version\":\"%@\",\"longitude\":\"%@\",\"latitude\":\"%@\",\"login_time\":\"%@\",\"app_version\":\"%@\",\"andoid_ios\":\"%@\"}",user.currentAddress.city_id,user.currentAddress.area_id,user.currentAddress.agency_id,user.currentAddress.community_id,user.currentAddress.quarter_id,user.session,device_brand,mobileModel,MY_UUID,yunyingshangStr,Os,os_Version,ip,net_type,url_version,longitude,latitude,dateStr,appCurVersion,andoid_ios];
    NSLog(@"广告图片请求：%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:TopXinXi_m39_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            [SVProgressHUD showImage:nil status:@"未查询到相关数据"];
        }
        else
        {
            NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            NSString *ecode = [NSString stringWithFormat:@"%@",rootDic[@"ecode"]];
            if ([ecode isEqualToString:@"3004"]) {
                //添加重新登录的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
                return;
            }else if ([ecode isEqualToString:@"3005"]){
                //添加未登录的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
                return;
            }
            NSArray *array=[NSArray arrayWithArray:[rootDic objectForKey:@"info"]];
            NSLog(@"广告数据：%@",rootDic);
            [imageVArr removeAllObjects];
            for (int num = 0; num< array.count; num++) {
                NSDictionary *dic = array[num];
                NSString *value=[dic objectForKey:@"ad_position_value"];
                NSLog(@"%@",value);
                //首页广告数据
                if ([value isEqualToString:@"mobile_quarter_01"])
                {
                    [imageVArr addObject:dic];
                }
                //活动专区广告数据
                //*****************
                if ([value isEqualToString:@"mobile_activity_left"])
                {
                    HD_left_dic = [NSDictionary dictionaryWithDictionary:dic];
                    
                }
                if ([value isEqualToString:@"mobile_activity_righttop"])
                {
                    HD_rightTop_dic = [NSDictionary dictionaryWithDictionary:dic];
                }
                if ([value isEqualToString:@"mobile_activity_rightbottom"])
                {
                    HD_rightBottom_dic = [NSDictionary dictionaryWithDictionary:dic];
                }
                //***************
            }
            //加载广告图片
            [self setActScrollView];
            [MtableView reloadData];
            
        }
    }];
     */
}





/*
 资讯栏目信息获取
 */
-(void)AddCommunityMessageData
{
    self.titleArr = @[@"广西公安消防总队召开全区重大火灾隐患集中整治专项行动新闻",@"超级杂交稻重大进展新闻发布会于今日下午汇报讲座",@"南宁五象新区一批重大项目开工，柳沙居民生活更便利",@"玉林13个项目同日开（竣）工 献礼新中国60华诞"];
    self.infoImageArr = @[@"guilininfo1",@"guilininfo2",@"guilininfo3",@"guilininfo4"];

    [MtableView reloadData];
}


/*
 获取主页功能键数据
 */
- (void)startRequestForItemArr{
    mainItemArr = @[
                    @{@"article_item_id":@"",@"function_mark":@"wuyefuwu",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/201706301832023388PXF.png",@"id" : @"17",@"isapp":@"3",@"name":@"物业服务",@"sort":@"7",@"url":@""},
                    @{@"article_item_id":@"",@"function_mark" : @"findservice",@"icon": @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/20170630144010968D206.png",@"id" : @"34",@"isapp":@"5",@"name":@"找服务",@"sort":@"7",@"url":@""},
                    @{@"article_item_id":@"",@"function_mark" : @"ehome",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/201706301454400796VRR.png",@"id" : @"34",@"isapp":@"5",@"name":@"笑脸e家",@"sort":@"7",@"url":@""},
                    @{@"article_item_id":@"",@"function_mark" : @"shoppingmall",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/201706301455541608TDR.png",@"id" : @"34",@"isapp":@"5",@"name":@"优惠拼团",@"sort":@"7",@"url":@""},
                    @{@"article_item_id":@"",@"function_mark":@"tianqi",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/20170630143515136RX8L.png",@"id" : @"17",@"isapp":@"0",@"name":@"天气",@"sort":@"7",@"url":@"http://m.sohu.com/weather/"},
                    @{@"article_item_id":@"",@"function_mark" : @"gangzhonglvyou",@"icon": @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/2017063018414700120D4.png",@"id" : @"34",@"isapp":@"0",@"name":@"旅游",@"sort":@"7",@"url":@"http://221.13.137.162:1935/live/LYTV1-2/playlist.m3u8"},
                    @{@"article_item_id":@"",@"function_mark" : @"kanzhibo",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/201706301454400796VRR.png",@"id" : @"34",@"isapp":@"5",@"name":@"看直播",@"sort":@"7",@"url":@""},
                    @{@"article_item_id":@"",@"function_mark" : @"morefunction",@"icon" : @"http://xiaolianshequ.cn/252/systemfile/homepageicon/201706/functionitem/20170630134900734Z8D4.png",@"id" : @"34",@"isapp":@"5",@"name":@"全部功能",@"sort":@"7",@"url":@""}];
    [MtableView reloadData];
    /*
    //    MBProgressHUD *hud = [SurveyRunTimeData showloadHudWithView:self.view withStr:@"正在加载..."];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",nil];
    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
    NSLog(@"%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_01 Paramters:Str
                        FinishCallbackBlock:^(NSString *result)
     {
         if (result.length<=0)
         {
             //网络不好时提示
             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
         }
         else
         {
             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
             SBJsonParser *parser = [[SBJsonParser alloc] init];
             NSError *error = nil;
             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
             NSLog(@"主功能键：%@",rootDic);
             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
             int inta = [a intValue];
             if (inta==1000)
             {
                 mainItemArr = rootDic[@"info"];
                 [MtableView reloadData];
                 NSLog(@"主页功能键：%@",rootDic);
             }else if (inta == 3004){
                 //添加重新登录的通知
                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
                 return;
             }else if(inta == 3005){
                 //添加未登录的通知
                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
                 return;
             }
         }
     }];
     */
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

/**
 *个人信息查询
 */
-(void)requestForPersonInfo{
    /*
    
    if (![user.session isEmpty]) {
        return;
    }
    NSDictionary *requestDic = [NSDictionary dictionaryWithObject:user.session forKey:@"session"];
    NSString *str1=[SurveyRunTimeData dictionaryToJson:requestDic];
    NSLog(@"请求钱包参数:%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    //接口拼接
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *systemcityAddress = (NSString *)[userDefaults objectForKey:Personalcenter];
    NSString *requestUrl = [NSString stringWithFormat:@"http://%@%@%@",systemcityAddress,Person_VERSION,Personnal_uc1_01];
    
    [HttpPostExecutor postExecuteWithUrlStr:requestUrl Paramters:Str
                        FinishCallbackBlock:^(NSString *result)
     {
         if (result.length<=0)
         {
             //网络连接失败时处理
             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
         }
         else
         {
             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
             SBJsonParser *parser = [[SBJsonParser alloc] init];
             NSError *error = nil;
             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
             NSLog(@"个人信息:%@",rootDic);
             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
             [SurveyRunTimeData showWithView:self.view withRequestStr:a];
             int inta = [a intValue];
             if (inta==1000)
             {
                 CountNumberLabel.text = [NSString stringWithFormat:@"%@",rootDic[@"newmessage"]];
                 if ([CountNumberLabel.text integerValue]>0) {
                     CountNumberLabel.hidden = NO;
                     if (CountNumberLabel.text.length > 1) {
                         //                         [CountNumberLabel sizeToFit];
                     }
                 }else{
                     CountNumberLabel.hidden = YES;
                 }
             }
             else if(inta == 3007){
             }
             else if (inta == 3004){
                 //添加重新登录的通知
                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
                 return;
             }
             else if (inta == 3005){
                 //添加未登录的通知
                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
                 return;
             }
             else{
                 
             }
         }
     }];
     */
}



//IOS 6.0 以上禁止横屏
- (BOOL)shouldAutorotate
{
    return NO;
}
//IOS 6.0 以下禁止横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


/*
 点击活动专区左广告
 */
-(void)SingleTapLeft:(UITapGestureRecognizer*)recognizer
{
    ToDoViewController *todoVC = [[ToDoViewController alloc]init];
    todoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:todoVC animated:YES];
}

/*
 点击活动专区右广告
 */
-(void)SingleTaprightTop:(UITapGestureRecognizer*)recognizer
{
    ZZLFreeWiFiViewController *freeWifi = [[ZZLFreeWiFiViewController alloc]init];
    freeWifi.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:freeWifi animated:YES];
}

/*
 点击活动专区右下广告
 */
-(void)SingleTaprightBottom:(UITapGestureRecognizer*)recognizer
{
    
}

/** 点击图片*/
- (void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index{
    /*
    int num = (int)index;
    if (imageVArr.count > num) {
    }else{
        return;
    }
    NSDictionary *dic = imageVArr[num];
    [SurveyRunTimeData turnWithController:self actDic:dic];
    return;
     */
}

#pragma mark Bringdelegate

-(void)bringWithItemId:(NSString *)itemid{
    self.CityName = itemid;
    NSArray *arr;
    if ([CityName isEqualToString:@"桂林"]) {
        arr= [NSArray arrayWithObjects:[UIImage imageNamed:@"桂林1"],[UIImage imageNamed:@"桂林2"],[UIImage imageNamed:@"桂林3"],nil];
    }else{
        arr = [NSArray arrayWithObjects:[UIImage imageNamed:@"梧州1"],[UIImage imageNamed:@"梧州2"],[UIImage imageNamed:@"梧州3"],nil];
    }
    [titleBtn resetdata:itemid :[UIImage imageNamed:@"home_down"]];
    actScrollView.imagesArray = arr;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
