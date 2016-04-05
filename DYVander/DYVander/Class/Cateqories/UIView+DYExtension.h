//
//  UIView+DYExtension.h
//  DYVander
//
//  Created by 卢达洋 on 16/3/17.
//  Copyright © 2016年 ludayang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DYExtension)
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角半径
 */
-(void)makeRoundedCorner:(CGFloat)cornerRadius;

/**
 *  绘圆
 */
-(void)drawCircle;

-(void)drawBorder;

-(void)drawShadow;

/**
 *  高斯模糊
 */
-(void)blurEffect;


/**
 *  带参数的高斯模糊效果
 *
 *  @param style 风格
 *  @param alpha 透明度
 */
-(void)blurEffectWithStyle:(UIBlurEffectStyle)style Alpha:(CGFloat)alpha;

@end
