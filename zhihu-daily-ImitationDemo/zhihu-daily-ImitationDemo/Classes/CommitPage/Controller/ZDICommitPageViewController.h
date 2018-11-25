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
#import "ZDICommitPageSectionView.h"
#import "ZDICommitPageTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageViewController : UIViewController

@property (nonatomic, copy)NSString *IDStr;

@property (nonatomic, strong)ZDICommitPageView *commitPageView;

@property (nonatomic, strong)ZDICommitPageSectionView *commitPageSectionView;

@property (nonatomic, strong) UIImage *navChangeBackImage;

@property (nonatomic, assign)int longCommits;

@property (nonatomic, assign)int shortCommits;

@property (nonatomic, assign)int allCommits;

@property (nonatomic, strong)ZDICommitPageModel *shortCommitPageModel;

@property (nonatomic, strong)ZDICommitPageModel *longCommitPageModel;

//缓存cell高度
@property (nonatomic, strong) NSMutableArray *cellLongCommitHeightArray;

@property (nonatomic, strong) NSMutableArray *cellShortCommitHeightArray;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, assign)int flag;

@property (nonatomic, assign)int tapFlag;

@end

NS_ASSUME_NONNULL_END
