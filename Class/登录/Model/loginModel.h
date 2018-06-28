//
//  loginModel.h
//  Class
//
//  Created by liuningbo on 2018/6/26.
//  Copyright © 2018年 zht. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^loginblock)(id responseObj);

@interface loginModel : NSObject
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *PassWord;
+(instancetype)ShareInstance;

-(void)LoginSubmit:(NSDictionary *)dic SuccessBlock:(void (^)(void))loginsuccess FailBlock:(void (^)(void))failblock;


@end
