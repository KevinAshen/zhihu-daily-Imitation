//
//  ZDIHomePageManager.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDIDailyDataModel.h"

//请求当日最新的数据（轮播图）
typedef void(^ZDILatestDailyDataHandle)(ZDIDailyDataModel *latestDataModel);

// 请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageManager : NSObject

+ (instancetype)sharedManager;

// 获取当日最新的数据（轮播图）方法
- (void)fetchLatestDailyDataWithSucceed:(ZDILatestDailyDataHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end

NS_ASSUME_NONNULL_END
