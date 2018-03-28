//
//  ZZLAllViewController.m
//  ZHSQ
//
//  Created by 赵中良 on 2017/5/18.
//  Copyright © 2017年 lacom. All rights reserved.
//

#import "ZZLAllViewController.h"
#import "gongnengmodel.h"
#import "GongnengCell.h"
#import "GongnegHeaderView.h"

//*******************
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

extern UserInfo *user;


@interface ZZLAllViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//@property (nonatomic, strong) CALayer *dotLayer;
//@property (nonatomic, assign) CGFloat endPoint_x;
//@property (nonatomic, assign) CGFloat endPoint_y;
//@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) NSMutableArray *allArray; //全部功能

@property (nonatomic,strong) NSMutableArray *titileArr;

@end

@implementation ZZLAllViewController

//懒加载
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
//懒加载
- (NSMutableArray *)titileArr{
    if (!_titileArr) {
        _titileArr = [NSMutableArray array];
    }
    return _titileArr;
}

//懒加载
- (NSMutableArray *)allArray{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 20;
        _flowLayout.minimumInteritemSpacing = 20;
        
        
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);//分区内边距
        
        CGFloat totalWidth = kWidth-40;
        CGFloat itemWidth = 60;
        CGFloat itemHeght = 60;
        //注意：item的宽高必须要提前算好
        _flowLayout.itemSize = CGSizeMake(itemWidth, itemHeght);
        //创建collectionView对象，并赋值布局
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidth, MY_HEIGHT - 64) collectionViewLayout:_flowLayout];
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        [_collectionView registerClass:[GongnengCell class] forCellWithReuseIdentifier:@"cellIdentiifer"];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //滚动到顶部
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"#222222"];
    
    //设置编辑按钮
    self.editButtonItem.title = @"编辑";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"更多功能";
    self.array = [NSMutableArray array];
    self.titileArr = [NSMutableArray array];
    
    [self startRequestForItemArr];//全部功能
    [self startRequestForMyItemArr];//我的功能
    
    
    
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
    //注册头视图
    [self.collectionView registerClass:[GongnegHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GongnegHeaderView"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"GongnegFooterView"];
    
    [self.view addSubview:self.collectionView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"erweima_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToLastView:)];
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (self.editing) {
        self.editButtonItem.title = @"完成";
    } else {
        self.editButtonItem.title = @"编辑";
    }
    [self.collectionView reloadData];
}

- (IBAction)backToLastView:(id)sender{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
         [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}


//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        GongnegHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                         withReuseIdentifier:@"GongnegHeaderView"
                                                                                forIndexPath:indexPath];
        headView.backgroundColor = [UIColor whiteColor];
        headView.nameStr = self.titileArr[indexPath.section];
        return headView;
    }else{
        UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                         withReuseIdentifier:@"GongnegFooterView"
                                                                                forIndexPath:indexPath];
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, 15)];
        whiteView.backgroundColor = [UIColor whiteColor];
        headView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [headView addSubview:whiteView];
        return headView;
    }
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 49);
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, 25);
    }
    return CGSizeMake(self.view.frame.size.width, 16);
}



//长按手势
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                [self setEditing:YES animated:YES];
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
                // 找到当前的cell
                GongnengCell *cell = (GongnengCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
                if (selectIndexPath.section == 0) {
                    // 定义cell的时候btn是隐藏的, 在这里设置为NO
                    [cell.btnDelete setHidden:NO];
                    
                    cell.btnDelete.tag = selectIndexPath.item;
                    
                    //添加删除的点击事件
                    [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                }else{
                    // 定义cell的时候btn是隐藏的, 在这里设置为NO
                    [cell.btnAdd setHidden:NO];
                    
                    cell.btnAdd.tag = selectIndexPath.item;
                    
                    //添加添加的点击事件
                    [cell.btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
                }
                
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
           
            [self.collectionView endInteractiveMovement];
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    if (destinationIndexPath.section > 0) {
        [self.collectionView reloadData];
        return;
    }
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    GongnengCell *cell = (GongnengCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = YES;
    cell.btnAdd.hidden = YES;
    cell.btnYitianjia.hidden = YES;

    
    /*1.存在的问题,移动是二个一个移动的效果*/
    //	[collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    /*2.存在的问题：只是交换而不是移动的效果*/
    //    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    /*3.完整的解决效果*/
    //取出源item数据
    id objc = [self.array objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.array removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.array insertObject:objc atIndex:destinationIndexPath.item];
    
    [self btnChange];
    [self.collectionView reloadData];
}



- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"#222222"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


#pragma mark---UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.titileArr[section] isEqualToString:@"我的功能"]) {
       return self.array.count;
    }else{
        NSArray *kindarr = self.allArray[section - 1];
        return kindarr.count;
    }

    return self.array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.titileArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GongnengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentiifer" forIndexPath:indexPath];
    
    //    _longPress.view.tag = indexPath.item;
    //设置cell
    //    model *mode = [[model alloc] init];
    //    mode = self.array[indexPath.section][indexPath.item];
    //        cell.model = model;
   
    if ([self.titileArr[indexPath.section] isEqualToString:@"我的功能"]) {
        NSDictionary *dic = self.array[indexPath.row];
        cell.lable.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
        cell.btnDelete.hidden = YES;
        cell.btnDelete.row = indexPath.row;
        cell.btnDelete.section = indexPath.section;
        cell.btnAdd.hidden = YES;
        cell.btnAdd.row = indexPath.row;
        cell.btnAdd.section = indexPath.section;
        cell.btnYitianjia.hidden = YES;
        cell.btnYitianjia.row = indexPath.row;
        cell.btnYitianjia.section = indexPath.section;
        NSString *imagestr = dic[@"imagestr"];
        if ([imagestr isEmpty]) {
            [cell.imageIcon setImage:[UIImage imageNamed:imagestr]];
        }else{
            [cell.imageIcon setImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]];
        }
        //添加删除的点击事件
        [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
        if (self.editing) {
            cell.btnDelete.hidden = NO;
        } else {
        }
    }else{
        NSArray *kindarr = self.allArray[indexPath.section - 1];
        NSDictionary *dic = kindarr[indexPath.row];
        cell.lable.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
        cell.btnDelete.hidden = YES;
        cell.btnDelete.row = indexPath.row;
        cell.btnDelete.section = indexPath.section;
        cell.btnAdd.hidden = YES;
        cell.btnAdd.row = indexPath.row;
        cell.btnAdd.section = indexPath.section;
        cell.btnYitianjia.hidden = YES;
        cell.btnYitianjia.row = indexPath.row;
        cell.btnYitianjia.section = indexPath.section;
        NSString *itemIcon = [dic[@"icon"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//图标
//        [cell.imageIcon setImageWithURL:[NSURL URLWithString:itemIcon]
//                     placeholderImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]
//                              options:SDWebImageRetryFailed | SDWebImageDelayPlaceholder
//          usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.imageIcon setImage:[UIImage imageNamed:kPLACEHOLDER_IMAGE]];
        //添加增加的点击事件
        [cell.btnAdd addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
        if (self.editing) {
            cell.btnAdd.hidden = NO;
        } else {
            cell.btnDelete.hidden = YES;
            cell.btnAdd.hidden = YES;
            cell.btnYitianjia.hidden = YES;
        }
        for (NSDictionary *odic in self.array) {
            NSString *oid = [NSString stringWithFormat:@"%@",odic[@"id"]];
            NSString *tid = [NSString stringWithFormat:@"%@",dic[@"id"]];
            if ([oid isEqualToString:tid]) {
                if (self.editing) {
                    cell.btnYitianjia.hidden = NO;
                    cell.btnAdd.hidden = YES;
                }
            }
        }
    }
    
    return cell;
}


#pragma mark---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editing) {
        return;
    }
    NSDictionary *dic;
//    if ([self.titileArr[indexPath.section] isEqualToString:@"我的功能"]) {
//        dic = self.array[indexPath.row];
//    }else{
//        NSArray *kindarr = self.allArray[indexPath.section - 1];
//        dic = kindarr[indexPath.row];
//    }
//    NSLog(@"点击 item:%ld \n 数据：%@",(long)indexPath.row,dic);
//    NSString *itemStr = [NSString stringWithFormat:@"%@",dic[@"name"]];//名称
//    NSString *itemUrl = [NSString stringWithFormat:@"%@",dic[@"url"]];//链接地址
//    NSString *itemIcon = [NSString stringWithFormat:@"%@",dic[@"icon"]];//图标
//    NSString *article_item_id = [NSString stringWithFormat:@"%@",dic[@"article_item_id"]];//图标
//    NSString *itemId = dic[@"id"];
//    NSString *function_mark = [NSString stringWithFormat:@"%@",dic[@"function_mark"]]; //功能图标唯一标示那边
//    NSString *m_key = [NSString stringWithFormat:@"%@",dic[@"magicwindow_activity_key"]];
//    NSString *isapp = [NSString stringWithFormat:@"%@",dic[@"isapp"]];
//    NSString *itemid = [NSString stringWithFormat:@"%@",dic[@"id"]];//名称
    
    
}


#pragma mark---btn的删除cell事件

- (void)btnDelete:(ZZLButton *)btn{
    
     btn.enabled = NO;
    
    //取出源item数据
//    NSDictionary *btndic = [self.array objectAtIndex:btn.row];;
//    NSString *btn_id = [NSString stringWithFormat:@"%@",btndic[@"id"]];
//
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",user.session,@"session",btn_id,@"id",nil];
//    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
//    NSLog(@"%@",str1);
//    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//
//    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_08 Paramters:Str
//                        FinishCallbackBlock:^(NSString *result)
//     {
//          btn.enabled = YES;
//         if (result.length<=0)
//         {
//             //网络不好时提示
//             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
//         }
//         else
//         {
//             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
//             SBJsonParser *parser = [[SBJsonParser alloc] init];
//             NSError *error = nil;
//             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//             NSLog(@"我的功能：%@",rootDic);
//             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
//             int inta = [a intValue];
//             if (inta==1000)
//             {
//                 //取出源item数据
//                 id objc = [self.array objectAtIndex:btn.row];
//                 //从资源数组中移除该数据
//                 [self.array removeObject:objc];
//                 [self.collectionView reloadData];
//
//                 //                 NSArray *arrr = [self getArrFormDic:arr];
//             }else if (inta == 3004){
//                 //添加重新登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
//                 return;
//             }else if(inta == 3005){
//                 //添加未登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
//                 return;
//             }
//         }
//     }];

    
    
    
}


#pragma mark---btn的增加cell事件

- (void)btnAdd:(ZZLButton *)btn{
    
//    btn.enabled = NO;
//
//    //取出源item数据
//    NSArray *kindarr = self.allArray[btn.section - 1];
//    NSDictionary *btndic = kindarr[btn.row];
//    NSString *btn_id = [NSString stringWithFormat:@"%@",btndic[@"id"]];
//    NSString *btn_sid = [NSString stringWithFormat:@"%@",btndic[@"s_id"]];
//
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",user.session,@"session",btn_id,@"id",btn_sid,@"s_id",nil];
//    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
//    NSLog(@"%@",str1);
//    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//
//    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_07 Paramters:Str
//                        FinishCallbackBlock:^(NSString *result)
//     {
//          btn.enabled = YES;
//         if (result.length<=0)
//         {
//             //网络不好时提示
//             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
//         }
//         else
//         {
//
//             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
//             SBJsonParser *parser = [[SBJsonParser alloc] init];
//             NSError *error = nil;
//             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//             NSLog(@"我的功能：%@",rootDic);
//             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
//             int inta = [a intValue];
//             if (inta==1000)
//             {
//                 //取出源item数据
//                 NSArray *kindarr = self.allArray[btn.section - 1];
//                 NSDictionary *btndic = kindarr[btn.row];
//                 //从资源数组中该数据
//                 [self.array addObject:btndic];
//                 [self.collectionView reloadData];
//
//                 //                 NSArray *arrr = [self getArrFormDic:arr];
//             }else if (inta == 3004){
//                 //添加重新登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
//                 return;
//             }else if(inta == 3005){
//                 //添加未登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
//                 return;
//             }
//         }
//     }];

    
}

#pragma mark---btn的移动cell事件

- (void)btnChange{
    
//    //cell的隐藏删除设置
//    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
//    // 找到当前的cell
//    GongnengCell *cell = (GongnengCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
//    cell.btnAdd.hidden = NO;
//    
//    //取出源item数据
//    NSArray *kindarr = self.allArray[btn.section - 1];
//    NSDictionary *btndic = kindarr[btn.row];
//    NSString *btn_id = [NSString stringWithFormat:@"%@",btndic[@"id"]];
//    NSString *btn_sid = [NSString stringWithFormat:@"%@",btndic[@"s_id"]];
    NSMutableArray *mArr = [NSMutableArray array];
    for (int num = 0; num < self.array.count; num++) {
        NSDictionary *dic = self.array[num];
        NSString *m_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
        NSDictionary *mdic = [NSDictionary dictionaryWithObject:m_id forKey:@"id"];
        [mArr addObject:mdic];
    }
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",user.session,@"session",mArr,@"id_list",nil];
//    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
//    NSLog(@"%@",str1);
//    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//
//    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_09 Paramters:Str
//                        FinishCallbackBlock:^(NSString *result)
//     {
//         if (result.length<=0)
//         {
//             //网络不好时提示
//             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
//         }
//         else
//         {
//             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
//             SBJsonParser *parser = [[SBJsonParser alloc] init];
//             NSError *error = nil;
//             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//             NSLog(@"我的功能：%@",rootDic);
//             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
//             int inta = [a intValue];
//             if (inta==1000)
//             {
//                 [self.collectionView reloadData];
//
//                 //                 NSArray *arrr = [self getArrFormDic:arr];
//             }else if (inta == 3004){
//                 //添加重新登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
//                 return;
//             }else if(inta == 3005){
//                 //添加未登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
//                 return;
//             }
//         }
//     }];
//
    
}



/*
 获取全部功能键数据
 */
- (void)startRequestForItemArr{
    
    
    NSArray *nameArr2 = @[@"路况查询",@"公交查询",@"报名入口",@"智慧停车",@"公积金查询",@"就医挂号",@"生活缴费"];
    NSArray *imageNameArr2 = @[@"more_lukuangchaxun",@"more_gongjiaochaxun",@"more_baomingrukou",@"more_zhihuitingche",@"more_gongjijinchaxun",@"more_jiuyiguahao",@"more_shenghuojiaofei"];
    
    NSMutableArray *otherArr = [NSMutableArray array];
    
    for (int n = 0; n<nameArr2.count; n++) {
        NSString *nameStr = [NSString stringWithFormat:@"%@",nameArr2[n]];
        NSString *imageStr = [NSString stringWithFormat:@"%@",imageNameArr2[n]];
        NSDictionary *Dic = [NSDictionary dictionaryWithObjectsAndKeys:nameStr,@"name",imageStr,@"imagestr",@"政务服务",@"s_name",nil];
        [otherArr addObject:Dic];
    }
    for (int n = 0; n<nameArr2.count; n++) {
        NSString *nameStr = [NSString stringWithFormat:@"%@",nameArr2[n]];
        NSString *imageStr = [NSString stringWithFormat:@"%@",imageNameArr2[n]];
        NSDictionary *Dic = [NSDictionary dictionaryWithObjectsAndKeys:nameStr,@"name",imageStr,@"imagestr",@"公共服务",@"s_name",nil];
        [otherArr addObject:Dic];
    }
    
    
    NSArray *arrr = [self getArrFormDic:otherArr];
    [self.allArray removeAllObjects];
    [self.allArray addObjectsFromArray:arrr];
    [self.collectionView reloadData];
    //    MBProgressHUD *hud = [SurveyRunTimeData showloadHudWithView:self.view withStr:@"正在加载..."];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",nil];
//    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
//    NSLog(@"%@",str1);
//    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//
//    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_06 Paramters:Str
//                        FinishCallbackBlock:^(NSString *result)
//     {
//         if (result.length<=0)
//         {
//             //网络不好时提示
//             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
//         }
//         else
//         {
//             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
//             SBJsonParser *parser = [[SBJsonParser alloc] init];
//             NSError *error = nil;
//             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//             NSLog(@"全部功能：%@",rootDic);
//             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
//             int inta = [a intValue];
//             if (inta==1000)
//             {
//                 NSLog(@"全部功能：%@",rootDic);
//                 NSArray *arr = rootDic[@"info"];
//                 NSArray *arrr = [self getArrFormDic:arr];
//                 [self.allArray removeAllObjects];
//                 [self.allArray addObjectsFromArray:arrr];
//                 [self.collectionView reloadData];
//             }else if (inta == 3004){
//                 //添加重新登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
//                 return;
//             }else if(inta == 3005){
//                 //添加未登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
//                 return;
//             }
//         }
//     }];
}

/*
 获取我的功能键数据
 */
- (void)startRequestForMyItemArr{
    
    
    NSArray *nameArr = @[@"公积金查询",@"社保查询",@"个税查询",@"生活缴费",@"违章查询",@"就医挂号",@"办事查询"];
    NSArray *imageNameArr = @[@"more_gongjijinchaxun",@"more_shebaochaxun",@"more_geshuichaxun",@"more_shenghuojiaofei",@"more_weizhangchaxun",@"more_yuyueguahao",@"more_banshichaxun"];
    NSMutableArray *MyArr = [NSMutableArray array];
    for (int n = 0; n<nameArr.count; n++) {
        NSString *nameStr = [NSString stringWithFormat:@"%@",nameArr[n]];
        NSString *imageStr = [NSString stringWithFormat:@"%@",imageNameArr[n]];
        NSDictionary *Dic = [NSDictionary dictionaryWithObjectsAndKeys:nameStr,@"name",imageStr,@"imagestr",nil];
        [MyArr addObject:Dic];
    }
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:MyArr];
    [self.collectionView reloadData];
    
    //    MBProgressHUD *hud = [SurveyRunTimeData showloadHudWithView:self.view withStr:@"正在加载..."];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:user.currentAddress.city_id,@"city_id",user.currentAddress.area_id,@"area_id",user.currentAddress.agency_id,@"agency_id",user.currentAddress.community_id,@"community_id",user.currentAddress.quarter_id,@"quarter_id",user.session,@"session",nil];
//    NSString *str1 = [SurveyRunTimeData dictionaryToJson:dic];
//    NSLog(@"%@",str1);
//    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//    
//    [HttpPostExecutor postExecuteWithUrlStr:HomeMainFunction_m53_05 Paramters:Str
//                        FinishCallbackBlock:^(NSString *result)
//     {
//         if (result.length<=0)
//         {
//             //网络不好时提示
//             [SurveyRunTimeData showWithView:self.view withRequestStr:@"10000"];
//         }
//         else
//         {
//             NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:result];
//             SBJsonParser *parser = [[SBJsonParser alloc] init];
//             NSError *error = nil;
//             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//             NSLog(@"我的功能：%@",rootDic);
//             NSString *a=[NSString stringWithFormat:@"%@",[rootDic objectForKey:@"ecode"]];
//             int inta = [a intValue];
//             if (inta==1000)
//             {
//                 NSLog(@"我的功能：%@",rootDic);
//                 NSArray *arr = rootDic[@"info"];
//                 [self.array removeAllObjects];
//                 [self.array addObjectsFromArray:arr];
//                 [self.collectionView reloadData];
////                 NSArray *arrr = [self getArrFormDic:arr];
//             }else if (inta == 3004){
//                 //添加重新登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_DengLuChaoShi object:nil];
//                 return;
//             }else if(inta == 3005){
//                 //添加未登录的通知
//                 [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
//                 return;
//             }
//         }
//     }];
}

//功能数据转化
- (NSArray *)getArrFormDic:(NSArray *)classDic{
    NSMutableArray *cArr = [NSMutableArray array];

    [self.titileArr removeAllObjects];
    for (NSDictionary *dic in classDic) {
        NSString *oneStr = [NSString stringWithFormat:@"%@",dic[@"s_name"]];
        BOOL isAdd = YES;
        for (int n = 0; n < self.titileArr.count; n++) {
            NSString *str = self.titileArr[n];
            if ([str isEqualToString:oneStr]) {
                NSMutableArray *muArr = [NSMutableArray arrayWithArray:cArr[n]];
                [muArr addObject:dic];
                [cArr replaceObjectAtIndex:n withObject:muArr];
                isAdd = NO;
                break;
            }
        }
        if (isAdd) {
            [self.titileArr addObject:oneStr];
            NSArray *arr = [NSArray arrayWithObject:dic];
            [cArr addObject:arr];
        }
    }
    [self.titileArr insertObject:@"我的功能" atIndex:0];

    NSLog(@"titileArr:%@",self.titileArr);
    return cArr;
}




@end
