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

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageView : UIView

@property (nonatomic, strong)ZDICommitPageModel *longCommitPageModel;

@property (nonatomic, strong)ZDICommitPageModel *shortCommitPageModel;

@property (nonatomic, strong)YUFoldingTableView *foldingTableView;

@end

NS_ASSUME_NONNULL_END
