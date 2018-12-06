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

//缓存应该隐藏的cell高度
@property (nonatomic, strong) NSMutableArray *cellHiddenLongCommitHeightArray;
@property (nonatomic, strong) NSMutableArray *cellHiddenShortCommitHeightArray;

//缓存实际cell高度
@property (nonatomic, strong) NSMutableArray *cellFinalLongCommitHeightArray;
@property (nonatomic, strong) NSMutableArray *cellFinalShortCommitHeightArray;

//存放判断是否cell是否展开状态的数组
@property (nonatomic, strong) NSMutableArray *longCommitsCellFoldStateArray;
@property (nonatomic, strong) NSMutableArray *shortCommitsCellFoldStateArray;


@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, assign)int flag;

@property (nonatomic, assign)int tapFlag;

@property (nonatomic, assign)CGFloat hiddenStandard;

@end

NS_ASSUME_NONNULL_END
