//
//  FirstController.m
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import "FirstController.h"
@interface FirstController ()
{
  NSTimer *timer;
}
@end

@implementation FirstController

- (void)viewDidLoad {
  [super viewDidLoad];

  UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 50)];
  label.backgroundColor = [UIColor cyanColor];
  [label makeRoundedCorner:5];
  label.text = [NSDate getCurrentDate:@"YYYY年MM月dd日 hh时mm分ss秒"];
  [self.view addSubview:label];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"First";
}

@end
