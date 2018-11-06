//
//  ZDIHomePageTableViewGroupView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageCarouselView.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageTableViewGroupView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDIHomePageCarouselView *carousel;

@end

NS_ASSUME_NONNULL_END
