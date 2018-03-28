//
//  IFMQViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/20.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "IFMQViewController.h"
#import "IFMQCell.h"

@interface IFMQViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic,strong) NSMutableArray *InfoArr;

@end

@implementation IFMQViewController

- (NSMutableArray *)InfoArr{
    if (!_InfoArr) {
        _InfoArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _InfoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat headerHeight = 170  * BILI_375 + SEGMENT_HEIGHT;
    // 假的tableview，高度同GameDetailHeadView
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headerHeight)];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"IFMQCell" bundle:nil] forCellReuseIdentifier:@"IFMQCell"];
    for (int n = 0; n < 10; n++) {
        NSString *IFMQInfo = [NSString stringWithFormat:@"IFMQInfo%d",arc4random() % 2 + 1];
        NSDictionary *dic = @{@"image":IFMQInfo};
        [_InfoArr addObject:dic];
    }
    [self.tableView reloadData];
    
    //cell下划线
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    // Do any additional setup after loading the view.
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

#pragma mark Table delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseidentifier = @"IFMQCell";
    IFMQCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier];
    if (!cell) {
        cell = [[IFMQCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifier];
    }
    NSDictionary *dic = _InfoArr[indexPath.row];
    cell.Dic = dic;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.InfoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _InfoArr[indexPath.row];
    NSString *imageName = [NSString stringWithFormat:@"%@",dic[@"image"]];
    if ([imageName isEqualToString:@"IFMQInfo2"]) {
        return 230 *BILI_375;
    }else{
        return 110 *BILI_375;
    }
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
