//
//  ZDIHomePageTableViewSectionHeadView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/2.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageTableViewSectionHeadView : UIView

@property (nonatomic, strong) UILabel *dateLabel;

- (instancetype) initWithFrame:(CGRect)frame andDateStr:(NSString *)dateStr;

@end

NS_ASSUME_NONNULL_END
