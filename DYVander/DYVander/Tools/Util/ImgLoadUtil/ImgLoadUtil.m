//
//  ImgLoadUtil.m
//  Trendyfp
//
//  Created by chengjian on 15/11/25.
//  Copyright © 2015年 chengjian. All rights reserved.
//

#import "ImgLoadUtil.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@implementation ImgLoadUtil

+ (UIImageView*)getImageForView:(UIImageView *)imageView andImageURL:(NSString *)url
{
  UIImageView* setImageView = imageView;
  setImageView.backgroundColor = [UIColor whiteColor];
  if (setImageView)
  {
    __block UIActivityIndicatorView *activityIndicator;
    [setImageView addSubview:activityIndicator = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]];
    setImageView.backgroundColor = [UIColor whiteColor];
//    activityIndicator.center = imageView.center;
    // 使用mas_makeConstraints添加约束
    [activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
//      make.top.equalTo(imageView.mas_top).with.offset(0);
//      make.bottom.equalTo(imageView.mas_bottom).with.offset(0);
//      make.left.equalTo(imageView.mas_left).with.offset(0);
//      make.right.equalTo(imageView.mas_right).with.offset(0);
      make.center.equalTo(imageView.mas_centerX).with.offset(0);
      make.center.equalTo(imageView.mas_centerY).with.offset(0);
    }];
    [activityIndicator startAnimating];
    [setImageView sd_setImageWithURL:[NSURL  URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      [activityIndicator stopAnimating];
      [activityIndicator setHidesWhenStopped:YES];
      [activityIndicator setHidden:YES];
      setImageView.image = image;
    }];
  }
  return setImageView;
}

@end
