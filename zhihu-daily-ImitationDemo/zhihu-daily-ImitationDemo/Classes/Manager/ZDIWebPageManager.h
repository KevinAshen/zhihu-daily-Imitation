//
//  ZDIWebPageManager.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDIWebPageExtraInformationModel.h"

//请求获取网页的额外信息
typedef void(^ZDIWebPageExtraInformationHandle)(ZDIWebPageExtraInformationModel *extraInformationModel);

//请求失败统一回调block
typedef void(^ErrorHandle)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface ZDIWebPageManager : NSObject

+ (instancetype)sharedManager;

//根据ID获取某篇文章的额外信息
- (void)fetchExtraInformationWithID:(NSString *)ID succeed:(ZDIWebPageExtraInformationHandle)succeedBlock error:(ErrorHandle)errorBlock;

@end

NS_ASSUME_NONNULL_END
