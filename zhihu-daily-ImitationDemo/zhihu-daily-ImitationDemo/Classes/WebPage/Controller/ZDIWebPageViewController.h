//
//  ZDIWebPageViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/18.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIWebPageView.h"
#import "ZDIWebPageBottomView.h"
#import "ZDIWebPageExtraInformationModel.h"
@class ZDIWebPageBounceView;

NS_ASSUME_NONNULL_BEGIN

@interface ZDIWebPageViewController : UIViewController

@property (nonatomic, strong)ZDIWebPageView *webPageView;

@property (nonatomic, strong)ZDIWebPageBottomView *webPageBottomView;

@property (nonatomic, strong)ZDIWebPageBounceView *webPageBounceView;

@property (nonatomic, strong)ZDIWebPageExtraInformationModel *webPageExtraInformationModel;

@property (nonatomic, assign)BOOL skipFlag;

@property (nonatomic, assign)BOOL collectFlag;

@property (nonatomic, copy)NSString *IDStr;

//所有的数据数组
@property (nonatomic, strong) NSMutableArray *everyDailyDateModelMut;

//天数，用来进行网络请求
@property (nonatomic, assign) int days;

//当前是数组中的第几个
@property (nonatomic, assign)NSInteger nowArrIndex;

//当前是该天中的第几个
@property (nonatomic, assign)NSInteger nowDayIndex;

//当天一共有几篇文章
@property (nonatomic, assign)NSInteger textNumber;

@end

NS_ASSUME_NONNULL_END
