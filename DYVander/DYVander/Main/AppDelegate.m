//
//  AppDelegate.m
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstController.h"
#import "SecondController.h"
#import "ThirdController.h"
#import "FourthController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  [self createTabBar];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 私有方法
-(void)createTabBar{
  FirstController *vc1 = [[FirstController alloc] initWithNibName:@"FirstController" bundle:nil];
  UINavigationController *nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
  nc1.tabBarItem.title=@"First";
  
  SecondController *vc2 = [[SecondController alloc] initWithNibName:@"SecondController" bundle:nil];
  UINavigationController *nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
  nc2.tabBarItem.title=@"Second";
  
  ThirdController *vc3 = [[ThirdController alloc] initWithNibName:@"ThirdController" bundle:nil];
  UINavigationController *nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
  nc3.tabBarItem.title=@"Third";
  
  FourthController *vc4 = [[FourthController alloc] initWithNibName:@"FourthController" bundle:nil];
  UINavigationController *nc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
  nc4.tabBarItem.title=@"Fourth";
  
  UITabBarController *tbc = [[UITabBarController alloc] init];
  tbc.viewControllers = @[nc1,nc2,nc3,nc4];
  
  self.window.rootViewController = tbc;
}

@end
