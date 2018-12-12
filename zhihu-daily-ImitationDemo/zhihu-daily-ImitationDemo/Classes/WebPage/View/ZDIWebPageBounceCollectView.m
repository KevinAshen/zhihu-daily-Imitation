//
//  ZDIWebPageBounceCollectView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageBounceCollectView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kBigInterval 15
#define kLittleInterval 10

@interface ZDIWebPageBounceCollectView()

@property (nonatomic, strong) UIImageView *starImageView;

@property (nonatomic, strong) UILabel *collectLabel;

@property (nonatomic, assign) BOOL collectFlag;

@end

@implementation ZDIWebPageBounceCollectView

- (instancetype)initWithFlag:(BOOL)flag
{
    self = [super init];
    if (self) {
        _collectFlag = flag;
        [self CreateUI];
    }
    return self;
}

- (void)CreateUI {
    
    self.backgroundColor = [UIColor colorWithRed:0.05f green:0.09f blue:0.13f alpha:1.00f];
    self.alpha = 0.8;
    
    _starImageView = [[UIImageView alloc] init];
    [self addSubview:_starImageView];
    
    [_starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kBigInterval);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _collectLabel = [[UILabel alloc] init];
    [self addSubview:_collectLabel];
    
    [_collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.starImageView.mas_bottom).offset(kLittleInterval);
        make.width.mas_equalTo(37);
        make.height.mas_equalTo(15);
    }];
    
    _collectLabel.textColor = [UIColor whiteColor];
    _collectLabel.font = [UIFont systemFontOfSize:12];
    
    if (_collectFlag) {
        _starImageView.image = [UIImage imageNamed:@"starGolden"];
        _collectLabel.text = @"已收藏";
    } else {
        _starImageView.image = [UIImage imageNamed:@"starGrey"];
        _collectLabel.text = @"取消收藏";
    }
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
