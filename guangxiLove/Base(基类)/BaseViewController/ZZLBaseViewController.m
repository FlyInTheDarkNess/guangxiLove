//
//  ZZLBaseViewController.m
//  ZHSQ
//
//  Created by 赵中良 on 15/9/15.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "ZZLBaseViewController.h"
#import "NSString+SringNull.h"
@interface ZZLBaseViewController ()

@end

@implementation ZZLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.navigationController.viewControllers.count > 1) {
        if (self.leftButtonType == ButtonTypeNone) {
            self.navigationItem.leftBarButtonItem = nil;
        }else{
            [self setLeftButtonType: ButtonTypeBack];
        }
    }
    // Do any additional setup after loading the view.
}

-(void)setLeftButtonType:(ButtonType)leftButtonType{
    switch (leftButtonType) {
            //左键为返回键
        case ButtonTypeBack:
        {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"erweima_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToLastView:)];
        }
            break;
            
        default:
            self.navigationItem.leftBarButtonItem = nil;
            break;
    }
}



- (IBAction)backToLastView:(id)sender{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
