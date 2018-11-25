//
//  ZDICommitPageViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageViewController.h"
#import "ZDICommitPageManager.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0

@interface ZDICommitPageViewController () 

@end

@implementation ZDICommitPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLongCommit];
    self.commitPageView.shortCommitPageModel = self.shortCommitPageModel;
    [self.commitPageView calculateHeight];
    //[self updateShortCommit];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = NO;
    NSString *navTitleStr = [NSString stringWithFormat:@"%d条点评", _allCommits];
    self.navigationItem.title = navTitleStr;
    
    _navChangeBackImage = [ZDICommitPageViewController createImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f] andAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:_navChangeBackImage forBarMetrics:UIBarMetricsDefault];
    
    self.commitPageView = [[ZDICommitPageView alloc] initWithFrame:CGRectMake(0, 0, kExamplePictureWidth, kExamplePictureWidth)andLongCommits:_longCommits andShortCommits:_shortCommits];
    [self.view addSubview:_commitPageView];
    
}

- (void)updateLongCommit {
    [[ZDICommitPageManager sharedManager] fetchLongCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.commitPageView.longCommitPageModel = commitPageModel;
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updateShortCommit {
    [[ZDICommitPageManager sharedManager] fetchShortCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.commitPageView.shortCommitPageModel = commitPageModel;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.commitPageView calculateHeight];
        });
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
