//
//  ZDICommitPageView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommitPageModel.h"
#import "YUFoldingTableView.h"
#import "ZDICommitPagePlaceholderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageView : UIView

@property (nonatomic, strong)ZDICommitPageModel *longCommitPageModel;

@property (nonatomic, strong)ZDICommitPageModel *shortCommitPageModel;

@property (nonatomic, strong)YUFoldingTableView *foldingTableView;

@property (nonatomic, strong)ZDICommitPagePlaceholderView *commitPagePlaceholderView;

@property (nonatomic, assign)int longCommits;

@property (nonatomic, assign)int shortCommits;

@property (nonatomic, assign)int allCommits;

//缓存cell高度
@property (nonatomic, strong) NSMutableArray *cellLongCommitHeightArray;

@property (nonatomic, strong) NSMutableArray *cellShortCommitHeightArray;

//判断是否需要占位View的标志
@property (nonatomic, assign)int flag;

- (instancetype)initWithFrame:(CGRect)frame andLongCommits:(int)longCommits andShortCommits:(int)shortCommits;

- (void)calculateHeight;

@end

NS_ASSUME_NONNULL_END
