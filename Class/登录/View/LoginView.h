//
//  LoginView.h
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LoginView : UIView<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *BGImageView;
@property (nonatomic,strong) UITextField *accountTextField;
@property (nonatomic,strong) UITextField *pwdTextField;
@property (nonatomic,assign) BOOL isShowX;//是否显示左上角x

@property(nonatomic,strong)void(^loginClickedBlock)(NSString *UserName,NSString *PassWord);
@property(nonatomic,strong)void(^RegisterBlock)(void);

@end
