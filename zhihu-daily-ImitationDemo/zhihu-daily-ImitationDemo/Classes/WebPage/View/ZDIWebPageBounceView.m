//
//  ZDIWebPageBounceView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageBounceView.h"
#import "ZDIWebPageBounceCollectView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kZDIWebPageBounceViewHeight [UIScreen mainScreen].bounds.size.height / 4.5
#define kLittleInterval 16
#define kBigInterval 22
#define kButtonHeight 38
#define kCollectViewWidth 100
#define kCollectViewHeight 80

@interface ZDIWebPageBounceView()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) ZDIWebPageBounceCollectView *webPageBounceCollectView;

@property (nonatomic, assign) BOOL collectFlag;



@end

@implementation ZDIWebPageBounceView

- (void)setupContent {
    
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    //self.backgroundColor = [UIColor redColor];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (_contentView == nil) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHeight - kZDIWebPageBounceViewHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
        _contentView.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.00f];
        [self addSubview:_contentView];
        
        [self setupContentSubview];
       
    }
}

- (void)showInView:(UIView *)view WithFlag:(BOOL)flag {
    if (!view) {
        return;
    }
    
    _collectFlag = flag;
    
   
    [self setupContent];
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.alpha = 1.0;
        
        [self.contentView setFrame:CGRectMake(0, kDeviceHeight - kZDIWebPageBounceViewHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
        
    } completion:nil];
    
}

- (void)disMissView {
    
    [_contentView setFrame:CGRectMake(0, kDeviceHeight - kZDIWebPageBounceViewHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
    [UIView animateWithDuration:0.15
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [self.contentView setFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [self.contentView removeFromSuperview];
                     }];
    
    if ([self.webPageBounceViewDelegate respondsToSelector:@selector(changeCollectFlagWithFlag:)]) {
        [_webPageBounceViewDelegate changeCollectFlagWithFlag:_collectFlag];
    } else {
        NSLog(@"WRONG--");
        return;
    }
    
}

- (void)touchCollect {
    [self setupCollectView];
    
    [_contentView setFrame:CGRectMake(0, kDeviceHeight - kZDIWebPageBounceViewHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
    [UIView animateWithDuration:0.15
                     animations:^{
                         
                         //self.alpha = 0.0;
                         
                         [self.contentView setFrame:CGRectMake(0, kDeviceHeight, kDeviceWidth, kZDIWebPageBounceViewHeight)];
                     }
                     completion:^(BOOL finished){
                         
                         //[self removeFromSuperview];
                         [self.contentView removeFromSuperview];
                     }];
    
    if ([self.webPageBounceViewDelegate respondsToSelector:@selector(changeCollectFlagWithFlag:)]) {
        [_webPageBounceViewDelegate changeCollectFlagWithFlag:_collectFlag];
    } else {
        NSLog(@"WRONG--");
        return;
    }
    
    [UIView animateWithDuration:1 animations:^{
        self.webPageBounceCollectView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.webPageBounceCollectView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)setupContentSubview {
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kLittleInterval);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    _titleLabel.text = @"分享这篇内容";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    
    _collectButton = [[UIButton alloc] init];
    [self.contentView addSubview:_collectButton];
    
    [_collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kLittleInterval);
        make.left.equalTo(self.contentView.mas_left).offset(kBigInterval);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(kButtonHeight);
    }];
    
    [_collectButton setTitle:@"收藏" forState:UIControlStateNormal];
    _collectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_collectButton setTitleColor:[UIColor colorWithRed:0.62f green:0.62f blue:0.62f alpha:1.00f] forState:UIControlStateNormal];
    [_collectButton setBackgroundColor:[UIColor whiteColor]];
    [_collectButton addTarget:self action:@selector(touchCollect) forControlEvents:UIControlEventTouchUpInside];
    
    _cancelButton = [[UIButton alloc] init];
    [self.contentView addSubview:_cancelButton];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectButton.mas_bottom).offset(kLittleInterval);
        make.left.equalTo(self.contentView.mas_left).offset(kBigInterval);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(kButtonHeight);
    }];
    
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelButton setTitleColor:[UIColor colorWithRed:0.62f green:0.62f blue:0.62f alpha:1.00f] forState:UIControlStateNormal];
    [_cancelButton setBackgroundColor:[UIColor whiteColor]];
    
    [_cancelButton addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupCollectView {
    _webPageBounceCollectView = [[ZDIWebPageBounceCollectView alloc] initWithFlag:_collectFlag];
    [self addSubview:_webPageBounceCollectView];
    
    [_webPageBounceCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(kCollectViewWidth);
        make.height.mas_equalTo(kCollectViewHeight);
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
