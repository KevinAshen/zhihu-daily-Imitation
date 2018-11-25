//
//  ZDICommitPageViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommitPageView.h"
#import "ZDICommitPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageViewController : UIViewController

@property (nonatomic, copy)NSString *IDStr;

@property (nonatomic, strong)ZDICommitPageView *commitPageView;

@property (nonatomic, strong) UIImage *navChangeBackImage;

@property (nonatomic, assign)int longCommits;

@property (nonatomic, assign)int shortCommits;

@property (nonatomic, assign)int allCommits;

@property (nonatomic, strong)ZDICommitPageModel *shortCommitPageModel;

@end

NS_ASSUME_NONNULL_END
