//
//  CameraManager.h
//  Coolest
//
//  Created by daoj on 2018/11/23.
//  Copyright © 2018 CoolestLee707. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CameraManager : NSObject

@property (nonatomic,copy) void(^saveBlock)(BOOL result);

/**
 初始化
 
 @param superView 父视图
 @return self
 */
- (instancetype)initWithSuperView:(UIView *)superView;

/**
 开启摄像
 */
- (void)openVideo;

/**
 关闭摄像
 */
- (void)closeVideo;

/**
 拍照
 */
- (void)takePicture;

/**
 取消
 */
- (void)cannel;

/**
 切换摄像头
 */
- (void)exchangeCamera;

/**
 获取原图
 
 @return image
 */
- (UIImage *)getOriginalImage;


/**
 保存到相册

 */
- (void)saveImageToLibrary:(UIImage *)image Finish:(void(^)(BOOL result))complete;

@end

NS_ASSUME_NONNULL_END
