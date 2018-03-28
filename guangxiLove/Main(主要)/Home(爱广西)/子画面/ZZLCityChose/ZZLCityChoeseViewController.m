//
//  ZZLCityChoeseViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/16.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ZZLCityChoeseViewController.h"

@interface ZZLCityChoeseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *MTableView;
}

@property (nonatomic,strong)NSArray *CityArr;

@end

@implementation ZZLCityChoeseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择城市";
    
    MTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT) style:UITableViewStyleGrouped];
    MTableView.delegate = self;
    MTableView.dataSource = self;
    //cell下划线
    [MTableView setSeparatorInset:UIEdgeInsetsZero];
    [MTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:MTableView];
    
    _CityArr = @[@"南宁",@"柳州",@"桂林",@"梧州",@"北海",@"防城港",@"钦州",@"贵港",@"玉林",@"百色",@"贺州",@"河池",@"来宾",@"崇左",@"岑溪",@"东兴",@"桂平",@"北流",@"靖西",@"宜州",@"合山",@"萍乡"];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)setCityArr:(NSArray *)CityArr{
    _CityArr = CityArr;
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
    cell.textLabel.text = _CityArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _CityArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewCell *header = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_WIDTH)];
    header.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    header.imageView.image = [UIImage imageNamed:@"location"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"当前定位城市：梧州"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,7)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(7,2)];
    header.textLabel.attributedText = str;
    header.textLabel.font = [UIFont systemFontOfSize:14];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController popViewControllerAnimated:YES];
    NSString *str = _CityArr[indexPath.row];;
    [_Bringdelegate bringWithItemId:str];
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
