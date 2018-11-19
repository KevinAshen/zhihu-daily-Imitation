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


NS_ASSUME_NONNULL_BEGIN

@interface ZDIWebPageViewController : UIViewController

@property (nonatomic, strong)ZDIWebPageView *webPageView;

@property (nonatomic, strong)ZDIWebPageBottomView *webPageBottomView;

@property (nonatomic, copy)NSString *IDStr;

@end

NS_ASSUME_NONNULL_END
