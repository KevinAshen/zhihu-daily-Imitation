//
//  ZDIWebPageBottomView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageBottomView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDIWebPageBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _shadowlabel = [[UILabel alloc] init];
    [self addSubview:_shadowlabel];
    [self.shadowlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(0 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(kDeviceWidth);
        make.height.mas_equalTo(1 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    _shadowlabel.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    
    self.backgroundColor = [UIColor whiteColor];
    
    _returnButton = [[UIButton alloc] init];
    [self addSubview:_returnButton];
    
    [self.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.mas_left).offset(40 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    
    _nextButton = [[UIButton alloc] init];
    [self addSubview:_nextButton];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.returnButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(25 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_nextButton setImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    
    _upvoteButton = [[UIButton alloc] init];
    [self addSubview:_upvoteButton];
    
    [self.upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.nextButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_upvoteButton setImage:[UIImage imageNamed:@"upVote"] forState:UIControlStateNormal];
    
    _shareButton = [[UIButton alloc] init];
    [self addSubview:_shareButton];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.upvoteButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
    _commitButton = [[UIButton alloc] init];
    [self addSubview:_commitButton];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(14 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.shareButton.mas_right).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    [_commitButton setImage:[UIImage imageNamed:@"commit"] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
