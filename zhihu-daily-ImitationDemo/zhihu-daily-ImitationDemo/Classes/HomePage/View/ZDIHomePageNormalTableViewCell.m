//
//  ZDIHomePageNormalTableViewCell.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageNormalTableViewCell.h"
#import <Masonry.h>

@implementation ZDIHomePageNormalTableViewCell
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
    self.titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test1.JPG"]];
    [self.contentView addSubview:self.titleImageView];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10 / kExamplePictureHeight * kDeviceHeight);
        make.right.equalTo(self.contentView).offset(10 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(90 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(65 / kExamplePictureHeight * kDeviceHeight);
    }];
    
//    self.titleLabel = [[UILabel alloc] init];
//    [self.contentView addSubview:self.titleLabel];
//    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        <#code#>
//    }];
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
