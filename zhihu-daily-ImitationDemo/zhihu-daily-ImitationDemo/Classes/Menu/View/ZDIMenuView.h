//
//  ZDIMenuView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIMenuTableHeadView.h"
#import "ZDIMenuTableFootView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDIMenuView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDIMenuTableHeadView *menuTableHeadView;

@property (nonatomic, strong) ZDIMenuTableFootView *menuTableFootView;

@end

NS_ASSUME_NONNULL_END
