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
  CGFloat radius;
}
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (strong, nonatomic) IBOutlet UILabel *label;
@end

@implementation FirstController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
//_label.textAlignment = NSTextAlignmentLeft;
  
  timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(initData) userInfo:nil repeats:YES];
  [timer fire];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)initData{

  _label.text = [NSDate getCurrentDate:@"Gyyyy年MMMMdd日\nEEEEaa KK:mm:ss"];
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"First";
}
- (IBAction)sliderAction:(UISlider *)sender {
  _Image.image =[[UIImage imageNamed:@"image2"] blurImageWithRadius:sender.value];
  
}

@end
