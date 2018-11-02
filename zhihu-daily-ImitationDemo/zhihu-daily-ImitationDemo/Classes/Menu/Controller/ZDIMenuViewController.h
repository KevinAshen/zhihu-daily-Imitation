//
//  ZDIMenuViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIMenuView.h"

@class ZDIMenuViewController;

@protocol MenuControllerDelegate <NSObject>

- (void)menuController:(ZDIMenuViewController *)viewController didSelectItemAtIndex: (NSUInteger)Index;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZDIMenuViewController : UIViewController

//遵守协议的对象
@property (weak, nonatomic) id <MenuControllerDelegate> menuControllerDelegate;

@property (nonatomic, strong) ZDIMenuView *menuView;

@end

NS_ASSUME_NONNULL_END
