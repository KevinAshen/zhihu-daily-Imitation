//
//  ZDICommitPageManager.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageManager.h"


@implementation ZDICommitPageManager
static ZDICommitPageManager *manger = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc] init];
    });
    return manger;
}

-(void)fetchLongCommitWithID:(NSString *)ID succeed:(ZDICommitPageHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *longCommitURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", ID];
    NSURL *longCommitURL = [NSURL URLWithString:longCommitURLStr];
    NSURLRequest *longCommitRequest = [NSURLRequest requestWithURL:longCommitURL];
    NSURLSession *longCommitSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *longCommitDataTask = [longCommitSession dataTaskWithRequest:longCommitRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDICommitPageModel *longCommitPageModel = [[ZDICommitPageModel alloc] initWithDictionary:resultDic error:&error];
            succeedBlock(longCommitPageModel);
        } else {
            errorBlock(error);
        }
    }];
    [longCommitDataTask resume];
}

- (void)fetchShortCommitWithID:(NSString *)ID succeed:(ZDICommitPageHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *shortCommitURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", ID];
    NSURL *shortCommitURL = [NSURL URLWithString:shortCommitURLStr];
    NSURLRequest *shortCommitRequest = [NSURLRequest requestWithURL:shortCommitURL];
    NSURLSession *shortCommitSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *shortCommitDataTask = [shortCommitSession dataTaskWithRequest:shortCommitRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDICommitPageModel *longCommitPageModel = [[ZDICommitPageModel alloc] initWithDictionary:resultDic error:&error];
            succeedBlock(longCommitPageModel);
        } else {
            errorBlock(error);
        }
    }];
    [shortCommitDataTask resume];
}

@end
