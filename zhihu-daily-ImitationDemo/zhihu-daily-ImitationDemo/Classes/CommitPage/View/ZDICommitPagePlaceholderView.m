//
//  ZDICommitPagePlaceholderView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPagePlaceholderView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0


@implementation ZDICommitPagePlaceholderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    _placeholderChairImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholderSofa"]];
    [self addSubview:_placeholderChairImageView];
    
    [_placeholderChairImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(100 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(100 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    _placeholderWaitlabel = [[UILabel alloc] init];
    [self addSubview:_placeholderWaitlabel];
    
    [_placeholderWaitlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.placeholderChairImageView.mas_bottom).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.centerX.mas_equalTo(self);
    }];
    
    _placeholderWaitlabel.text = @"深度长评虚位以待";
    _placeholderWaitlabel.textColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
