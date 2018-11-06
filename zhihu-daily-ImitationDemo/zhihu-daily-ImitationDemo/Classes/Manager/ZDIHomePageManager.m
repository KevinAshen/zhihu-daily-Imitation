//
//  ZDIHomePageManager.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageManager.h"


@implementation ZDIHomePageManager

static ZDIHomePageManager *manger = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc] init];
    });
    return manger;
}

- (void)fetchLatestDailyDatasucceed:(ZDILatestDailyDataHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *latestDailyDataURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/latest"];
    NSURL *latestDailyDataURL = [NSURL URLWithString:latestDailyDataURLStr];
    NSURLRequest *latestDailyDataRequest = [NSURLRequest requestWithURL:latestDailyDataURL];
    NSURLSession *latestDailyDataSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *latestDailyDataTask = [latestDailyDataSession dataTaskWithRequest:latestDailyDataRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resultObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDIDailyDataModel *dailyDataModel = [[ZDIDailyDataModel alloc] initWithDictionary:resultObj error:&error];
            NSLog(@"-----test-----dailyDataModel---%@----", dailyDataModel);
            succeedBlock(dailyDataModel);
        } else {
            errorBlock(error);
        }
    }];
    [latestDailyDataTask resume];
    
    
}



@end
