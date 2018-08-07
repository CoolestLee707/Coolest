//
//  Define.h
//  Coolest
//
//  Created by daoj on 2018/7/19.
//  Copyright © 2018年 CoolestLee707. All rights reserved.
//

#ifndef Define_h
#define Define_h

#pragma mark --- 系统版本判断
#define VERSION    [UIDevice currentDevice].systemVersion.floatValue
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

//程序根控制器
#define APPRootController [UIApplication sharedApplication].keyWindow.rootViewController

///系统高度
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define kNavigationBarHeight   (StatusBarHeight + 44)
#define StatusBarHeight        ([UIApplication sharedApplication].statusBarFrame.size.height)
#define BottomBarHeight        (Main_Screen_Height==812?83.f:49.f)
#define BottomEmptyHeight      (Main_Screen_Height==812?34.f:0)


///LOG宏
#ifdef DEBUG
#define ADLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ADLog(...)
#endif

//强 弱 引用
#define kWeakSelf(A)          __weak  typeof(self) A = self;
#define kStrongSelf(A,B)     __strong typeof(self) A = B;


///颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB16COLOR(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]


/// 午夜的蓝色
#define BaseBlueColor   RGBACOLOR(25,25,112,1)

/// 薄荷奶油
#define TabbarColor RGBACOLOR(245,255,250,1)

/// 纯白色
#define WhiteTextColor RGB16COLOR(0xffffff)

#define NavBackColor   RGBACOLOR(245,222,179,1)

#define ContentBackColor   RGBACOLOR(255,255,255,1)

#define cellBackColor   RGBACOLOR(255,245,238,1)

#endif /* Define_h */
