//
//  AppConfig.h
//  ofshop
//
//  Created by 卢达洋 on 16/3/18.
//  Copyright © 2016年 oftenfull. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h

#define DEFAULT_API_HOST @"http://ofwd.oftenfull.com"
#define TESTING_API_HOST @"http://apidemo.vsource.com.cn"



//设置超时时间
#define REQUEST_TIMEOUT 30

//缓存
#define UD_KEY_LAST_LOGIN_USERNAME    @"LastLoginUsername"//用户名
#define UD_KEY_LAST_LOGIN_PASSWORD    @"LastLoginPassword"//密码
#define UD_KEY_LAST_LOGIN_TOKEN       @"LastLoginToken"   //token
#define UD_KEY_TOKEN_EXPIRED_TIME     @"Expired"          //最近一次获取token的时间



#endif /* AppConfig_h */
