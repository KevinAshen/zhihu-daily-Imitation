//
//  ZDIHomePageTableViewGroupView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageCarouselView.h"
#import "ZDIDailyDataModel.h"



NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageTableViewGroupView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZDIHomePageCarouselView *carousel;

@property (nonatomic, strong) ZDIDailyDataModel *latestDailyDataModel;

@property (nonatomic, strong) NSMutableArray *tempCarouselImagesMut;

@property (nonatomic, strong) NSMutableArray *everyDailyDateModelMut;

- (UIImage *)getImageFromURL:(NSString *)fileURL;

- (void)setScrollViewImage:(NSArray *)images andTitles:(NSArray *)titles andID:(NSArray *)ID;

@end

NS_ASSUME_NONNULL_END
