//
//  ZZLSetViewController.m
//  guangxiLove
//
//  Created by 赵中良 on 2018/3/14.
//  Copyright © 2018年 赵中良. All rights reserved.
//

#import "ZZLSetViewController.h"
#import "AppDelegate.h"
//extern UserInfo *user;
@interface ZZLSetViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UITableView *MyTableView;
    BOOL isLogin;
}

@end

@implementation ZZLSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    NSNumber * number = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
    isLogin = number.boolValue;

    MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MY_WIDTH, MY_HEIGHT - 64) style:UITableViewStyleGrouped];
    MyTableView.dataSource =self;
    MyTableView.delegate = self;

    [self.view addSubview:MyTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;

        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"setid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseId];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            if (isLogin) {
                cell.textLabel.text = @"邀请好友";
                cell.detailTextLabel.text = @"";
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.text = @"";
                cell.detailTextLabel.text = @"";
            }
        }
            break;

        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    if (isLogin) {
                        cell.textLabel.text = @"个人资料";
                        cell.detailTextLabel.text = @"";
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        cell.textLabel.text = @"";
                        cell.detailTextLabel.text = @"";
                    }                }
                    break;
                case 1:
                {
                    if (isLogin) {
                        cell.textLabel.text = @"修改密码";
                        cell.detailTextLabel.text = @"";
                    }else{
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        cell.textLabel.text = @"";
                        cell.detailTextLabel.text = @"";
                    }
                }
                    break;

                default:
                    break;
            }

        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"版本号";
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                    cell.detailTextLabel.text = appCurVersion;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"清理缓存";
                    cell.detailTextLabel.text = @"0.0kb";
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"评价我们";
                    cell.detailTextLabel.text = @"";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"用户协议";
                    cell.detailTextLabel.text = @"";
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"关于我们";
                    cell.detailTextLabel.text = @"";
                }
                    break;

                default:
                    break;
            }

        }
            break;


        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (isLogin&&section == 1) {
        return 0.01;
    }
    if (isLogin&&section == 2) {
        return 0.01;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (isLogin&&section == 0) {
        return 0.01;
    }
    if (isLogin&&section == 1) {
        return 0.01;
    }
    if (section == 3) {
        return 80;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!isLogin&&indexPath.section == 0) {
        return 0.01;
    }
    if (!isLogin&&indexPath.section == 1) {
        return 0.01;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    switch (indexPath.section) {
        case 0:
        {
            if (![user.session isEmpty]) {
                //添加未登录的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:Tongzhi_WeiDengLu object:nil];
                return;
            }
            QRViewController *qVC = [[QRViewController alloc] init];
            qVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qVC animated:YES];
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    PersonalInfoViewController *perInfo = [[PersonalInfoViewController alloc]init];
                    perInfo.leftButtonType = ButtonTypeBack;
                    perInfo.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:perInfo animated:YES];
                }
                    break;
                case 1:
                {
                    [self ForgotPassword];//修改密码
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 2:
        {
#pragma 检查更新 与 清理缓存
            switch (indexPath.row) {
                case 0:
                {

                }
                    break;
                case 1:
                {
                    [SurveyRunTimeData showWithCustomView:self.view withMsg:@"清理完成！"];
                }
                    break;

                default:
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL_APPSTORE_URL]];
                }
                    break;
                case 1:
                {
                    ZZLWebViewController *about = [[ZZLWebViewController alloc]init];
                    about.requestUrl = @"http://www.xiaolianshequ.cn/download/clause.html";
                    about.leftButtonType = ButtonTypeBack;
                    about.title = @"用户协议";
                    about.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:about animated:YES];
                }
                    break;
                case 2:
                {
                    //                    aboutViewController *about = [[aboutViewController alloc]init];
                    //                    about.leftButtonType = ButtonTypeBack;
                    //                    about.hidesBottomBarWhenPushed = YES;
                    //                    [self.navigationController pushViewController:about animated:YES];

                    ZZLWebViewController *about = [[ZZLWebViewController alloc]init];
                    about.requestUrl = @"http://www.xiaolianshequ.cn/download/about.html";
                    about.leftButtonType = ButtonTypeBack;
                    about.title = @"关于我们";
                    about.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:about animated:YES];
                }
                    break;

                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
     */
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tttt"];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, MY_WIDTH, 44)];
        [btn setBackgroundColor:[UIColor colorWithHexString:@"#fe3a3c"]];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(certainToLogout) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        if (!isLogin) {
            btn.hidden = YES;
        }
        return cell;
    }
    return [[UIView alloc]init];
}

/*
 注销确认提示
 */
- (void)certainToLogout{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"是否进行以下操作"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"注销"
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //    [actionSheet showInView:self.view];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow ];
}

//Actionsheet实现点击方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self LogOut];
        }
            break;
        default:
            break;
    }
}


-(void)LogOut{
    
    // 解析数据
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLogin"];
    isLogin = NO;
    [MyTableView reloadData];
    /*
    //    极光推送标签设置
    NSArray *tagarr=[[NSArray alloc] initWithObjects:@"",nil];
    //极光推送标签别名设置
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) SetTag:tagarr withAlias:@"100"];
     */
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    [userDefaulte setObject:@"" forKey:@"denglu_mima"];
    [userDefaulte synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
    //退出
    [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLogin"];
    [SVProgressHUD fk_dispalyMsgWithStatus:@"2秒后将退出登录"];
    [SVProgressHUD dismissWithDelay:2.0f completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:FKLoginStateChangedNotificationKey object:nil];
    }];
}

/*
 修改密码
 */
-(void)ForgotPassword
{
//    ModifyPasswordViewController *zhaohui=[[ModifyPasswordViewController alloc]init];
//
//    [self.navigationController pushViewController:zhaohui animated:YES];
}

//appstore版本更新
-(void)Update1{
    /*
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL_APPSTORE_VERSION]];

    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        NSError *error;
        NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:&error];
        if (!error) {
            NSLog(@"%@",resultDict[@"results"]);
            NSArray *arr = resultDict[@"results"];
            NSDictionary *dic = arr.lastObject;

            NSString *NewVersion = dic[@"version"];

            NSLog(@"dic：%@",NewVersion);
            [self Update:[NewVersion floatValue]];
        }
    }
     ];
    [request setFailedBlock:^{

        //        [[UIApplication sharedApplication].keyWindow makeToast:@"网络连接失败，请检查网络设置"];
    }];
    [request startAsynchronous];
     */
}

//自动升级功能
-(void)Update:(float)NewVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);

    //    if (NewVersion <= [appCurVersion floatValue]) {
    //        //自动更新不提示，手动更新提示
    //        //        [[UIApplication sharedApplication].keyWindow makeToast:@"已是最新版本！"];
    //    }
    //    else{
    //        [self showView];
    //
    //    }
    //判断built版本号
    if (NewVersion > [appCurVersion floatValue])
    {
        NSString *newLv = [NSString stringWithFormat:@"%f",NewVersion];
        NSString *curVersion = [newLv substringToIndex:4];
        NSString *thatVersion = [appCurVersion substringToIndex:4];
        if ([curVersion isEqualToString:thatVersion]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"检测到新版本，是否立即升级？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
            alert.tag = 2;
            [alert show];
        }else{

            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"新版本更新" message:@"检测到新版本，是否立即升级？" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
            aler.tag = 2;
            [aler show];
        }
    }
}


@end
