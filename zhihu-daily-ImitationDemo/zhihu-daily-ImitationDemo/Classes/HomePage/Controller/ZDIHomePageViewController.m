//
//  ZDIHomePageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageViewController.h"
#import "ZDIHomePageTableViewSectionHeadView.h"
#import "ZDIHomePageManager.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@interface ZDIHomePageViewController ()<ZDIHomePageCarouselViewDelegate, UITableViewDelegate, UIScrollViewDelegate>

@end

@implementation ZDIHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLatestDaily];
    NSLog(@"---%@--_homePageTableViewGroupView.latestDailyDataModel.stories.count--", _homePageTableViewGroupView.latestDailyDataModel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.navigationItem.title = @"今日热闻";
    
    _homePageTableViewGroupView = [[ZDIHomePageTableViewGroupView alloc] init];
    [self.view addSubview:_homePageTableViewGroupView];
    
    [_homePageTableViewGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
    }];

    self.homePageTableViewGroupView.tableView.delegate = self;
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu"] style:UIBarButtonItemStylePlain target:self action:@selector(openCloseMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.shadowImage= [UIImage new];
    

    
}

- (void)updateLatestDaily {
    [[ZDIHomePageManager sharedManager] fetchLatestDailyDataWithSucceed:^(ZDIDailyDataModel *latestDataModel) {
        self.homePageTableViewGroupView.latestDailyDataModel = [[ZDIDailyDataModel alloc] init];
        self.homePageTableViewGroupView.latestDailyDataModel = latestDataModel;
        //NSLog(@"---%@----", self.homePageTableViewGroupView.latestDailyDataModel);
        NSLog(@"添加成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homePageTableViewGroupView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
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
    } else if (section == 1) {
        return 44;
    } else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        return nil;
    } else if (section == 1) {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _homePageTableViewSectionHeadView = [[ZDIHomePageTableViewSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        return _homePageTableViewSectionHeadView;
    } else {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _homePageTableViewSectionHeadView = [[ZDIHomePageTableViewSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
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
    if (scrollView.contentOffset.y < ((100 / kExamplePictureHeight * kDeviceHeight * 13) + 230 / kExamplePictureHeight * kDeviceHeight)) {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.navigationController.navigationBar.hidden = NO;
        self.navigationItem.title = @"今日热闻";
        
        _navChangeBackImage = [ZDIHomePageViewController createImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f] andAlpha:scrollView.contentOffset.y / (235.0 - 44) / kExamplePictureHeight * kDeviceHeight];
        
        [self.navigationController.navigationBar setBackgroundImage:_navChangeBackImage forBarMetrics:UIBarMetricsDefault];
        
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
        
        
    } else {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
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
