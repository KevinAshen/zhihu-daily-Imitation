//
//  ZDIHomePageManager.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageManager.h"
#import "ZDIHomePageDBManager.h"

@implementation ZDIHomePageManager

static ZDIHomePageManager *manger = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc] init];
    });
    return manger;
}

- (void)fetchLatestDailyDataWithSucceed:(ZDILatestDailyDataHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *latestDailyDataURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/latest"];
    NSURL *latestDailyDataURL = [NSURL URLWithString:latestDailyDataURLStr];
    NSURLRequest *latestDailyDataRequest = [NSURLRequest requestWithURL:latestDailyDataURL];
    NSURLSession *latestDailyDataSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *latestDailyDataTask = [latestDailyDataSession dataTaskWithRequest:latestDailyDataRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
//            NSString *resultStr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDIDailyDataModel *LatestDailyDataModel = [[ZDIDailyDataModel alloc] initWithDictionary:resultDic error:&error];
            BOOL result = [[ZDIHomePageDBManager sharedManager] dropHomePageLatestDBTable];
            NSLog(@"QSTSD----result   %d", result);
            BOOL test = [[ZDIHomePageDBManager sharedManager] createHomePageLatestDB];
            NSLog(@"QSTSD----test   %d", test);
            BOOL imageResult = [[ZDIHomePageDBManager sharedManager] dropHomePageLatestDBTableForImage];
            NSLog(@"QSTSD----imageResult   %d", imageResult);
            BOOL imageTest = [[ZDIHomePageDBManager sharedManager] createHomePageLatestDBForImage];
            NSLog(@"QSTSD----imageTest   %d", imageTest);
            [[ZDIHomePageDBManager sharedManager] updateHomePageLatestDBWithDic:resultDic];
            [[ZDIHomePageDBManager sharedManager] updateHomePageLatestDBWithDailyDataModel:LatestDailyDataModel];
            succeedBlock(LatestDailyDataModel);
        } else {
            ZDIDailyDataModel *tempDailyDataModel = [[ZDIHomePageDBManager sharedManager] getLatestDailyFromDB];
            NSLog(@"--tempDailyDataModel--    %@", tempDailyDataModel);
            succeedBlock(tempDailyDataModel);
            //errorBlock(error);
        }
    }];
    [latestDailyDataTask resume];
    
    
}

- (void)fetchLatestDailyDataWithDate:(NSString *)date succeed:(ZDILatestDailyDataHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *latestDailyDataURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", date];
    NSURL *latestDailyDataURL = [NSURL URLWithString:latestDailyDataURLStr];
    NSURLRequest *latestDailyDataRequest = [NSURLRequest requestWithURL:latestDailyDataURL];
    NSURLSession *latestDailyDataSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *latestDailyDataTask = [latestDailyDataSession dataTaskWithRequest:latestDailyDataRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDIDailyDataModel *someDailyDataModel = [[ZDIDailyDataModel alloc] initWithDictionary:resultDic error:&error];
            succeedBlock(someDailyDataModel);
        } else {
            errorBlock(error);
        }
    }];
    [latestDailyDataTask resume];
}



@end
