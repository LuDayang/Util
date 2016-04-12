//
//  Constant.h
//  iOSLibraryDemo
//
//  Created by Lu on 19/2/16.
//  Copyright © 2016年 LuDayang. All rights reserved.
//


/**
 *  本文件用于存放工程使用到的的常量
 */


#ifndef Constant_h
#define Constant_h

/**
 *  版本相关
 */

//设备系统版本
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending)


/**
 *  数值常量
 */

//列表页每次加载数据
#define LISTVIEW_DATA_COUNT 20


/**
 *  尺寸常量
 */

//屏幕宽度
#define MRScreenWidth CGRectGetWidth([UIScreen mainScreen].applicationFrame)
//屏幕高度
#define MRScreenHeight ([UIScreen mainScreen].bounds.size.height)

/**
 *  颜色常量
 */

//定义颜色常量
#define BGImageColor [UIColor colorWithRed:255.0f / 255 green:255.0f / 255 blue:255.0f / 255 alpha:1]


/**
 *  输入RGB值获取颜色
 *
 *  @param r RED值
 *  @param g GREEN值
 *  @param b BLUE值
 *  @param a 透明度
 *
 *  @return UIColor
 */
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

/**
 *  输入16进制值获取颜色
 *
 *  @param rgbValue 16进制值
 *
 *  @return UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 *  字体常量
 */


/**
 *  常用函数
 */


/**
 *  导航标题设置（标签：140*44）：背景色：无、字体大小：18,、字体颜色：白色、字体对齐方式：中间对齐、标题文字：自定义
 *
 *  @param titleName_macro 标题文字
 *
 *  @return nil
 */
#define NAVIGATION_TITLEVIEW_SET_USE_LABEL(titleName_macro)                                \
UILabel* titleLabel_macro = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 44)]; \
titleLabel_macro.backgroundColor = [UIColor clearColor];                               \
titleLabel_macro.font = YAHEIFONT(18);                                                 \
titleLabel_macro.textColor = RGBACOLOR(255, 255, 255, 1);                              \
titleLabel_macro.textAlignment = NSTextAlignmentCenter;                                \
titleLabel_macro.text = titleName_macro;                                               \
self.navigationItem.titleView = titleLabel_macro;

/**
 *  弹出系统提醒对话框
 *
 *  @param title 对话框标题
 *  @param msg   对话框内容
 *
 *  @return 直接弹出
 */
#if __has_include(<UIKit/UIAlertController.h>)
#define MYALERTBYTITLE(title, msg,controller)                                                                                                                       \
{     \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle: UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[controller presentViewController:alert animated:YES completion:nil];\
\
}
#define MYALERT(msg,controller)                                                                                                                       \
{     \
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle: UIAlertControllerStyleAlert];\
[alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {\
}]];\
[controller presentViewController:alert animated:YES completion:nil];\
\
}
#else
//系统提醒对话框
#define MYALERTBYTITLE(title, msg)                                             \
{                                                                            \
if(msg.length == 0)\
{\
return;\
}\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title              \
message:msg                \
delegate:self               \
cancelButtonTitle:@"确认"          \
otherButtonTitles:nil, nil];         \
[alert setTag:110];                                                        \
[alert show];                                                              \
}

//系统提醒对话框
#define MYALERT(msg)                                                           \
{                                                                            \
if(msg.length == 0)\
{\
return;\
}\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒"          \
message:msg                \
delegate:self               \
cancelButtonTitle:@"确认"          \
otherButtonTitles:nil, nil];         \
[alert setTag:110];                                                        \
[alert show];                                                              \
}

#endif


/**
 *  弹出系统提醒对话框
 *
 *  @param msg 对话框内容
 *
 *  @return 直接弹出
 */




/**
 *  绘图相关
 */

//绘圆
#define DRAWCIRCLE(view)                                   \
view.layer.cornerRadius = view.frame.size.width / 2;   \
view.layer.masksToBounds = YES;                        \
view.contentMode = UIViewContentModeScaleToFill;       \
view.layer.borderWidth = 2.0f;                         \
view.layer.borderColor = [UIColor whiteColor].CGColor; \
view.layer.shadowRadius = 0;                           \
view.layer.shadowOpacity = 0;

//绘制边框
#define DRAWBORDER(view, borderWidth, cornerRadius, color) \
view.layer.cornerRadius = cornerRadius;                \
view.layer.masksToBounds = YES;                        \
view.layer.borderWidth = borderWidth;                  \
view.layer.borderColor = [color CGColor];              \
view.contentMode = UIViewContentModeScaleToFill;

//绘制阴影
#define DRAWSHADOW(view)                                   \
view.layer.shadowColor = [UIColor blackColor].CGColor; \
view.layer.shadowOffset = CGSizeMake(0, 0);            \
view.layer.shadowOpacity = 0.5;                        \
view.layer.shadowRadius = 10.0;

#endif /* Constant_h */
