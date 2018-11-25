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

@interface ZDICommitPageViewController () <UITableViewDelegate>

@end

@implementation ZDICommitPageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLongCommit];
    [self updateShortCommit];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tapFlag = 0;
    if (_longCommits == 0) {
        _flag = 0;
    } else {
        _flag = 1;
    }
    
    self.cellLongCommitHeightArray = [NSMutableArray array];
    self.cellShortCommitHeightArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.hidden = NO;
    NSString *navTitleStr = [NSString stringWithFormat:@"%d条点评", _allCommits];
    self.navigationItem.title = navTitleStr;
    
    _navChangeBackImage = [ZDICommitPageViewController createImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f] andAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:_navChangeBackImage forBarMetrics:UIBarMetricsDefault];
    
    self.commitPageView = [[ZDICommitPageView alloc] initWithFrame:CGRectMake(0, 0, kExamplePictureWidth, kExamplePictureWidth)andLongCommits:_longCommits andShortCommits:_shortCommits];
    [self.view addSubview:_commitPageView];
    
    self.commitPageView.tableView.delegate = self;
    
}

- (void)updateLongCommit {
    [[ZDICommitPageManager sharedManager] fetchLongCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.longCommitPageModel = commitPageModel;
        self.commitPageView.longCommitPageModel = commitPageModel;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self calculateLongCommitsHeight];
            [self.commitPageView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (void)updateShortCommit {
    [[ZDICommitPageManager sharedManager] fetchShortCommitWithID:_IDStr succeed:^(ZDICommitPageModel *commitPageModel) {
        self.shortCommitPageModel = commitPageModel;
        self.commitPageView.shortCommitPageModel = commitPageModel;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self calculateShortCommitsHeight];
            [self.commitPageView.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"添加失败");
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section + _flag == 1) {
        return [_cellLongCommitHeightArray[indexPath.row] floatValue];
    }
    return [_cellShortCommitHeightArray[indexPath.row] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _commitPageSectionView = [[ZDICommitPageSectionView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
    if (section + _flag != 1) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        _tap.numberOfTapsRequired = 1;
        [_commitPageSectionView addGestureRecognizer:_tap];
    }
    _commitPageSectionView.commitNumberLabel.text = @"QSTSD";
    return _commitPageSectionView;
}

- (void)tapAction {
    NSLog(@"--%d-test--tap", _tapFlag);
    if (_tapFlag == 1) {
        _tapFlag = 0;
        self.commitPageView.tapFlag = 1;
        [self.commitPageView.tableView reloadData];
    } else {
        _tapFlag = 1;
        self.commitPageView.tapFlag = 0;
        [self.commitPageView.tableView reloadData];
    }
}


- (void)calculateShortCommitsHeight {
    NSInteger shortCommitCount = _shortCommitPageModel.comments.count;
    for (NSInteger i = 0; i < shortCommitCount; i++) {
        ZDIReplyToModel *replyToModel = [_shortCommitPageModel.comments[i] replyTo];
        if (replyToModel) {
            NSString *tempStr = [NSString stringWithFormat:@"%@\n//%@:%@", [_shortCommitPageModel.comments[i] contentCommitStr],[replyToModel author],[replyToModel contentReplyToStr]];
            CGFloat height = [ZDICommitPageTableViewCell cellComment:tempStr size:CGSizeMake(self.view.frame.size.width, 0)];
            NSNumber *totalNumber = [NSNumber numberWithFloat:height];
            [_cellShortCommitHeightArray addObject:totalNumber];
        } else {
            CGFloat height = [ZDICommitPageTableViewCell cellComment:[_shortCommitPageModel.comments[i] contentCommitStr] size:CGSizeMake(self.view.frame.size.width, 0)];
            NSNumber *commentHeight = [NSNumber numberWithFloat:height];
            [_cellShortCommitHeightArray addObject:commentHeight];
        }
       
    }
}

- (void)calculateLongCommitsHeight {
    NSInteger longCommitCount = _longCommitPageModel.comments.count;
    for (NSInteger i = 0; i < longCommitCount; i++) {
        ZDIReplyToModel *replyToModel = [_longCommitPageModel.comments[i] replyTo];
        if (replyToModel) {
            NSString *tempStr = [NSString stringWithFormat:@"%@\n//%@:%@", [_longCommitPageModel.comments[i] contentCommitStr],[replyToModel author],[replyToModel contentReplyToStr]];
            CGFloat height = [ZDICommitPageTableViewCell cellComment:tempStr size:CGSizeMake(self.view.frame.size.width, 0)];
            NSNumber *totalNumber = [NSNumber numberWithFloat:height];
            NSLog(@"--%@--test--height--%ld--", totalNumber, i);
            [_cellLongCommitHeightArray addObject:totalNumber];
        } else {
            CGFloat height = [ZDICommitPageTableViewCell cellComment:[_longCommitPageModel.comments[i] contentCommitStr] size:CGSizeMake(self.view.frame.size.width, 0)];
            NSNumber *commentHeight = [NSNumber numberWithFloat:height];
            [_cellLongCommitHeightArray addObject:commentHeight];
        }
        
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
