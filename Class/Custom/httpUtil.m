//
//  httpUtil.m
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//

#import "httpUtil.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "SVProgressHUD.h"

@implementation httpUtil
#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError * error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        [formData appendPartWithFileData:uploadData name:uploadName fileName:uploadName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 上传多张图片  uploadDatas 图片的data集合
// uploadName 文件名称 最好以xxx1  xxx2 表示 image1 image2
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        for (int i=0; uploadDatas.count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@[%i]", uploadName, i];
            [formData appendPartWithFileData:uploadDatas[i] name:uploadName fileName:imageName mimeType:@"image/png"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)DownLoadWithUrlString:(NSString *)URLString
                  parameters:(id)parameters
                    progress:(void (^)(id))progress
                     success:(void(^)(NSURL *filePath))success
{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    URLString=[self DownLoadUrlWithParams:URLString WithNSDictionaryParams:parameters];
    NSLog(@"DownLoadFileUrl %@",URLString);
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //        //下载地址
        //        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        filePath=[filePath stringByAppendingPathComponent:@"DFU.zip"];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (success) {
            success(filePath);
        }
    }];
    
    //开始启动任务
    [task resume];
    
}
//因为下载的方法不能够直接填写dict参数进去，所以只有使用这种方法拼接参数进去
+(NSString *)DownLoadUrlWithParams:(NSString*)url WithNSDictionaryParams:(NSDictionary *)params{
    
    // 初始化参数变量
    NSString *body=@"";
    // 快速遍历参数数组
    NSString* appendUrl;
    for(id key in params) {
        NSLog(@"key :%@  value :%@", key, [params objectForKey:key]);
        body = [body stringByAppendingString:key];
        body = [body stringByAppendingString:@"="];
        body = [body stringByAppendingString:[params objectForKey:key]];
        body = [body stringByAppendingString:@"&"];
    }
    // 处理多余的&以及返回含参url
    if (body.length > 1) {
        // 去掉末尾的&
        body = [body substringToIndex:body.length - 1];
        // 返回含参url
    }
    appendUrl=[url stringByAppendingString:body];
    return appendUrl;
}
#pragma mark - 判断网络状态
//1.
+(void)InterNetStatus{
    
AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
// 设置开始监听在设置setReachabilityStatusChangeBlock之前
[manager startMonitoring];
// 设置网络监听
[manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    /**
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1, // 为止网络
     AFNetworkReachabilityStatusNotReachable     = 0, // 没有联网
     AFNetworkReachabilityStatusReachableViaWWAN = 1, // 手机自带网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2, // WIFI
     };
     */
    NSLog(@"--------------%ld", status);
    if (status == AFNetworkReachabilityStatusUnknown) {
        [SVProgressHUD showErrorWithStatus:@"未知网络！"];
    }else if (status ==AFNetworkReachabilityStatusNotReachable){
        [SVProgressHUD showErrorWithStatus:@"没有网络！"];

    }else if (status ==AFNetworkReachabilityStatusReachableViaWWAN){
        [SVProgressHUD showInfoWithStatus:@"蜂窝数据！"];

    }else if (status ==AFNetworkReachabilityStatusReachableViaWiFi){
        [SVProgressHUD showInfoWithStatus:@"WI-FI网络！"];
    }
   }];
}

////2. 工程中加入框架SystemConfiguration.framework.
//+(void)internetStatus{
//
//    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
//    NSString *net = @"";
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetType) name:kReachabilityChangedNotification object:nil];
//
//    switch (internetStatus) {
//        case ReachableViaWiFi:
//            net = @"WIFI";
//            [SVProgressHUD showInfoWithStatus:@"WI-FI网络！"];
//
//            break;
//
//        case ReachableViaWWAN:
//            net = @"蜂窝数据";
//            [SVProgressHUD showInfoWithStatus:@"蜂窝数据！"];
//            break;
//
//        case NotReachable:
//            net = @"当前无网路连接";
//            [SVProgressHUD showErrorWithStatus:@"没有网络！"];
//        default:
//            break;
//    }
//
//}
//-(void)getNetType
//{
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    NSString *currentStatus = info.currentRadioAccessTechnology;
//    if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
//        [SVProgressHUD showInfoWithStatus:@"GPRS"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
//        [SVProgressHUD showInfoWithStatus:@"2.75G EDGE"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
//        [SVProgressHUD showInfoWithStatus:@"3G"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
//        [SVProgressHUD showInfoWithStatus:@"3.5G HSDPA"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
//        [SVProgressHUD showInfoWithStatus:@"3.5G HSUPA"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
//       [SVProgressHUD showInfoWithStatus:@"2G"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
//        [SVProgressHUD showInfoWithStatus:@"3G"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
//        [SVProgressHUD showInfoWithStatus:@"3G"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
//        [SVProgressHUD showInfoWithStatus:@"3G"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
//        [SVProgressHUD showInfoWithStatus:@"HRPD"];
//    }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
//        [SVProgressHUD showInfoWithStatus:@"4G"];
//    }
//}


@end
