//
//  ViewController.m
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "ViewController.h"
#import "loginModel.h"
#import "LoginView.h"
#import "RegisterViewController.h"

#import "SVProgressHUD.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LoginView *view = [[LoginView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
//    typeof(self) __weak weakSelf = self;
    //登录按钮的回调
    view.loginClickedBlock = ^(NSString *UserName, NSString *PassWord) {

        [[loginModel ShareInstance] LoginSubmit:nil SuccessBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"登陆成功！"];
            
        } FailBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"登陆失败！"];
        }];
        
    };
    //注册按钮的回掉
    view.RegisterBlock = ^{
        RegisterViewController *regist = [[RegisterViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:regist];
        regist.window = self.window;
        self.window.rootViewController = nav;
    };
    view.isShowX = NO;
    [self.view addSubview:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
