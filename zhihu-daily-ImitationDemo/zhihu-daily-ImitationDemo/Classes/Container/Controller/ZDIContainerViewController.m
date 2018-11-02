//
//  ZDIContainerViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIContainerViewController.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0


@interface ZDIContainerViewController ()

@end

@implementation ZDIContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addMenuViewController];
    [self addContentControllers];
}

//封装菜单界面
- (void)addMenuViewController {
    //创建菜单控制器
    [self setMenuViewController:[[ZDIMenuViewController alloc] init]];
    [self addChildViewController:self.menuViewController];
    
    [self.view addSubview:self.menuViewController.view];
    //self.menuViewController.menuControllerDelegate = self;
    
}

//添加自控制器对象（后期加入多个ViewController就放在这里）
- (void)addContentControllers {
    //完成主控制器的添加
    ZDIHomePageViewController *homePageViewController = [[ZDIHomePageViewController alloc] init];
    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePageViewController];
    [self setViewControllers:@[homePageNav]];
    [self setContentController:homePageNav];
}

//完成控制器的添加和移除
- (void)setContentController:(UIViewController *)contentController {
    if (_contentController == contentController) {
        return;
    }
    
    //内容控制器起始坐标不一致
    if (_contentController) {
        contentController.view.transform = _contentController.view.transform;
    }
    
    //当一个视图控制器从视图控制器容器中被添加或者被删除之前，该方法被调用parent：父视图控制器，如果没有父视图控制器，将为nil
    [_contentController willMoveToParentViewController:nil];
    //移除旧的视图
    [_contentController.view removeFromSuperview];
    //解除父子控制器
    [_contentController removeFromParentViewController];
    
    //增添传进来的视图
    _contentController = contentController;
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
}

- (void) openCloseMenu {
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self->_isAnimating = YES;
        if(!self.isMenuOpen){
            self.contentController.view.transform = CGAffineTransformMakeTranslation(240 / kExamplePictureWidth * kDeviceWidth, 0);
            self.menuViewController.view.transform = CGAffineTransformMakeTranslation(240 / kExamplePictureWidth * kDeviceWidth, 0);
        }
        else {
            self.contentController.view.transform = CGAffineTransformIdentity;
            self.menuViewController.view.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        self->_isMenuOpen = !self->_isMenuOpen;
        self->_isAnimating = NO;
        [self setContentController:self.viewControllers[self.controllerIndex]];
    }];
}

//代理方法的实现
- (void)menuController:(ZDIHomePageViewController *)controller didSelectItemAtIndex: (NSUInteger)index {
    [self setControllerIndex:index];
    
    [self openCloseMenu];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
