//
//  ElectronicCardViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/16.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ElectronicCardViewController.h"

@interface ElectronicCardViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *MTableView;
}
@property (nonatomic,strong)NSArray *CardArr;

@end

@implementation ElectronicCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"会员介绍";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT - 64)];
    UIImage *image = [UIImage imageNamed:@"per_grade"];
    float height = image.size.height;
    float width = image.size.width;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  MY_WIDTH,height *(MY_WIDTH /width))];
    imageV.image = image;
    [scorllView addSubview:imageV];
    [scorllView setContentSize:imageV.size];
    [self.view addSubview:scorllView];
    
    /*
    self.navigationItem.title = @"电子卡证";
    
    MTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT) style:UITableViewStyleGrouped];
    MTableView.delegate = self;
    MTableView.dataSource = self;
    //cell下划线
    [MTableView setSeparatorInset:UIEdgeInsetsZero];
    [MTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:MTableView];
    
    _CardArr = @[@"身份证",@"驾驶证",@"行驶证",@"社会保障卡",@"护照"];
     */
    // Do any additional setup after loading the view.
}

-(void)setCardArr:(NSArray *)CardArr{
    _CardArr = CardArr;
    [MTableView reloadData];
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseid = @"CityNameCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseid];
    }
    cell.textLabel.text = _CardArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _CardArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
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
