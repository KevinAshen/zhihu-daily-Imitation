//
//  ZDICommitPageSectionView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageSectionView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDICommitPageSectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void) createUI {
    _commitNumberLabel = [[UILabel alloc] init];
    [self addSubview:_commitNumberLabel];
    
    [_commitNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20 / kExamplePictureWidth * kDeviceWidth);
        make.top.equalTo(self.mas_top).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.height.mas_equalTo(10 / kExamplePictureHeight * kDeviceHeight);
        make.width.lessThanOrEqualTo(@(100 / kExamplePictureWidth * kDeviceWidth));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
