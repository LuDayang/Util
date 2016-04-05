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
  
  
_label.textAlignment = NSTextAlignmentLeft;
  
  timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(initData) userInfo:nil repeats:YES];
  [timer fire];
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)initData{
//  _label.text = [NSDate getCurrentDate:@"'G'公元时代:G\n'yy'年的后2位:yy\n'yyyy'完整年:yyyy\n'MM:'MM\n'MMM:'MMM\n'MMMM:'MMMM\n'dd:'dd\n'd:'d\n'EEE:'EEE\n'EEEE:'EEEE\n'aa:'aa\n'H:'H\n'K:'K\n'm:'m\n'mm:'mm\n's:'s\n'ss:'ss\n'S:'S\n"];
  _label.text = [NSDate getCurrentDate:@"Gyyyy年MMMMdd日EEEEaa KK:mm:ss.S"];
}

- (void)initNavigationBarItems {
  [super initNavigationBarItems];
  self.title = @"First";
}
- (IBAction)sliderAction:(UISlider *)sender {
  _Image.image =[[UIImage imageNamed:@"image2"] blurImageWithRadius:sender.value];
  
}

@end
