//
//  BmobUtil.h
//  iOSLibraryDemo
//
//  Created by 卢达洋 on 16/3/9.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEFAULTUSERPASSWORD @"1"
@interface BmobUtil : NSObject
+ (NSArray *)queryTableAllRecordWithTableName:(NSString *)tableName;
+ (BOOL)batchDeleteTableAllRecordWithTableName:(NSString *)tableName;
+ (BOOL)batchAddWithTableName:(NSString *)tableName andDataArray:(NSArray *)dataArray;
+ (NSArray *)batchAddWithTableName:(NSString *)tableName DataArray:(NSArray *)dataArray;
+ (NSArray *)batchAddUserWithDataArray:(NSArray *)dataArray;
+ (BOOL)batchDeleteUser;
@end
