//
//  AFNetworkingManager.m
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#import "AFNetworkingManager.h"
#import "MJExtension.h"

static AFHTTPSessionManager *AFNManager = nil;

@interface ResponseModel ()

@end

@implementation ResponseModel

@end

@implementation AFNetworkingManager

+(AFHTTPSessionManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //初始化
        AFNManager = [AFHTTPSessionManager manager];
        
        //        AFNManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        //超时时间
        AFNManager.requestSerializer.timeoutInterval = 30.0f;
        
        //请求格式FORM
        AFNManager.requestSerializer = [AFHTTPRequestSerializer serializer]; //默认FORM
        
        //请求格式JSON
        //      AFNManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //响应JSON数据
        AFNManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    
    //设置header参数
    //    [AFNManager.requestSerializer setValue:@"10" forHTTPHeaderField:@"devType"];
    
    //    [AFNManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    return AFNManager;
}

+(void)GetRequestWithUrlString:(NSString *)urlString params:(NSDictionary *)params success:(responseSuccess)success failed:(responseFailed)failed
{
    AFNManager = [AFNetworkingManager shareInstance];
    
    //    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFNManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [AFNManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [AFNManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [AFNManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [AFNManager GET:urlString parameters:params headers: nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *) task.response;
        
        if (urlResponse.statusCode == 500) {
            NSDictionary *successDict = responseObject;
            NSString *errorStr = successDict[@"error"];
            if (errorStr) {
                NSError *error = [NSError errorWithDomain:@"httpError" code:500 userInfo:@{NSLocalizedDescriptionKey: errorStr}];
                //回调错误信息
                failed?failed(error):nil;
                
            } else {
                NSError *error = [NSError errorWithDomain:@"httpError" code:500 userInfo:@{NSLocalizedDescriptionKey:@"网络请求错误（500）"}];
                //回调错误信息
                failed?failed(error):nil;
            }
        } else {
            //回调成功数据
            if (responseObject) {
                
                success?success(responseObject):nil;
                
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failed?failed(error):nil;
    }];
}

+(void)PostRequestWithUrlString:(NSString *)urlString params:(NSDictionary *)params success:(responseSuccess)success failed:(responseFailed)failed
{
    AFNManager = [AFNetworkingManager shareInstance];
    
    //    AFNManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [AFNManager POST:urlString parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *) task.response;
               
               if (urlResponse.statusCode == 500) {
                   NSDictionary *successDict = responseObject;
                   NSString *errorStr = successDict[@"error"];
                   if (errorStr) {
                       NSError *error = [NSError errorWithDomain:@"httpError" code:500 userInfo:@{NSLocalizedDescriptionKey: errorStr}];
                       //回调错误信息
                       failed?failed(error):nil;
                       
                   } else {
                       NSError *error = [NSError errorWithDomain:@"httpError" code:500 userInfo:@{NSLocalizedDescriptionKey:@"网络请求错误（500）"}];
                       //回调错误信息
                       failed?failed(error):nil;
                       
                   }
               } else {
                   //回调成功数据
                   if (responseObject) {
                       //                id backDic = [self dictionaryWithJsonData:responseObject];
                       
                       if (responseObject) {
                           ResponseModel* response = [ResponseModel mj_objectWithKeyValues:responseObject];
                           
                           success?success(response):nil;
                           
                       }else {
                           NSLog(@"json有错");
                       }
                   }
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed?failed(error):nil;
    }];
}



/**
 把格式化的JSON格式的字符串转换成字典
 AFNManager.responseSerializer = [AFHTTPResponseSerializer serializer];时用
 @param jsonData JSON格式的字符串
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)jsonData {
    if (jsonData == nil) {
        return nil;
    }
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
