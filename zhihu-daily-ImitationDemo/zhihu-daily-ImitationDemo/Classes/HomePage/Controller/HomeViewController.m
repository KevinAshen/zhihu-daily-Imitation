//
//  HomeViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/22.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "HomeViewController.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _navStr = @"今日热闻";
    
    self.navigationItem.title = @"今日热闻";
    
//    UILabel *testLabel = [[UILabel alloc] init];
//    [self.view addSubview:testLabel];
//
//    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.top.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//    }];
//
//    testLabel.backgroundColor = [UIColor redColor];
    
//    CGRect frame = self.navigationController.navigationBar.frame;
//    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height+20)];
//    alphaView.backgroundColor = [UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f];
//    alphaView.userInteractionEnabled = NO;
//    [self.navigationController.navigationBar insertSubview: alphaView atIndex:0];
    
    
   
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
