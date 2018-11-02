//
//  ZDIMenuViewController.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIMenuViewController.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0


@interface ZDIMenuViewController ()

@end

@implementation ZDIMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.frame = CGRectMake(-180, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    //test
    _menuView = [[ZDIMenuView alloc] init];
    _menuView.frame = CGRectMake(-240 / kExamplePictureWidth * kDeviceWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:_menuView];
    
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
