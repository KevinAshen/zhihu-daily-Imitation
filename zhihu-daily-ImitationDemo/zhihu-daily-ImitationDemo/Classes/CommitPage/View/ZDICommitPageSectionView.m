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
#define kLittleInterval 10
#define kBigInterval 16
#define kMainTextHeight 20
#define kDateTextHeight 12

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
    self.backgroundColor = [UIColor whiteColor];
    
    _commitNumberLabel = [[UILabel alloc] init];
    [self addSubview:_commitNumberLabel];
    
    [_commitNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kBigInterval);
        make.top.equalTo(self.mas_top).offset(kBigInterval);
        make.height.mas_equalTo(kMainTextHeight);
        make.width.lessThanOrEqualTo(@(100));
    }];
    
    _arrowImageView = [[UIImageView alloc] init];
    [self addSubview:_arrowImageView];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-kLittleInterval);
        make.top.equalTo(self.mas_top).offset(kBigInterval);
        make.height.mas_equalTo(kMainTextHeight);
        make.width.mas_equalTo(kMainTextHeight);
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
