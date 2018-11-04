//
//  ZDIMenuTableHeadView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/4.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIMenuTableHeadView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
@implementation ZDIMenuTableHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void) createUI {
    _headButton = [[UIButton alloc] init];
    [self addSubview:_headButton];
    
    [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(36 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(18 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(40 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(40 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_headButton setImage:[UIImage imageNamed:@"sun-knight.jpeg"] forState:UIControlStateNormal];
    _headButton.layer.masksToBounds = YES;
    _headButton.layer.cornerRadius = 18;
    
    _headLabel = [[UILabel alloc] init];
    [self addSubview:_headLabel];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(46 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.headButton.mas_right).offset(16 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(100 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.headLabel.text = @"奶铺赛龙";
    self.headLabel.textColor = [UIColor whiteColor];
    
    _collectButton = [[UIButton alloc] init];
    [self addSubview:_collectButton];
    
    [self.collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headButton.mas_bottom).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(20 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(24 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(24 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_collectButton setImage:[UIImage imageNamed:@"five-pointed star"] forState:UIControlStateNormal];
    
    _collectLabel = [[UILabel alloc] init];
    [self addSubview:_collectLabel];
    
    [self.collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectButton.mas_bottom).offset(4 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(21 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(22 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(10 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.collectLabel.text = @"收藏";
    self.collectLabel.font = [UIFont systemFontOfSize:10];
    self.collectLabel.textColor = [UIColor whiteColor];
    
    _messageButton = [[UIButton alloc] init];
    [self addSubview:_messageButton];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headButton.mas_bottom).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.collectButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(24 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(24 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    
    _messageLabel = [[UILabel alloc] init];
    [self addSubview:_messageLabel];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageButton.mas_bottom).offset(4 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.collectButton.mas_right).offset(62 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(22 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(10 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.messageLabel.text = @"消息";
    self.messageLabel.font = [UIFont systemFontOfSize:10];
    self.messageLabel.textColor = [UIColor whiteColor];
    
    _setButton = [[UIButton alloc] init];
    [self addSubview:_setButton];
    
    [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headButton.mas_bottom).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.messageButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(24 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(24 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    
    _setLabel = [[UILabel alloc] init];
    [self addSubview:_setLabel];
    
    [self.setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.setButton.mas_bottom).offset(4 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.messageButton.mas_right).offset(62 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(22 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(10 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.setLabel.text = @"设置";
    self.setLabel.font = [UIFont systemFontOfSize:10];
    self.setLabel.textColor = [UIColor whiteColor];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
