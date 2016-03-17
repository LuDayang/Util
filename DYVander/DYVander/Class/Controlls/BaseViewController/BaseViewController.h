//
//  BaseViewController.h
//  iOSLibraryDemo
//
//  Created by 卢达洋 on 16/2/26.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+DYExtension.h"
#import "NSString+DYExtension.h"
#import "UIView+DYExtension.h"

@interface BaseViewController : UIViewController
- (void)back;
- (void)initView;
- (void)initNavigationBarItems;
- (void)initData;
@end
