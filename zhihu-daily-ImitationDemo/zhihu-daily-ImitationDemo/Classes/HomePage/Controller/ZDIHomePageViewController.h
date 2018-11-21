//
//  ZDIHomePageViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageTableViewGroupView.h"
#import "ZDIHomePageTableViewSectionHeadView.h"
#import "ZDIHomePageCarouselView.h"
#import "YUFoldingTableView.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZDIHomePageViewController : UIViewController

@property (nonatomic, strong) ZDIHomePageTableViewGroupView *homePageTableViewGroupView;

@property (nonatomic, strong) UIImage *navChangeBackImage;

@property (nonatomic, strong) ZDIHomePageTableViewSectionHeadView *homePageTableViewSectionHeadView;

@property (nonatomic, strong) ZDIHomePageCarouselView *carousel;

@property (nonatomic, assign) int days;

@property (nonatomic, assign) BOOL isLoading;

@property (nonatomic, strong) NSMutableArray *headViewDayStrMut;

@property (nonatomic, strong) ZDIDailyDataModel *latestDailyDataModel;

@property (nonatomic, strong) NSMutableArray *tempCarouselImagesMut;

@property (nonatomic, strong) NSMutableArray *everyDailyDateModelMut;


@end

NS_ASSUME_NONNULL_END
