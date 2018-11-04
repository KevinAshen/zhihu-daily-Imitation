//
//  ZDIMenuTableFootView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/4.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIMenuTableFootView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDIMenuTableFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void) createUI {
    _offlineButton = [[UIButton alloc] init];
    [self addSubview:_offlineButton];
    
    [self.offlineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-28 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(18 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(24 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(24 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_offlineButton setImage:[UIImage imageNamed:@"downLoad"] forState:UIControlStateNormal];
    
    _offlineLabel = [[UILabel alloc] init];
    [self addSubview:_offlineLabel];
    
    [self.offlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.offlineButton.mas_right).offset(16 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(30 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.offlineLabel.text = @"离线";
    self.offlineLabel.font = [UIFont systemFontOfSize:13];
    self.offlineLabel.textColor = [UIColor whiteColor];
    
    _nightPatternButton = [[UIButton alloc] init];
    [self addSubview:_nightPatternButton];
    
    [self.nightPatternButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-28 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.offlineLabel.mas_left).offset(50 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(24 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(24 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_nightPatternButton setImage:[UIImage imageNamed:@"night-pattern"] forState:UIControlStateNormal];
    
    _nightPatternLabel = [[UILabel alloc] init];
    [self addSubview:_nightPatternLabel];
    
    [self.nightPatternLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.nightPatternButton.mas_right).offset(16 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(30 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.nightPatternLabel.text = @"夜间";
    self.nightPatternLabel.font = [UIFont systemFontOfSize:13];
    self.nightPatternLabel.textColor = [UIColor whiteColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
