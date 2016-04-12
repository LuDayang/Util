//
//  Global.m
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/8.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import "Global.h"

@implementation Global
+ (Global *)sharedSingleton {
    static dispatch_once_t once;
    static Global *_singleton = nil;
    dispatch_once(&once, ^{
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}

#pragma mark - UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark - Implement NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - NSUserDefaults操作

- (void)setUserDefaultsWithKey:(NSString *)key andValue:(id)value {
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getUserDefaultsWithKey:(NSString *)key {
    NSString *value =
    (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:key];
    return value;
}

- (void)delUserDefaultsWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
