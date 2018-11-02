//
//  ZDINavChangeImage.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDINavChangeImage.h"

@implementation ZDINavChangeImage

- (instancetype)initWithColor:(UIColor *)color andAlpha:(CGFloat)alpha
{
    self = [super init];
    if (self) {
        //self = [self createImageWithColor:color andAlpha:alpha];
        
    }
    return self;
}

- (UIImage *)createImageWithColor:(UIColor *)color andAlpha:(CGFloat)alpha {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(theImage.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, theImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
