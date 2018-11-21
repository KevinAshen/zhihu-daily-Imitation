//
//  ZDICommitPageModel.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageModel.h"

@implementation ZDIReplyToModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id"
                                                    
                                                                  
                                                                  
                                                                  }];
}

@end

@implementation ZDICommentsModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"ID":@"id",
                                                                  @"replyTo":@"reply_to"
                                                                  
                                                                  }];
}

@end

@implementation ZDICommitPageModel

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return  YES;
}


@end
