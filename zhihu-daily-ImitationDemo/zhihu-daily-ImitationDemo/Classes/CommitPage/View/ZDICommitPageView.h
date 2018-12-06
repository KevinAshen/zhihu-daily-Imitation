//
//  ZDICommitPageView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDICommitPageModel.h"
#import "ZDICommitPagePlaceholderView.h"
#import "ZDICommitPageSectionView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZDICommitPageViewDelegate <NSObject>

//长评unfold的点击事件，进行收起展开
- (void)unfoldLongWithButtonInCell:(UIButton *)button;

//短评unfold的点击事件，进行收起展开
- (void)unfoldShortWithButtonInCell:(UIButton *)button;

@end

@interface ZDICommitPageView : UIView

@property (nonatomic, strong)ZDICommitPageModel *longCommitPageModel;

@property (nonatomic, strong)ZDICommitPageModel *shortCommitPageModel;

@property (nonatomic, strong)ZDICommitPagePlaceholderView *commitPagePlaceholderView;

@property (nonatomic, assign)int longCommits;

@property (nonatomic, assign)int shortCommits;

@property (nonatomic, assign)int allCommits;

//缓存cell高度
@property (nonatomic, strong) NSMutableArray *cellLongCommitHeightArray;

@property (nonatomic, strong) NSMutableArray *cellShortCommitHeightArray;

//判断是否需要占位View的标志
@property (nonatomic, assign)int flag;

@property (nonatomic, assign)int tapFlag;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)ZDICommitPageSectionView *commitPageSectionView;

//存放判断是否cell是否展开状态的数组
@property (nonatomic, strong) NSMutableArray *longCommitsCellFoldStateArray;
@property (nonatomic, strong) NSMutableArray *shortCommitsCellFoldStateArray;

//设置代理
@property (nonatomic, weak) id<ZDICommitPageViewDelegate> commitPageViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame andLongCommits:(int)longCommits andShortCommits:(int)shortCommits;

@end

NS_ASSUME_NONNULL_END
