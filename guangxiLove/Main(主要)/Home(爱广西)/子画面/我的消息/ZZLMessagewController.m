//
//  ZZLMessagewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/16.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ZZLMessagewController.h"

@interface ZZLMessagewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *MTableView;
}
@property (nonatomic,strong)NSArray *MessageArr;
@property (nonatomic,strong)NSArray *HeightArr;
@end

@implementation ZZLMessagewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的消息";
    
    MTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT) style:UITableViewStyleGrouped];
    MTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    MTableView.delegate = self;
    MTableView.dataSource = self;
    //cell下划线
    [MTableView setSeparatorInset:UIEdgeInsetsZero];
    [MTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:MTableView];
    
    _MessageArr = @[@"message1",@"message2",@"message3",@"message4"];
    
    _HeightArr = @[@237.0f,@266.0f,@261.0f,@240.0f];
    
    
    // Do any additional setup after loading the view.
}

-(void)setMessageArr:(NSArray *)MessageArr{
    _MessageArr = MessageArr;
    [MTableView reloadData];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseid = [NSString stringWithFormat:@"%d",indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseid];
        float bili = 320.0f/750;
        float height = [_HeightArr[indexPath.section] floatValue] *bili *BILI_m;
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, height)];
        NSString *imageStr = [NSString stringWithFormat:@"%@",_MessageArr[indexPath.section]];
        imageV.image = [UIImage imageNamed:imageStr];
        [cell.contentView addSubview:imageV];
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _MessageArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float bili = 320.0f/750;
    float height = [_HeightArr[indexPath.section] floatValue] *bili *BILI_m;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES ];
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
