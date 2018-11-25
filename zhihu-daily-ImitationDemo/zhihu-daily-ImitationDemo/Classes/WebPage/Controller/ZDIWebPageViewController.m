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

@interface ZDIWebPageViewController ()

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
    
    _webPageView = [[ZDIWebPageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) AndIDStr:_IDStr];
    [self.view addSubview:_webPageView];
    
    _webPageBottomView = [[ZDIWebPageBottomView alloc] initWithFrame:CGRectMake(0, kDeviceHeight - (50 / kExamplePictureHeight * kExamplePictureHeight), kDeviceWidth, 50 / kExamplePictureHeight * kExamplePictureHeight)];
    [self.view addSubview:_webPageBottomView];
    
    [_webPageBottomView.returnButton addTarget:self action:@selector(touchReturn) forControlEvents:UIControlEventTouchUpInside];
    
    [_webPageBottomView.commitButton addTarget:self action:@selector(touchCommit) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchReturn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchCommit {
    [self updateShortCommit];
//    ZDICommitPageViewController *commitPageViewController = [[ZDICommitPageViewController alloc] init];
//    commitPageViewController.IDStr = _IDStr;
//    [self.navigationController pushViewController:commitPageViewController animated:YES];
//
//    commitPageViewController.longCommits = _webPageExtraInformationModel.longComments;
//    commitPageViewController.shortCommits = _webPageExtraInformationModel.shortComments;
//    commitPageViewController.allCommits = _webPageExtraInformationModel.comments;
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
        //NSLog(@"--test-%@--zzzzzzzzzzz--", commitPageViewController);
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
