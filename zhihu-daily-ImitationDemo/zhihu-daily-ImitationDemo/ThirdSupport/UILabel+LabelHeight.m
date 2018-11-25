//
//  UILabel+LabelHeight.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "UILabel+LabelHeight.h"

@implementation UILabel(LabelHeight)

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
