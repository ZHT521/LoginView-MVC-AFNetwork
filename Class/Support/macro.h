//
//  macro.h
//  Class
//
//  Created by liuningbo on 2018/6/28.
//  Copyright © 2018年 zht. All rights reserved.
//

#ifndef macro_h
#define macro_h

#define Width [[UIScreen mainScreen] bounds].size.width
#define Height [[UIScreen mainScreen] bounds].size.height
//判断是否是 iPhone X
#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define LoginBGView @"img1"//登录页面背景图片


#endif /* macro_h */
