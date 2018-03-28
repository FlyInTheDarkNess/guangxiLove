//
//  ToDoViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/16.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController ()

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"待办事项";
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0f/255 green:247.0f/255 blue:247.0f/255 alpha:1];
    
    UIScrollView *scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT - 64)];
    UIImage *image = [UIImage imageNamed:@"ToDo"];
    float height = image.size.height;
    float width = image.size.width;
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  MY_WIDTH,height *(MY_WIDTH /width))];
    imageV.image = image;
    [scorllView addSubview:imageV];
    [scorllView setContentSize:imageV.size];
    [self.view addSubview:scorllView];    // Do any additional setup after loading the view.
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
