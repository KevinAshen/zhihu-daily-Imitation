//
//  ZDIWebPageManager.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageManager.h"

@implementation ZDIWebPageManager
static ZDIWebPageManager *manger = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc] init];
    });
    return manger;
}

- (void)fetchExtraInformationWithID:(NSString *)ID succeed:(ZDIWebPageExtraInformationHandle)succeedBlock error:(ErrorHandle)errorBlock {
    NSString *longCommitURLStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", ID];
    NSURL *extraInformationURL = [NSURL URLWithString:longCommitURLStr];
    NSURLRequest *extraInformationRequest = [NSURLRequest requestWithURL:extraInformationURL];
    NSURLSession *extraInformationSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *extraInformationDataTask = [extraInformationSession dataTaskWithRequest:extraInformationRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            ZDIWebPageExtraInformationModel *webPageExtraInformationModel = [[ZDIWebPageExtraInformationModel alloc] initWithDictionary:resultDic error:&error];
            succeedBlock(webPageExtraInformationModel);
        } else {
            errorBlock(error);
        }
    }];
    [extraInformationDataTask resume];
}

@end
