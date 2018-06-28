//
//  loginModel.m
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "loginModel.h"
#import "httpUtil.h"

@implementation loginModel
static loginModel * _instance = nil;

+(instancetype)ShareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance ==nil) {
        _instance = [[super allocWithZone:NULL] init];
        }
    });
    return _instance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [loginModel ShareInstance];
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [loginModel ShareInstance];
}
-(void)LoginSubmit:(NSDictionary *)dic SuccessBlock:(void (^)(void))loginsuccess FailBlock:(void (^)(void))failblock{
    
    [httpUtil getWithURLString:@"http:www.weather.com.cn/data/sk/101010100.html" parameters:nil success:^(id responseObject) {
                loginsuccess();
                //在这处理服务器返回的数据
    } failure:^(NSError *error) {
                failblock();

    }];
//    [httpUtil postWithURLString:@"http:www.weather.com.cn/data/sk/101010100.html" parameters:dic success:^(id responseObject) {
//        loginsuccess();
//    } failure:^(NSError *error) {
//        failblock();
//    }];
}

@end
