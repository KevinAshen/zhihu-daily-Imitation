//
//  ZDIHomePageDBManager.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageDBManager.h"
#import "ZDIDailyDataModel.h"
#import <FMDB.h>

@interface ZDIHomePageDBManager() {
    NSString *a;    //大括号形式
}

//全是属性
@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSDictionary *dic;

@property (nonatomic, copy) NSString *JSONStr;

@end

@implementation ZDIHomePageDBManager

static ZDIHomePageDBManager *manager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZDIHomePageDBManager alloc] init];
    });
    return manager;
}

- (BOOL)createHomePageLatestDB {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE 'homePageLatest_down_course' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'courseInfo' text)"];
        if (result) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
        [_db close];
        return result;
    } else {
        NSLog(@"打开数据库失败");
        return NO;
    }
}

- (BOOL)createHomePageLatestDBForImage {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"CREATE TABLE 'homePageLatestImage_down_course' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'imageData' BLOB)"];
        if (result) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
        [_db close];
        return result;
    } else {
        NSLog(@"打开数据库失败");
        return NO;
    }
}

- (void)updateHomePageLatestDBWithDic:(NSDictionary *)dic {
    NSString *resultStr = [self dictionaryToJson:dic];
    if ([_db open]) {
        NSString *insertSql = @"insert into 'homePageLatest_down_course'(courseInfo) values(?)";
        BOOL result = [_db executeUpdate:insertSql, resultStr];
        if (result) {
            NSLog(@"更新成功");
        } else {
            NSLog(@"更新失败");
        }
    } else {
        NSLog(@"打开失败");
    }
    [_db close];
}

- (void)updateHomePageLatestDBWithDailyDataModel:(ZDIDailyDataModel *)dailyDataModel {
    if ([_db open]) {
        NSString *insertSql = @"insert into 'homePageLatestImage_down_course'(imageData) values(?)";
        for (int i = 0; i < dailyDataModel.top_stories.count; i++) {
            NSString *tempCarouselStr = [dailyDataModel.top_stories[i] imageStr];
            NSData *tempCarouselData = [NSData dataWithContentsOfURL:[NSURL URLWithString:tempCarouselStr]];
            BOOL result = [_db executeUpdate:insertSql, tempCarouselData];
            if (result) {
                NSLog(@"更新DBWithData成功");
            } else {
                NSLog(@"更新DBWithData失败");
            }
        }
    } else {
        NSLog(@"打开失败");
    }
    [_db close];
}



- (NSInteger)returnCount {
    return _count;
}

- (ZDIDailyDataModel *)getLatestDailyFromDB {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        NSString *selectSql = @"select * from homePageLatest_down_course";
        FMResultSet *rs = [_db executeQuery:selectSql];
        while ([rs next]) {
            NSString *courseInfo = [rs stringForColumn:@"courseInfo"];
            
            _JSONStr = courseInfo;
            NSLog(@"--courseInfo--    %@---QSTSDJKW", _JSONStr);
        }
    } else {
        NSLog(@"--getLatestDailyFromDB--    打开失败---");
    }
    [_db close];
    NSMutableDictionary *tempDic = [self dictionaryWithJsonString:_JSONStr];
    ZDIDailyDataModel *LatestDailyDataModel = [[ZDIDailyDataModel alloc] initWithDictionary:tempDic error:nil];
    NSLog(@"%@----QSTSDSDSD", LatestDailyDataModel);
    return LatestDailyDataModel;
}

- (NSData *)getLatestDailyImageFromDBWithID:(NSInteger)ID {
    NSInteger i = 0;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        NSString *selectSql = @"select * from homePageLatestImage_down_course";
        FMResultSet *rs = [_db executeQuery:selectSql];
        while ([rs next]) {
            NSData *tempData = [rs dataForColumn:@"imageData"];
            if (i == ID) {
                [_db close];
                return tempData;
            }
            i++;
        }
    } else {
        NSLog(@"--getLatestDailyFromDB--    打开失败---");
    }
    [_db close];
    return nil;
}

- (BOOL)dropHomePageLatestDBTableForImage {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"drop table homePageLatestImage_down_course"];
        if (result) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
        [_db close];
        return result;
    } else {
        NSLog(@"homePageLatestImage_down_course失败");
    }
    [_db close];
    return NO;
}

- (BOOL)dropHomePageLatestDBTable {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _fileName = [docPath stringByAppendingPathComponent:@"homePageLatestDB.sqlite"];
    NSLog(@"----    %@", _fileName);
    _db = [FMDatabase databaseWithPath:_fileName];
    if ([_db open]) {
        BOOL result = [_db executeUpdate:@"drop table homePageLatest_down_course"];
        if (result) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
        [_db close];
        return result;
    } else {
        NSLog(@"dropHomePageLatestDBTable失败");
    }
    [_db close];
    return NO;
}
/* 字符串转字典 */
-(NSMutableDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers
                                                                 error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/* 字典转JSON字符串 */
-(NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
