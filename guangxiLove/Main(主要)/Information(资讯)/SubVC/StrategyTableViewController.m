//
//  StrategyTableViewController.m
//  NestedPage
//
//  Created by Xing on 2017/12/25.
//  Copyright © 2017年 HasjOH. All rights reserved.
//

#import "StrategyTableViewController.h"
#import "HomeTableViewCell.h"

@interface StrategyTableViewController ()

@end

@implementation StrategyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    CGFloat headerHeight = 170  * BILI_375 + SEGMENT_HEIGHT;
    // 假的tableview，高度同GameDetailHeadView
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, headerHeight)];
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 其余为资讯cell
    static NSString *reuseId = @"infocell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell = nib[0];
    } 
    cell.cellData = [NSDictionary dictionary];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
