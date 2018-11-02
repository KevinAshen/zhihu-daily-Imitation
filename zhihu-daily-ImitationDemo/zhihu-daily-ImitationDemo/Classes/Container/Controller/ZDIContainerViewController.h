//
//  ZDIContainerViewController.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIMenuViewController.h"
#import "ZDIHomePageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZDIContainerViewController : UIViewController

/**菜单控制器*/
@property(strong,nonatomic) ZDIMenuViewController *menuViewController;
/**用来存放和记录当前呈现的主控制器界面*/
@property(strong,nonatomic)UIViewController *contentController;
/**记录容器控制器中，要管理多少个这样的界面*/
@property(strong,nonatomic)NSArray *viewControllers;
/**标记当前菜单是打开还是关闭状态*/
@property(assign,nonatomic,readonly)BOOL isMenuOpen;
/**记录视图控制器在数组中的位置*/
@property(assign,nonatomic) NSUInteger controllerIndex;
/**判断动画是否正在执行*/
@property(assign,nonatomic,readonly)BOOL isAnimating;

@end

NS_ASSUME_NONNULL_END
