//
//  ZDIDailyDataModel.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/6.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIDailyDataModel.h"

@implementation ZDIStoriesJSONModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

@end

@implementation ZDITop_storiesJSONModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id",
                                                                  @"imageStr":@"image"

                                                                  }];
}

@end

@implementation ZDIDailyDataModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}



@end
