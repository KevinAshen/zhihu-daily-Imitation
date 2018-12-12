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
#import "ZDIWebPageViewController.h"
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
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.days = 0;
    
    _headViewDayStrMut = [[NSMutableArray alloc] init];
    
    _everyDailyDateModelMut = [[NSMutableArray alloc] init];
    
    _transmitEveryDailyDateModelMut = [NSMutableArray array];
    
    _tempArr = [NSArray array];
    
    [self updateLatestDaily];
    [self updateSomeDailyWithDate:[ZDIHomePageViewController getSomeDayFromTodayWithNextDay:self.days]];
    NSString *tempStr = [ZDIHomePageViewController getWeekDayFromTodayWithNextDay:self.days + 1];
    [self.headViewDayStrMut addObject:tempStr];
    
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
        self.latestDailyDataModel = [[ZDIDailyDataModel alloc] init];
        self.latestDailyDataModel = latestDataModel;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homePageTableViewGroupView.tableView reloadData];
            NSArray *tempCarouselImageArr = [self getCarouselImagesWithModel:latestDataModel];
            NSArray *tempCarouselTitleArr = [self getCarouselImageTitleWithModel:latestDataModel];
            NSArray *tempCarouselIDArr = [self getCarouselIDStrWithModel:latestDataModel];
            [self.homePageTableViewGroupView setScrollViewImage:tempCarouselImageArr andTitles:tempCarouselTitleArr andID:tempCarouselIDArr];
        });
        
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updateSomeDailyWithDate:(NSString *)date {
    self.isLoading = YES;
    [[ZDIHomePageManager sharedManager] fetchLatestDailyDataWithDate:date succeed:^(ZDIDailyDataModel *someDailyDateModel) {
        [self.homePageTableViewGroupView.everyDailyDateModelMut addObject:someDailyDateModel];
        [self.everyDailyDateModelMut addObject:someDailyDateModel];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homePageTableViewGroupView.tableView reloadData];
            self.isLoading = NO;
            self.days++;
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
        _homePageTableViewSectionHeadView = [[ZDIHomePageTableViewSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) andDateStr:_headViewDayStrMut[section - 1]];
        return _homePageTableViewSectionHeadView;
    } else {
        self.homePageTableViewGroupView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        _homePageTableViewSectionHeadView = [[ZDIHomePageTableViewSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) andDateStr:_headViewDayStrMut[section - 1]];
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
    CGPoint offset = scrollView.contentOffset;
    double change = 100 / kExamplePictureHeight * kDeviceHeight * _homePageTableViewGroupView.latestDailyDataModel.stories.count + 230 / kExamplePictureHeight * kDeviceHeight;
    //导航栏变化
    if (scrollView.contentOffset.y < change) {
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
    //下滑更新更多
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    float y = offset.y + bounds.size.height;
    float h = contentSize.height;
    float reloadDistance = -30;
    if (y > h + reloadDistance) {
        if (self.isLoading) {
            return;
        } else {
            [self updateSomeDailyWithDate:[ZDIHomePageViewController getSomeDayFromTodayWithNextDay:self.days]];
            NSString *tempStr = [ZDIHomePageViewController getWeekDayFromTodayWithNextDay:self.days + 1];
            [self.headViewDayStrMut addObject:tempStr];
        }
    }
}

- (NSArray *)getCarouselImagesWithModel:(ZDIDailyDataModel *)dailyDataModel {
    NSMutableArray *tempCarouselImageMut = [[NSMutableArray alloc] init];
    for (int i = 0; i < dailyDataModel.top_stories.count; i++) {
        NSString *tempCarouselStr = [self.homePageTableViewGroupView.latestDailyDataModel.top_stories[i] imageStr];
        UIImage *tempCarouselImage = [self.homePageTableViewGroupView getImageFromURL:tempCarouselStr];
        [tempCarouselImageMut addObject:tempCarouselImage];
    }
    NSArray *tempCarouselImageArr = [NSArray arrayWithArray:tempCarouselImageMut];
    return tempCarouselImageArr;
}

- (NSArray *)getCarouselImageTitleWithModel:(ZDIDailyDataModel *)dailyDataModel {
    NSMutableArray *tempCarouselImageMut = [[NSMutableArray alloc] init];
    for (int i = 0; i < dailyDataModel.top_stories.count; i++) {
        NSString *tempCarouselStr = [self.homePageTableViewGroupView.latestDailyDataModel.top_stories[i] title];
        [tempCarouselImageMut addObject:tempCarouselStr];
    }
    NSArray *tempCarouselTitleArr = [NSArray arrayWithArray:tempCarouselImageMut];
    return tempCarouselTitleArr;
}

- (NSArray *)getCarouselIDStrWithModel:(ZDIDailyDataModel *)dailyDataModel {
    NSMutableArray *tempCarouselIDMut = [[NSMutableArray alloc] init];
    for (int i = 0; i < dailyDataModel.top_stories.count; i++) {
        NSString *tempCarouselIDStr = [self.homePageTableViewGroupView.latestDailyDataModel.top_stories[i] ID];
        [tempCarouselIDMut addObject:tempCarouselIDStr];
    }
    NSArray *tempCarouselIDArr = [NSArray arrayWithArray:tempCarouselIDMut];
    return tempCarouselIDArr;
}

+ (NSString *)getSomeDayFromTodayWithNextDay:(int)nextDay {
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    [components setDay:([components day] - nextDay)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyyMMdd"];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSString *)getWeekDayFromTodayWithNextDay:(int)nextDay {
    NSDate *currentDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    [components setDay:([components day] - nextDay)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"MM月dd日 "];
    
    NSString *resultStr = [[dateday stringFromDate:beginningOfWeek] stringByAppendingString:[ZDIHomePageViewController getWeekDayFordate:beginningOfWeek]];
    
    return resultStr;
}

+ (NSString *)getWeekDayFordate:(NSDate *)date {
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDIWebPageViewController *webPageViewController = [[ZDIWebPageViewController alloc] init];
    webPageViewController.everyDailyDateModelMut = [[NSMutableArray alloc] initWithArray:_everyDailyDateModelMut copyItems:YES];
    [webPageViewController.everyDailyDateModelMut insertObject:_latestDailyDataModel atIndex:0];
    webPageViewController.days = _days;
    webPageViewController.nowArrIndex = indexPath.section;
    webPageViewController.nowDayIndex = indexPath.row;
    if (indexPath.section == 0) {
        webPageViewController.IDStr = [_latestDailyDataModel.stories[indexPath.row] id];
        webPageViewController.textNumber = _latestDailyDataModel.stories.count;
    } else {
        ZDIDailyDataModel *tempDailyDataModel = _everyDailyDateModelMut[indexPath.section - 1];
        webPageViewController.IDStr = [tempDailyDataModel.stories[indexPath.row] id];
        webPageViewController.textNumber = tempDailyDataModel.stories.count;
    }
    
    [self.navigationController pushViewController:webPageViewController animated:YES];
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
