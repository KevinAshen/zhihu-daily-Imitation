//
//  ZDIWebPageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/18.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageViewController.h"
#import "ZDICommitPageViewController.h"
#import "ZDICommitPageManager.h"
#import "ZDIWebPageManager.h"
#import "ZDIHomePageManager.h"
#import "ZDIDailyDataModel.h"
#import "ZDIWebPageBounceView.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kZDIWebPageBounceViewHeight [UIScreen mainScreen].bounds.size.height / 2.0
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@interface ZDIWebPageViewController ()<UIScrollViewDelegate>

@end

@implementation ZDIWebPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateExtraInformationWithID:_IDStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    [self setupWKWebViewWithID:_IDStr];
}

- (void) setupWKWebViewWithID:(NSString *)ID {
    _skipFlag = NO;
    
    _collectFlag = YES;
    
    _webPageView = [[ZDIWebPageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) AndIDStr:ID];
    [self.view addSubview:_webPageView];
    
    _webPageView.webView.scrollView.delegate = self;
    
    _webPageBottomView = [[ZDIWebPageBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - (50 / kExamplePictureHeight * kExamplePictureHeight), kDeviceWidth, 50 / kExamplePictureHeight * kExamplePictureHeight)];
    [self.view addSubview:_webPageBottomView];
    
    [_webPageBottomView.returnButton addTarget:self action:@selector(touchReturn) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.shareButton addTarget:self action:@selector(touchShare) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.commitButton addTarget:self action:@selector(touchCommit) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.nextButton addTarget:self action:@selector(touchNext) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchCommit {
    [self updatePresentCommit];
}

- (void)touchNext {
    [_webPageView.webView.scrollView setContentOffset:CGPointMake(0, _webPageView.webView.scrollView.contentSize.height) animated:YES];
}

- (void)touchShare {
    _webPageBounceView = [[ZDIWebPageBounceView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [_webPageBounceView showInView:self.view];
    
}

- (void)updateExtraInformationWithID:(NSString *)ID {
    [[ZDIWebPageManager sharedManager] fetchExtraInformationWithID:ID succeed:^(ZDIWebPageExtraInformationModel *extraInformationModel) {
        self.webPageExtraInformationModel = extraInformationModel;
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updatePresentCommit {
    [[ZDICommitPageManager sharedManager] fetchShortCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            ZDICommitPageViewController *commitPageViewController = [[ZDICommitPageViewController alloc] init];
            commitPageViewController.IDStr = self.IDStr;
            [self.navigationController pushViewController:commitPageViewController animated:YES];
            commitPageViewController.longCommits = self.webPageExtraInformationModel.longComments;
            commitPageViewController.shortCommits = self.webPageExtraInformationModel.shortComments;
            commitPageViewController.allCommits = self.webPageExtraInformationModel.comments;
        });
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CGFloat height = scrollView.contentSize.height;
    CGFloat skipStandard = height - kDeviceHeight + 20;
    CGFloat skipHeight = y + kDeviceHeight - height;

    if (skipHeight + skipStandard == 0 && skipHeight != 0 && y == -20) {
        _skipFlag = YES;
    }
    
    if (_skipFlag) {
        if (y < -70 && y!= -116) {
            if (_nowArrIndex == 0 && _nowDayIndex == 0) {
                
            } else {
                [self getLastID];
                [self updateWKWebViewWithIDStr:_IDStr];
                _skipFlag = NO;
            }
        }
    }
    if (_skipFlag) {
        if (skipHeight > 70 && y != -20) {
            [self getNextID];
            [self updateWKWebViewWithIDStr:_IDStr];
            _skipFlag = NO;
        }
    }
    
}

- (void)updateWKWebViewWithIDStr:(NSString *)ID {
    [self.webPageView reloadWKWebViewWithID:ID];
    
    [self updateExtraInformationWithID:ID];
    
}

- (void)getLastID {
    if (_nowDayIndex > 0) {
        _nowDayIndex--;
    } else {
        _nowArrIndex--;
        ZDIDailyDataModel *tempDailyDataModel = _everyDailyDateModelMut[_nowArrIndex];
        _textNumber = tempDailyDataModel.stories.count;
        _nowDayIndex = _textNumber - 1;
        _IDStr = [tempDailyDataModel.stories[_nowDayIndex] id];
        return;
    }
    ZDIDailyDataModel *tempDailyDataModel = _everyDailyDateModelMut[_nowArrIndex];
    _IDStr = [tempDailyDataModel.stories[_nowDayIndex] id];
    _textNumber = tempDailyDataModel.stories.count;
}

- (void)getNextID {
    if ((_nowDayIndex == _textNumber - 1 && _nowArrIndex == _everyDailyDateModelMut.count - 2) || (_nowArrIndex > _everyDailyDateModelMut.count - 2)) {
        [self updateSomeDailyWithDate:[ZDIWebPageViewController getSomeDayFromTodayWithNextDay:self.days]];
    }
    if (_nowDayIndex < _textNumber - 1) {
        _nowDayIndex++;
    } else {
        _nowArrIndex++;
        _nowDayIndex = 0;
    };
    ZDIDailyDataModel *tempDailyDataModel = _everyDailyDateModelMut[_nowArrIndex];
    _IDStr = [tempDailyDataModel.stories[_nowDayIndex] id];
    _textNumber = tempDailyDataModel.stories.count;
}

- (void)updateSomeDailyWithDate:(NSString *)date {
    [[ZDIHomePageManager sharedManager] fetchLatestDailyDataWithDate:date succeed:^(ZDIDailyDataModel *someDailyDateModel) {
        [self.everyDailyDateModelMut addObject:someDailyDateModel];
        self.days++;
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
