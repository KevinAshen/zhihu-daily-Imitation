//
//  ZDIHomePageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageViewController.h"
#import "ZDIHomePageCarouselView.h"
#import <Masonry.h>

@interface ZDIHomePageViewController ()<ZDIHomePageCarouselViewDelegate>

@end

@implementation ZDIHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZDIHomePageCarouselView *carousel = [[ZDIHomePageCarouselView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 230)];
    //    carousel.scrollDorectionPortrait = YES;
    carousel.images = @[
                        [UIImage imageNamed:@"0.JPG"],
                        [UIImage imageNamed:@"1.JPG"],
                        [UIImage imageNamed:@"2.JPG"],
                        [UIImage imageNamed:@"3.JPG"],
                        [UIImage imageNamed:@"4.JPG"]
                        ];
    //NSLog(@"-@-*--%ld--*-@-", carousel.pageControl.numberOfPages);
    carousel.currentPageColor = [UIColor orangeColor];
    carousel.pageColor = [UIColor grayColor];
    
    
    self.navigationItem.title = @"今日热闻";
    
    _homePageTableViewGroupView = [[ZDIHomePageTableViewGroupView alloc] init];
    [self.view addSubview:_homePageTableViewGroupView];
    
    _homePageTableViewGroupView.tableView.tableHeaderView = carousel;
    
    [_homePageTableViewGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
    }];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsCompact];
//    CGRect frame = self.navigationController.navigationBar.frame;
//    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, frame.size.width, frame.size.height+20)];
//    alphaView.backgroundColor = [UIColor colorWithRed:0.02f green:0.56f blue:0.84f alpha:1.00f];
//    alphaView.userInteractionEnabled = NO;
//    [self.navigationController.navigationBar insertSubview: alphaView atIndex:0];
}

- (void)carouselView:(ZDIHomePageCarouselView *)homePageCarouselView indexOfClickedImageBtn:(NSUInteger )index {
    NSLog(@"点击了第%ld张图片",index);
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
