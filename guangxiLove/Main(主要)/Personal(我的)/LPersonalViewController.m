//
//  LPersonalViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/8.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "LPersonalViewController.h"
#import "AppDelegate.h"
#import "SVProgressHUD+Helper.h"
#import "TDTouchID.h" //指纹识别
#import "ZZLSetViewController.h" //
#import "LPersonFooterCell.h"
#import "LPersonMoreCell.h"
#import "LPKaCell.h"
#import "LPersonHeaderCell.h"

@interface LPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic,strong) UITableView *tableView;
/**
 退出登录
 */
@property (nonatomic, strong) UIButton *logoutBtn;

/**
 跳转
 */
@property (nonatomic, strong) UIButton *pushBtn;

@end

@implementation LPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LPersonFooterCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LPersonFooterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPersonMoreCell" bundle:nil] forCellReuseIdentifier:@"LPersonMoreCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPersonHeaderCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LPersonHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LPKaCell" bundle:nil] forHeaderFooterViewReuseIdentifier:@"LPKaCell"];
    //cell下划线
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    
}

#pragma mark Table delegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseidentifier = @"LPersonMoreCell";
    LPersonMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier];
    if (!cell) {
        cell = [[LPersonMoreCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifier];
    }
    switch (indexPath.row) {
        case 0:
            cell.nameStr = @"收藏";
            break;
        case 1:
            cell.nameStr = @"订单";
            break;
        case 2:
            cell.nameStr = @"设置";
            break;
            
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    else{
        return 3;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        NSString *reuseidentifier = @"LPersonHeaderCell";
//        LPersonHeaderCell *cell = (LPersonHeaderCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseidentifier];
//        if (!cell) {
//            cell = [[LPersonHeaderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifier];
//        }
        
        LPersonHeaderCell *cell;
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LPersonHeaderCell" owner:self options:nil];
            cell = nib[0];
        }
        cell.Dic =@{};
        
        return cell;
    }
    
    NSString *reuseidentifier = @"LPKaCell";
//    LPKaCell *cell = (LPKaCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseidentifier];
//    if (!cell) {
//        cell = [[LPKaCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifier];
//    }
    LPKaCell *cell;
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LPKaCell" owner:self options:nil];
        cell = nib[0];
    }
    cell.dic = @{};
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
//        NSString *reuseidentifier = @"LPersonFooterCell";
//        LPersonFooterCell *cell = (LPersonFooterCell *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseidentifier];
//        if (!cell) {
//            cell = [[LPersonFooterCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseidentifier];
//        }
        LPersonFooterCell *cell;
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LPersonFooterCell" owner:self options:nil];
            cell = nib[0];
        }
        return cell;
    }
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 140;
    }else if (section == 1){
        return 100;
    }
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        ZZLSetViewController *setVC = [[ZZLSetViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, MY_WIDTH, MY_HEIGHT - 20) style: UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark 跳转
/**
 * 跳转设置
 */
-(IBAction)turnToSetting:(id)sender{
    ZZLSetViewController *setVC = [[ZZLSetViewController alloc]init];
    setVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fk_initialDefaultsForController
{
    
}

- (void)fk_configNavigationForController
{
    
}

- (void)fk_createViewForConctroller
{
    [self.view addSubview:self.logoutBtn];
    [self.view addSubview:self.pushBtn];
    
    [self.view setNeedsUpdateConstraints];
}

-(void)fk_bindViewModelForController
{
    [[self.logoutBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLogin"];
        [SVProgressHUD fk_dispalyMsgWithStatus:@"2秒后将退出登录"];
        [SVProgressHUD dismissWithDelay:2.0f completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:FKLoginStateChangedNotificationKey object:nil];
        }];
    }];
    
    // push
    [[self.pushBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        TDTouchID *touchID = [[TDTouchID alloc] init];
        
        [touchID td_showTouchIDWithDescribe:nil BlockState:^(TDTouchIDState state, NSError *error) {
            
            if (state == TDTouchIDStateNotSupport) {    //不支持TouchID
                
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"当前设备不支持TouchID" message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alertview.alertViewStyle = UIAlertViewStyleSecureTextInput;
                [alertview show];
                
                
            } else if (state == TDTouchIDStateSuccess) {    //TouchID验证成功
                
                NSLog(@"jump");
                [SVProgressHUD fk_dispalyMsgWithStatus:@"TouchID验证成功"];
                [SVProgressHUD dismissWithDelay:2.0f completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:FKLoginStateChangedNotificationKey object:nil];
                }];
            } else if (state == TDTouchIDStateInputPassword) { //用户选择手动输入密码
                
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"请输入密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alertview.alertViewStyle = UIAlertViewStyleSecureTextInput;
                [alertview show];
                
            }
            
            // ps:以上的状态处理并没有写完全!
            // 在使用中你需要根据回调的状态进行处理,需要处理什么就处理什么
            
            
            
        }];
        /*
        NSString *router = [JLRoutes fk_generateURLWithPattern:FKNavPushRoute parameters:@[NSStringFromClass(LPersonalViewController.class)] extraParameters:nil];
        [[RACScheduler mainThreadScheduler] schedule:^{
            
            [[UIApplication sharedApplication] openURL:JLRGenRouteURL(FKDefaultRouteSchema, router)];
        }];
         */
    }];
}

#pragma mark - Layout
- (void)updateViewConstraints
{
    NSArray *views = @[self.pushBtn, self.logoutBtn];
    CGFloat offset = SCREEN_HEIGHT/3;
    
    [views mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:40 leadSpacing:offset tailSpacing:offset];
    
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Getter
- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _logoutBtn;
}

- (UIButton *)pushBtn
{
    if (!_pushBtn) {
        _pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushBtn setTitle:@"指纹识别" forState:UIControlStateNormal];
        _pushBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _pushBtn;
}

@end
