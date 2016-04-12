//
//  Master.m
//  iOSProduct
//
//  Created by 卢达洋 on 16/4/8.
//  Copyright © 2016年 oftenfull_iOSTeam. All rights reserved.
//

#import "Master.h"
#import "FirstController.h"
#import "SecondController.h"
#import "ThirdController.h"
#import "FourthController.h"

@interface Master ()

@end

@implementation Master

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  
  self.viewControllers = @[nc1,nc2,nc3,nc4];

}

@end
