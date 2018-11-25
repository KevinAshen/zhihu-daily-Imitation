//
//  ZDIWebPageExtraInformationModel.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageExtraInformationModel.h"

@implementation ZDIWebPageExtraInformationModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"longComments":@"long_comments",
                                                                  @"shortComments":@"short_comments"
                                                                  
                                                                  }];
}

@end
