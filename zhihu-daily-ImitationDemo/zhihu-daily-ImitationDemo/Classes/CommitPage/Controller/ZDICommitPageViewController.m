//
//  ZDICommitPageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageViewController.h"
#import "ZDICommitPageManager.h"

@interface ZDICommitPageViewController ()

@end

@implementation ZDICommitPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLongCommit];
    [self updateShortCommit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commitPageView = [[ZDICommitPageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_commitPageView];
    


}

- (void)updateLongCommit {
    [[ZDICommitPageManager sharedManager] fetchLongCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.commitPageView.longCommitPageModel = [[ZDICommitPageModel alloc] init];
        self.commitPageView.longCommitPageModel = commitPageModel;
        NSLog(@"---%@--self.commitPageView.longCommitPageModel-", self.commitPageView.longCommitPageModel);
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updateShortCommit {
    [[ZDICommitPageManager sharedManager] fetchShortCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.commitPageView.shortCommitPageModel = [[ZDICommitPageModel alloc] init];
        self.commitPageView.shortCommitPageModel = commitPageModel;
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
