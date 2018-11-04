//
//  ZDIMenuTableViewCell.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIMenuTableViewCell.h"
#import <Masonry.h>

@implementation ZDIMenuTableViewCell
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self CreateUI];
    }
    return self;
}

- (void) CreateUI {
    self.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    self.contentView.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    
    _leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homePage"]];
    [self.contentView addSubview:_leftImageView];
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.width.mas_equalTo(20 / kExamplePictureWidth * kDeviceWidth);
        make.top.equalTo(self.contentView.mas_top).offset(18 / kExamplePictureHeight * kDeviceHeight);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(20 / kExamplePictureHeight * kDeviceHeight);
        make.width.mas_equalTo(100 / kExamplePictureWidth * kDeviceWidth);
        make.top.equalTo(self.contentView.mas_top).offset(18 / kExamplePictureHeight * kDeviceHeight);
        make.height.mas_equalTo(20 / kExamplePictureHeight * kDeviceHeight);
    }];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"首页";
    
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
