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
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
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

- (void) setupWKWebViewWithID:(NSString *)ID{
    
    _skipFlag = NO;
    
    _webPageView = [[ZDIWebPageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) AndIDStr:ID];
    [self.view addSubview:_webPageView];
    
    _webPageView.webView.scrollView.delegate = self;
    
    _webPageBottomView = [[ZDIWebPageBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - (50 / kExamplePictureHeight * kExamplePictureHeight), kDeviceWidth, 50 / kExamplePictureHeight * kExamplePictureHeight)];
    [self.view addSubview:_webPageBottomView];
    
    [_webPageBottomView.returnButton addTarget:self action:@selector(touchReturn) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.commitButton addTarget:self action:@selector(touchCommit) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.nextButton addTarget:self action:@selector(touchNext) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchCommit {
    [self updateShortCommit];
}

- (void)touchNext {
    [_webPageView.webView.scrollView setContentOffset:CGPointMake(0, _webPageView.webView.scrollView.contentSize.height) animated:YES];
}

- (void)updateExtraInformationWithID:(NSString *)ID {
    [[ZDIWebPageManager sharedManager] fetchExtraInformationWithID:ID succeed:^(ZDIWebPageExtraInformationModel *extraInformationModel) {
        self.webPageExtraInformationModel = extraInformationModel;
        NSLog(@"--test---%@--", extraInformationModel);
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updateShortCommit {
    [[ZDICommitPageManager sharedManager] fetchShortCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            ZDICommitPageViewController *commitPageViewController = [[ZDICommitPageViewController alloc] init];
            commitPageViewController.commitPageView.shortCommitPageModel = [[ZDICommitPageModel alloc] init];
            commitPageViewController.shortCommitPageModel = commitPageModel;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y + kDeviceHeight;
    CGFloat height = scrollView.contentSize.height;
    CGFloat skipStandard = height - kDeviceHeight + 20;
    CGFloat skipHeight = y - height;
    
    if (skipHeight == skipStandard) {
        _skipFlag = YES;
    }
    
    if (_skipFlag) {
        if (skipHeight > 70) {
            [self updateWKWebViewWithIDStr:@"9703265"];
            _skipFlag = NO;
        }
    }
}

- (void)updateWKWebViewWithIDStr:(NSString *)ID {
    [_webPageView removeFromSuperview];
    
    [self setupWKWebViewWithID:ID];
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
