//
//  UILabel+LabelHeight.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(LabelHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
