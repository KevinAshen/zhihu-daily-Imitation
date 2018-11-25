//
//  ZDICommitPageManager.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDICommitPageModel.h"

//请求获取评论
typedef void(^ZDICommitPageHandle)(ZDICommitPageModel *commitPageModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface ZDICommitPageManager : NSObject

+ (instancetype)sharedManager;

//根据ID获取某篇文章的长评方法
- (void)fetchLongCommitWithID:(NSString *)ID succeed:(ZDICommitPageHandle)succeedBlock error:(ErrorHandle)errorBlock;

//根据ID获取某篇文章的短评方法
- (void)fetchShortCommitWithID:(NSString *)ID succeed:(ZDICommitPageHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end

NS_ASSUME_NONNULL_END
