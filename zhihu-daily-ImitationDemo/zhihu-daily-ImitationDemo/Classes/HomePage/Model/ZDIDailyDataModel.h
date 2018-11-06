//
//  ZDIDailyDataModel.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "JSONModel.h"

@protocol ZDITop_storiesJSONModel

@end

@protocol ZDIStoriesJSONModel

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZDITop_storiesJSONModel : JSONModel

@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *title;

@end

@interface ZDIStoriesJSONModel : JSONModel

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *ga_prefix;
@property (nonatomic, copy) NSString *title;

@end

@interface ZDIDailyDataModel : JSONModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSArray<ZDITop_storiesJSONModel>*top_stories;
@property (nonatomic, copy) NSArray<ZDIStoriesJSONModel>*stories;

@end

NS_ASSUME_NONNULL_END
