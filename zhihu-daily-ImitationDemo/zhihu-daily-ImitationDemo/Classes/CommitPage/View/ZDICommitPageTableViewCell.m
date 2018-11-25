//
//  ZDICommitPageTableViewCell.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageTableViewCell.h"
#import "UILabel+LabelHeight.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@implementation ZDICommitPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void) createUI {
    _avatarButton = [[UIButton alloc] init];
    [self.contentView addSubview:_avatarButton];
    
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.contentView.mas_left).offset(20 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(30 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(30 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    _avatarButton.layer.masksToBounds = YES;
    _avatarButton.layer.cornerRadius = _avatarButton.frame.size.height / 2.0;
    
    _authorLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_authorLabel];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(22 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.avatarButton.mas_right).offset(12 / kExamplePictureWidth * kDeviceWidth);
        make.width.lessThanOrEqualTo(@(300 / kExamplePictureWidth * kDeviceWidth));
        make.height.mas_equalTo(14 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.authorLabel.textColor = [UIColor blackColor];
    
    _contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(10 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.contentView.mas_left).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(362 / kExamplePictureWidth * kDeviceWidth);
    }];
    _contentLabel.numberOfLines  = 0;
    
    _timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(16 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.contentView.mas_left).offset(60 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(70 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(10 / kExamplePictureWidth * kDeviceWidth);
    }];
    
    _timeLabel.textColor = [UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
    
    _upvoteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"commitUpvote"]];
    [self.contentView addSubview:_upvoteImageView];
    
    [_upvoteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(22 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.contentView.mas_left).offset(400 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(12 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(12 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    _upvoteLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_upvoteLabel];
    
    [_upvoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(22 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.upvoteImageView.mas_right).offset(6 / kExamplePictureWidth * kDeviceWidth);
        make.width.lessThanOrEqualTo(@(26 / kExamplePictureWidth * kDeviceWidth));
        make.height.mas_equalTo(10 / kExamplePictureWidth * kDeviceWidth);
    }];
    
    _upvoteLabel.textColor = [UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
}

+ (CGFloat)cellComment:(NSString *)comment size:(CGSize)contextSize {
    CGFloat commentHeigth = [UILabel getHeightByWidth:contextSize.width - 80 title:comment font:[UIFont systemFontOfSize:15.0]];
    return commentHeigth + 110;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
