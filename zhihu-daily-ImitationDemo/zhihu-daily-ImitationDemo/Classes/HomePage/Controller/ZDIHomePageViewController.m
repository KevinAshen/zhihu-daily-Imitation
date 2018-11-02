//
//  ZDIHomePageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageViewController.h"
#import "ZDIHomePageCarouselView.h"
#import "ZDIHomePageTableViewSectionHeadView.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@interface ZDIHomePageViewController ()<ZDIHomePageCarouselViewDelegate, UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation ZDIHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    ZDIHomePageCarouselView *carousel = [[ZDIHomePageCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230 / kExamplePictureHeight * kDeviceHeight)];
    carousel.images = @[
                        [UIImage imageNamed:@"0.JPG"],
                        [UIImage imageNamed:@"1.JPG"],
                        [UIImage imageNamed:@"2.JPG"],
                        [UIImage imageNamed:@"3.JPG"],
                        [UIImage imageNamed:@"4.JPG"]
                        ];
    carousel.currentPageColor = [UIColor orangeColor];
    carousel.pageColor = [UIColor grayColor];
    
    
    self.navigationItem.title = @"今日热闻";
    
    _homePageTableViewGroupView = [[ZDIHomePageTableViewGroupView alloc] init];
    [self.view addSubview:_homePageTableViewGroupView];
    
    _homePageTableViewGroupView.tableView.tableHeaderView = carousel;
    
    _homePageTableViewGroupView.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [_homePageTableViewGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
    }];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    CGRect frame = self.navigationController.navigationBar.frame;
//    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height + 20)];
//    alphaView.backgroundColor = [UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f];
//    alphaView.userInteractionEnabled = NO;
//    [self.navigationController.navigationBar insertSubview: alphaView atIndex:0];
    
    self.homePageTableViewGroupView.tableView.delegate = self;
    
    //   菜单按钮的设置
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
}

/**侧边栏的展开和关闭*/
- (void)openCloseMenu: (UIBarButtonItem *)sender
{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}

- (void)carouselView:(ZDIHomePageCarouselView *)homePageCarouselView indexOfClickedImageBtn:(NSUInteger )index {
    NSLog(@"点击了第%ld张图片",index);
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 / kExamplePictureHeight * kDeviceHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 64;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        _homePageTableViewSectionHeadView = [[ZDIHomePageTableViewSectionHeadView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
//        NSString *sectionStr = [NSString stringWithFormat:@"%lu", section];
//        _homePageTableViewSectionHeadView.dateLabel.text = sectionStr;
        return _homePageTableViewSectionHeadView;
    }
}

+ (UIImage *)createImageWithColor:(UIColor *)color andAlpha:(CGFloat)alpha {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(theImage.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, theImage.size.width, theImage.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, theImage.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 420) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        
        _navChangeBackImage = [ZDIHomePageViewController createImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f] andAlpha:scrollView.contentOffset.y / (235.0 - 44) / kExamplePictureHeight * kDeviceHeight];
        
        [self.navigationController.navigationBar setBackgroundImage:_navChangeBackImage forBarMetrics:UIBarMetricsDefault];
        
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
        
        
    } else {
        
       

        [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f]];
        self.navigationController.navigationBar.hidden = YES;
    }
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
