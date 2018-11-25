//
//  ZDIWebPageExtraInformationModel.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDIWebPageExtraInformationModel : JSONModel

@property (nonatomic, assign) int longComments;
@property (nonatomic, assign) int popularity;
@property (nonatomic, assign) int shortComments;
@property (nonatomic, assign) int comments;

@end

NS_ASSUME_NONNULL_END
