//
//  ZDICommitPageViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommitPageModel.h"
#import "ZDICommitPageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageViewController : UIViewController

@property (nonatomic, copy)NSString *IDStr;

@property (nonatomic, strong)ZDICommitPageView *commitPageView;

@end

NS_ASSUME_NONNULL_END
