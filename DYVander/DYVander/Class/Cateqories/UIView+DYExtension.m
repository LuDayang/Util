//
//  UIView+DYExtension.m
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import "UIView+DYExtension.h"

@implementation UIView (DYExtension)
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
- (void)makeRoundedCorner:(CGFloat)cornerRadius {
  CALayer *roundedlayer = [self layer];
  [roundedlayer setMasksToBounds:YES];
  [roundedlayer setCornerRadius:cornerRadius];
}

/**
 *  绘圆
 */
- (void)drawCircle {
  CALayer *circlelayer = [self layer];
  CGFloat viewWidth = self.bounds.size.width;
  CGFloat viewHeight = self.bounds.size.height;
  CGFloat cornerRadius = viewWidth < viewHeight ? viewWidth : viewHeight;
  CGRect rect = self.bounds;
  rect.size = CGSizeMake(cornerRadius, cornerRadius);
  self.bounds = rect;
  circlelayer.cornerRadius = cornerRadius / 2;
  [circlelayer setMasksToBounds:YES];
}

/**
 *  绘制边框
 */
-(void)drawBorder{
  self.layer.cornerRadius = 5;
  self.layer.masksToBounds = YES;
  self.layer.borderWidth = 1;
  self.layer.borderColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]CGColor];
  
}

/**
 *  绘制阴影
 */
-(void)drawShadow{
  self.layer.shadowColor = [[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]CGColor];
  self.layer.shadowOffset = CGSizeMake(5, 5);
  self.layer.shadowOpacity = 0.5;
  self.layer.shadowRadius = 10.0;
  self.layer.masksToBounds = YES;
}
@end
