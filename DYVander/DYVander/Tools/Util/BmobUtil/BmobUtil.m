//
//  BmobUtil.m
//  iOSLibraryDemo
//
//  Created by 卢达洋 on 16/3/9.
//  Copyright © 2016年 LuDayang. All rights reserved.
//

#import "BmobUtil.h"

#define RESTFULKEY @"a554eb22b64bfea4abe40e2e6bda7039"
#define APPKEY     @"607436f399a06e22f409d23c9c87af7b"
#define MASATERKEY @"f501a0ccd429dad20b6c33315e6df3e3"

@implementation BmobUtil
+ (NSArray *)queryTableAllRecordWithTableName:(NSString *)tableName{
  //查询
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.bmob.cn/1/classes/%@",tableName]];
  NSMutableURLRequest *queryRequest = [[NSMutableURLRequest alloc] initWithURL:url];
  [queryRequest setHTTPMethod:@"GET"];
  [queryRequest setAllHTTPHeaderFields:@{@"X-Bmob-Application-Id":APPKEY,@"X-Bmob-REST-API-Key":RESTFULKEY,@"Content-Type":@"application/json"}];
  NSHTTPURLResponse *response;
  NSData *data = [NSURLConnection sendSynchronousRequest:queryRequest returningResponse:&response error:nil];
  NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  if (response.statusCode == 200) {
    return result[@"results"];
  } else {
    NSLog(@"查询失败：%@",result);
    return nil;
  }
}



+ (BOOL)batchDeleteTableAllRecordWithTableName:(NSString *)tableName{
  NSURL *url = [NSURL URLWithString:@"https://api.bmob.cn/1/batch"];
  NSMutableURLRequest *batchRequest = [[NSMutableURLRequest alloc] initWithURL:url];
  [batchRequest setHTTPMethod:@"POST"];
  [batchRequest setAllHTTPHeaderFields:@{@"X-Bmob-Application-Id":APPKEY,@"X-Bmob-REST-API-Key":RESTFULKEY,@"Content-Type":@"application/json"}];
  
  //构造删除请求体
  NSMutableDictionary *batchRequestBody = [[NSMutableDictionary alloc] initWithCapacity:1];
  NSMutableArray *deleteArray = [[NSMutableArray alloc] initWithCapacity:1];
  batchRequestBody[@"requests"] = deleteArray;
  
  NSArray *queryResult = [[self class] queryTableAllRecordWithTableName:tableName];
  for (NSDictionary *objDic in queryResult) {
    NSString *path = [NSString stringWithFormat:@"/1/classes/%@/%@",tableName,objDic[@"objectId"]];
    NSDictionary *recordDic = @{@"method":@"DELETE",
                                @"path":path
                                };
    [deleteArray addObject:recordDic];
  }
  NSData *batchRequestBodyData = [NSJSONSerialization dataWithJSONObject:batchRequestBody options:NSJSONWritingPrettyPrinted error:nil];
  [batchRequest setHTTPBody:batchRequestBodyData];
  
  NSHTTPURLResponse *response;
  NSData *data = [NSURLConnection sendSynchronousRequest:batchRequest returningResponse:&response error:nil];
  NSDictionary *requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  if (response.statusCode == 200) {
    return true;
  } else {
    NSLog(@"批量删除错误：%@",requestResult);
    return false;
  }
}

+ (BOOL)batchAddWithTableName:(NSString *)tableName andDataArray:(NSArray *)dataArray{
  if ([[self class] batchAddWithTableName:tableName DataArray:dataArray]) {
    return true;
  } else {
    return false;
  }
}

+ (NSArray *)batchAddWithTableName:(NSString *)tableName DataArray:(NSArray *)dataArray{
  NSURL *url = [NSURL URLWithString:@"https://api.bmob.cn/1/batch"];
  NSMutableURLRequest *batchRequest = [[NSMutableURLRequest alloc] initWithURL:url];
  [batchRequest setHTTPMethod:@"POST"];
  [batchRequest setAllHTTPHeaderFields:@{@"X-Bmob-Application-Id":APPKEY,@"X-Bmob-REST-API-Key":RESTFULKEY,@"Content-Type":@"application/json"}];
  
  //构造请求体
  NSMutableDictionary *batchRequestBody = [[NSMutableDictionary alloc] initWithCapacity:1];
  NSMutableArray *addArray = [[NSMutableArray alloc] initWithCapacity:1];
  batchRequestBody[@"requests"] = addArray;
  for (NSDictionary *bodyDic in dataArray) {
    NSString *path = [NSString stringWithFormat:@"/1/classes/%@",tableName];
    NSDictionary *addDic = @{@"method":@"POST",
                             @"path":path,
                             @"body":bodyDic
                             };
    [addArray addObject:addDic];
  }
  NSData *batchRequestBodyData = [NSJSONSerialization dataWithJSONObject:batchRequestBody options:NSJSONWritingPrettyPrinted error:nil];
  [batchRequest setHTTPBody:batchRequestBodyData];
  
  //进行请求
  NSHTTPURLResponse *response;
  NSData *data = [NSURLConnection sendSynchronousRequest:batchRequest returningResponse:&response error:nil];
  NSArray *requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  if (response.statusCode == 200) {
    return requestResult;
  } else {
    NSLog(@"批量添加错误：%@",requestResult);
    return nil;
  }
}

+ (NSArray *)batchAddUserWithDataArray:(NSArray *)dataArray{
  //
  NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:1];
  for (NSDictionary *dic in dataArray) {
    NSURL *url = [NSURL URLWithString:@"https://api.bmob.cn/1/users"];
    NSMutableURLRequest *batchRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [batchRequest setHTTPMethod:@"POST"];
    [batchRequest setAllHTTPHeaderFields:@{@"X-Bmob-Application-Id":APPKEY,@"X-Bmob-REST-API-Key":RESTFULKEY,@"Content-Type":@"application/json"}];
    
    //构造请求体
    NSData *userAddBodyData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [batchRequest setHTTPBody:userAddBodyData];
    
    //进行请求
    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:batchRequest returningResponse:&response error:nil];
    NSDictionary *requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (response.statusCode == 201) {
      [results addObject:requestResult];
    } else {
      NSLog(@"批量用户添加错误：%@",requestResult);
      return nil;
    }
  }
  return results;
}

+ (BOOL)batchDeleteUser{
  NSArray *users = [[self class] queryTableAllRecordWithTableName:@"_User"];
  for (NSDictionary *user in users) {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.bmob.cn/1/users/%@",user[@"objectId"]]];
    NSMutableURLRequest *deleteRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [deleteRequest setHTTPMethod:@"DELETE"];
    [deleteRequest setAllHTTPHeaderFields:@{@"X-Bmob-Application-Id":APPKEY,@"X-Bmob-REST-API-Key":RESTFULKEY,@"Content-Type":@"application/json",@"X-Bmob-Master-Key":MASATERKEY}];
    
    //进行请求
    NSHTTPURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:deleteRequest returningResponse:&response error:nil];
    NSDictionary *requestResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (response.statusCode != 200) {
      NSLog(@"批量用户删除错误：%@",requestResult);
      return false;
    }
  }
  return true;
}
@end
