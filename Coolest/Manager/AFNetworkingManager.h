//
//  AFNetworkingManager.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

//请求成功的回调block
//typedef void(^responseSuccess)(NSURLSessionDataTask *task, id  responseObject);
typedef void(^responseSuccess)(id successData);

//请求失败的回调block
//typedef void(^responseFailed)(NSURLSessionDataTask *task, NSError *error,id responseObject);
typedef void(^responseFailed)(NSError *error);

//文件下载的成功回调block
typedef void(^downloadSuccess)(NSURLResponse *response, NSURL *filePath);

//文件下载的失败回调block
typedef void(^downloadFailed)( NSError *error);

//文件上传下载的进度block
typedef void (^progress)(NSProgress *progress);


//请求返回模型
@interface ResponseModel : NSObject

@property (nonatomic,assign) NSInteger errorCode;

@property (nonatomic,copy) NSString *message;

@property (nonatomic,strong) id data;

@end

@interface AFNetworkingManager : NSObject

+(AFHTTPSessionManager *)shareInstance;

/**
 GET方法
 
 @param urlString url
 @param params 请求参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)GetRequestWithUrlString:(NSString *)urlString params:(NSDictionary *)params success:(responseSuccess)success failed:(responseFailed)failed;


/**
 POST方法
 
 @param urlString url
 @param params 请求参数
 @param success 成功回调
 @param failed 失败回调
 */
+(void)PostRequestWithUrlString:(NSString *)urlString params:(NSDictionary *)params success:(responseSuccess)success failed:(responseFailed)failed;

@end
