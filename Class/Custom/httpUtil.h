//
//  httpUtil.h
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface httpUtil : NSObject
// GET请求
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError * error))failure;


// POST请求
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

// 上传图片
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)(id responseObject))success
                             failure:(void (^)(NSError *error))failure;
//网络状态
//第一种
+(void)InterNetStatus;
//第二种
//+(void)internetStatus;
//-(void)getNetType;//蜂窝数据下的网络类型，eg：4g 3g。
@end
