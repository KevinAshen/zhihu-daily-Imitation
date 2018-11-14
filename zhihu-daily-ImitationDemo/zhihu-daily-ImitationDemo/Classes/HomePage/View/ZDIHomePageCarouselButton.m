//
//  ZDIHomePageCarouselButton.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/12.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageCarouselButton.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDIHomePageCarouselButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect rect = CGRectMake(18 / kExamplePictureWidth * kDeviceWidth, 156 / kExamplePictureHeight * kDeviceHeight, 390 / kExamplePictureWidth * kDeviceWidth, 50);
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
