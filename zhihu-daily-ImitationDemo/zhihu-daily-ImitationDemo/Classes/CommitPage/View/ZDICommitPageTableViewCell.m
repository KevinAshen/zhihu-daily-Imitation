//
//  ZDICommitPageTableViewCell.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageTableViewCell.h"
#import "UILabel+LabelHeight.h"
#import "ZDICommitPageView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kLittleInterval 10
#define kBigInterval 16
#define kMainTextHeight 20
#define kDateTextHeight 12

@implementation ZDICommitPageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void) createUI {
    
    
    _avatarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_avatarImageView];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kBigInterval);
        make.left.equalTo(self.contentView.mas_left).offset(kBigInterval);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 15;
    
    _authorLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_authorLabel];
    
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kBigInterval);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kLittleInterval);
        make.width.lessThanOrEqualTo(@(300));
        make.height.mas_equalTo(kMainTextHeight);
    }];
    
    self.authorLabel.textColor = [UIColor blackColor];
    
    _upvoteLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_upvoteLabel];
    
    [_upvoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kBigInterval);
        make.right.equalTo(self.contentView.mas_right).offset(-kBigInterval);
        make.width.lessThanOrEqualTo(@(26));
        make.height.mas_equalTo(kMainTextHeight);
    }];
    
    _upvoteLabel.textColor = [UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
    
    _upvoteImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"commitUpvote"]];
    [self.contentView addSubview:_upvoteImageView];
    
    [_upvoteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kBigInterval);
        make.right.equalTo(self.upvoteLabel.mas_left).offset(-kLittleInterval);
        make.width.mas_equalTo(kMainTextHeight);
        make.height.mas_equalTo(kMainTextHeight);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.authorLabel.mas_bottom).offset(kLittleInterval);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kLittleInterval);
        make.width.mas_equalTo(kDeviceWidth - (kBigInterval * 2 + 30 + kLittleInterval));
    }];
    
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:17.0];
    
    _replyLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_replyLabel];
    
    [_replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kLittleInterval);
        make.width.mas_equalTo(kDeviceWidth - (kBigInterval * 2 + 30 + kLittleInterval));
    }];
    
    _replyLabel.numberOfLines  = 3;
    _replyLabel.font = [UIFont systemFontOfSize:17.0];
    
    _timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kBigInterval);
        make.left.equalTo(self.avatarImageView.mas_right).offset(kLittleInterval);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(kDateTextHeight);
    }];
    
    _timeLabel.textColor = [UIColor colorWithRed:0.69f green:0.69f blue:0.69f alpha:1.00f];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    
    _unfoldButton = [[UIButton alloc] init];
    [self.contentView addSubview:_unfoldButton];
    
    [_unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kLittleInterval);
        make.right.equalTo(self.contentView.mas_right).offset(-kBigInterval);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(kMainTextHeight + kLittleInterval);
    }];
    
    [_unfoldButton setBackgroundColor:[UIColor colorWithRed:0.85f green:0.89f blue:0.95f alpha:1.00f]];
    [_unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
    [_unfoldButton setTintColor:[UIColor colorWithRed:0.45f green:0.45f blue:0.45f alpha:1.00f]];
}

+ (CGFloat)getCellHeight:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kDeviceWidth - (kBigInterval * 2 + 30 + kLittleInterval), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return ceilf(rect.size.height) + 3 * kBigInterval + kMainTextHeight + kDateTextHeight + kLittleInterval;
}

+ (CGFloat)getHiddenCellHeight:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kDeviceWidth - (kBigInterval * 2 + 30 + kLittleInterval), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil];
    return ceilf(rect.size.height);
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
