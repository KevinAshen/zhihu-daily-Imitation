//
//  ZDICommitPageTableViewCell.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageTableViewCell : UITableViewCell


+ (CGFloat)getCellHeight:(NSString *)content;

@property (nonatomic, strong) UILabel *authorLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *replyLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UIImageView *upvoteImageView;

@property (nonatomic, strong) UILabel *upvoteLabel;

@end

NS_ASSUME_NONNULL_END
