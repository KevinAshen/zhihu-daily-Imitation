//
//  ZDICommitPageModel.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "JSONModel.h"

@protocol ZDICommentsModel

@end

@protocol ZDIReplyToModel

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZDIReplyToModel : JSONModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *author;

@end

@interface ZDICommentsModel : JSONModel

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) int likes;
@property (nonatomic, strong) ZDIReplyToModel *replyTo;
@end

@interface ZDICommitPageModel : JSONModel

@property (nonatomic, copy) NSArray<ZDICommentsModel>*comments;

@end

NS_ASSUME_NONNULL_END
