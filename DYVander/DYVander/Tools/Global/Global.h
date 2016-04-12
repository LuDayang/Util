//
//  Global.h
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/8.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Global : NSObject<NSCopying>

+ (Global *)sharedSingleton;

#pragma mark - UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView;

#pragma mark - 保存到userDefault
- (void)setUserDefaultsWithKey:(NSString *)key
                      andValue:(id)value;

#pragma mark - 从userDefault取出值
- (NSString *)getUserDefaultsWithKey:(NSString *)key;

#pragma mark - 从userDefault删除key
- (void)delUserDefaultsWithKey:(NSString *)key;

@end
