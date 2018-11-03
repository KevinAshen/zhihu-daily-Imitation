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
    
    
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18 / kExamplePictureHeight * kDeviceHeight);
        make.right.equalTo(self.contentView.mas_right).offset(-18 / kExamplePictureWidth * kDeviceWidth);
        make.width.mas_equalTo(90 / kExamplePictureWidth * kDeviceWidth);
        make.height.mas_equalTo(65 / kExamplePictureHeight * kDeviceHeight);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18 / kExamplePictureHeight * kDeviceHeight);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-18 / kExamplePictureHeight * kDeviceHeight);
        make.left.equalTo(self.contentView.mas_left).offset(18 / kExamplePictureWidth * kDeviceWidth);
        make.right.equalTo(self.titleImageView.mas_left).offset(-18 / kExamplePictureWidth * kDeviceWidth);
        
    }];
    
    //test
    self.titleLabel.text = @"这是最孤寂的时刻。在静静的午夜，宇宙向它的聆听者展示着广漠的荒凉。叶文洁最不愿意看的，就是显示器上缓缓移动的那条曲线";
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
