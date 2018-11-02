//
//  ZDIHomePageTableViewSectionHeadView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageTableViewSectionHeadView.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDIHomePageTableViewSectionHeadView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, 44)];
        baseView.backgroundColor = [UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f];
        [self addSubview:baseView];
        
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2.0, 0, frame.size.width / 3.0, frame.size.height)];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.text = @"11月1日 星期四";
        [baseView addSubview:_dateLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
