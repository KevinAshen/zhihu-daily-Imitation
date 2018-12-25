//
//  ZDIHomePageDBManager.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZDIDailyDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageDBManager : NSObject

- (BOOL)createHomePageLatestDB;

- (BOOL)createHomePageLatestDBForImage;

- (void)updateHomePageLatestDBWithDic:(NSDictionary *)dic;


- (NSInteger)returnCount;

+ (instancetype)sharedManager;

- (ZDIDailyDataModel *)getLatestDailyFromDB;

- (NSData *)getLatestDailyImageFromDBWithID:(NSInteger)ID;

- (BOOL)dropHomePageLatestDBTable;

- (BOOL)dropHomePageLatestDBTableForImage;

- (void)updateHomePageLatestDBWithDailyDataModel:(ZDIDailyDataModel *)dailyDataModel;

@end

NS_ASSUME_NONNULL_END
