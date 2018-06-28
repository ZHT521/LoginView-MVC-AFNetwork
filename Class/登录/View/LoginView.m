//
//  LoginView.m
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//


#import "LoginView.h"
#import "macro.h"

@implementation LoginView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUI];
    }
    return self;
}
-(void)CreateUI{
    //登录背景图片
    self.BGImageView = [[UIImageView alloc]initWithFrame:self.frame];
    self.BGImageView.image = [UIImage imageNamed:LoginBGView];
    [self addSubview:self.BGImageView];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {//毛玻璃效果
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        blurEffectView.frame = self.BGImageView.bounds;
        [self.BGImageView addSubview:blurEffectView];
    }
    
    //用户名
    UIImageView *imagVTouxiang = [[UIImageView alloc]initWithFrame:CGRectMake(40, self.center.y-55, 40, 30)];
    imagVTouxiang.image = [UIImage imageNamed:@"用户头像"];
    [self addSubview:imagVTouxiang];
    self.accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(imagVTouxiang.frame.origin.x+40, self.center.y-60, self.frame.size.width-160, 40)];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:248 green:248 blue:255 alpha:0.4],NSFontAttributeName:self.accountTextField.font}];//Placeholder字体颜色
    self.accountTextField.attributedPlaceholder = attrString;
    self.accountTextField.textColor = [UIColor whiteColor];
    self.accountTextField.delegate = self;
    [self addSubview:self.accountTextField];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(40, self.accountTextField.frame.origin.y+self.accountTextField.frame.size.height, self.frame.size.width-80, 1)];
    line1.backgroundColor = [UIColor colorWithRed:215 green:222 blue:230 alpha:0.4];
    [self addSubview:line1];
    
    //密码
    UIImageView *imagVPassword = [[UIImageView alloc]initWithFrame:CGRectMake(40, self.center.y-5, 40, 30)];
    imagVPassword.image = [UIImage imageNamed:@"用户密码"];
    [self addSubview:imagVPassword];
    self.pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(imagVPassword.frame.origin.x+40, self.center.y-10, self.frame.size.width-160, 40)];
    self.pwdTextField.secureTextEntry = YES;
    NSAttributedString *attrString2 = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:215 green:222 blue:230 alpha:0.4],NSFontAttributeName:self.pwdTextField.font}];//Placeholder字体颜色
    self.pwdTextField.attributedPlaceholder = attrString2;
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.delegate = self;
    [self addSubview:self.pwdTextField];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(40, self.pwdTextField.frame.origin.y+self.pwdTextField.frame.size.height, self.frame.size.width-80, 1)];
    line2.backgroundColor = [UIColor colorWithRed:215 green:222 blue:230 alpha:0.4];
    [self addSubview:line2];
    
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width/2, 40)];
    loginBtn.center = CGPointMake(self.center.x, self.center.y+80);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor orangeColor]];
    loginBtn.layer.cornerRadius = 5;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.showsTouchWhenHighlighted = YES;
    [self addSubview:loginBtn];
    //忘记密码
    UIButton *btnForgotPassword = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 80, 20)];
    btnForgotPassword.center = CGPointMake(self.center.x, self.center.y+120);
    btnForgotPassword.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnForgotPassword setTitle:@"忘记密码？" forState:UIControlStateNormal];
    btnForgotPassword.showsTouchWhenHighlighted = YES;
    [self addSubview:btnForgotPassword];
    
    
    //其它登录方式
    UILabel *labOthers = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4, 30)];
    labOthers.center = CGPointMake(self.center.x,btnForgotPassword.frame.origin.y+btnForgotPassword.frame.size.height+60);
    labOthers.textColor = [UIColor colorWithRed:215 green:222 blue:230 alpha:0.8];
    labOthers.text = @"其他登录";
    labOthers.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labOthers];
    UIView *lineLeft = [[UIView alloc]initWithFrame:CGRectMake(40,labOthers.frame.origin.y+15, self.frame.size.width/4, 1)];
    lineLeft.backgroundColor = [UIColor colorWithRed:215 green:222 blue:230 alpha:0.2];
    [self addSubview:lineLeft];
    UIView *lineright = [[UIView alloc]initWithFrame:CGRectMake(labOthers.frame.origin.x+labOthers.frame.size.width,labOthers.frame.origin.y+15, self.frame.size.width/4, 1)];
    lineright.backgroundColor = [UIColor colorWithRed:215 green:222 blue:230 alpha:0.2];
    [self addSubview:lineright];
//    /******计算一下剩余的底部高度****/
//    CGSize size =CGSizeMake(self.frame.size.width,self.frame.size.height - (labOthers.frame.origin.y+labOthers.frame.size.height));
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40+i*(40+(self.frame.size.width-160)/3),labOthers.frame.origin.y+labOthers.frame.size.height+10, (self.frame.size.width-160)/3, (self.frame.size.width-160)/3)];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"WeiXin"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(OthersLoginTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.showsTouchWhenHighlighted = YES;
        [self addSubview:btn];
    }
    
    //注册按钮
    UIButton *btnRegister;
    if (KIsiPhoneX) {
      btnRegister = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-80,44, 60, 44)];
    }else{
      btnRegister = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-80,22, 60, 44)];
    }
    [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(RegisterClicked) forControlEvents:UIControlEventTouchUpInside];
    btnRegister.showsTouchWhenHighlighted = YES;
    [self addSubview:btnRegister];
    
    //左边x按钮  如果是进入就调用登录界面的 就可以隐藏不显示
    UIButton *btnCancel;
    if (KIsiPhoneX) {
        btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(10,44, 60, 44)];
    }else{
        btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(10,22, 60, 44)];
    }
    [btnCancel setTitle:@"x" forState:UIControlStateNormal];
    btnCancel.showsTouchWhenHighlighted = YES;
    [self addSubview:btnCancel];

}

#pragma mark Event Handle
- (void)login
{

    if (self.loginClickedBlock) {
        self.loginClickedBlock(self.accountTextField.text,self.pwdTextField.text);
    }
    
}
-(void)RegisterClicked{
    if (self.RegisterBlock) {
        self.RegisterBlock();
    }
}

-(void)OthersLoginTypeClicked:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            NSLog(@"=%ld,微信登录",(long)btn.tag);
            break;
        case 1:
            NSLog(@"=%ld,微博登录",(long)btn.tag);
            break;
        case 2:
            NSLog(@"=%ld,QQ登录",(long)btn.tag);
            break;
            
        default:
            break;
    }
}

#pragma mark - TextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.accountTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
    
    [UIView commitAnimations];
    
}
-(BOOL)textFielddBeginEditing:(UITextField *)textField{
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.accountTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
