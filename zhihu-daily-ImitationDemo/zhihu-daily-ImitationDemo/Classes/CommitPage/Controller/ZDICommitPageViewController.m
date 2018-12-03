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

@interface ZDICommitPageViewController () <UITableViewDelegate, ZDICommitPageViewDelegate>

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
    
    _hiddenStandard = [ZDICommitPageTableViewCell getHiddenCellHeight:@"\nqstsd"];
    
    self.cellLongCommitHeightArray = [NSMutableArray array];
    self.cellShortCommitHeightArray = [NSMutableArray array];
    
    self.cellHiddenLongCommitHeightArray = [NSMutableArray array];
    self.cellHiddenShortCommitHeightArray = [NSMutableArray array];
    
    self.cellFinalLongCommitHeightArray = [NSMutableArray array];
    self.cellFinalShortCommitHeightArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.hidden = NO;
    NSString *navTitleStr = [NSString stringWithFormat:@"%d条点评", _allCommits];
    self.navigationItem.title = navTitleStr;
    
    _navChangeBackImage = [ZDICommitPageViewController createImageWithColor:[UIColor colorWithRed:0.24f green:0.78f blue:0.99f alpha:1.00f] andAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:_navChangeBackImage forBarMetrics:UIBarMetricsDefault];
    
    self.commitPageView = [[ZDICommitPageView alloc] initWithFrame:CGRectMake(0, 0, kExamplePictureWidth, kExamplePictureWidth)andLongCommits:_longCommits andShortCommits:_shortCommits];
    [self.view addSubview:_commitPageView];
    
    self.commitPageView.commitPageViewDelegate = self;
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
        return [_cellFinalLongCommitHeightArray[indexPath.row] floatValue];
    } else {
        return [_cellFinalShortCommitHeightArray[indexPath.row] floatValue];
    }
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
            NSString *tempStr = [NSString stringWithFormat:@"%@\n\n//%@:%@", [_shortCommitPageModel.comments[i] contentCommitStr],[replyToModel author],[replyToModel contentReplyToStr]];
            CGFloat height = [ZDICommitPageTableViewCell getCellHeight:tempStr];
            NSNumber *totalNumber = [NSNumber numberWithFloat:height];
            [_cellShortCommitHeightArray addObject:totalNumber];
            
            NSString *hiddenTempStr = [NSString stringWithFormat:@"//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
            CGFloat hiddenHeight = [ZDICommitPageTableViewCell getHiddenCellHeight:hiddenTempStr];
            CGFloat shouldHiddenHeight = hiddenHeight - _hiddenStandard;
            if (hiddenHeight > _hiddenStandard) {
                NSNumber *hiddenNumber = [NSNumber numberWithFloat:shouldHiddenHeight];
                [_cellHiddenShortCommitHeightArray addObject:hiddenNumber];
                
                CGFloat finalHeight = height - shouldHiddenHeight;
                NSNumber *finalNumber = [NSNumber numberWithFloat:finalHeight];
                [_cellFinalShortCommitHeightArray addObject:finalNumber];
            } else {
                NSNumber *hiddenNumber = [NSNumber numberWithFloat:0];
                [_cellHiddenShortCommitHeightArray addObject:hiddenNumber];
                
                [_cellFinalShortCommitHeightArray addObject:totalNumber];
            }
        } else {
            CGFloat height = [ZDICommitPageTableViewCell getCellHeight:[_shortCommitPageModel.comments[i] contentCommitStr]];
            NSNumber *commentHeight = [NSNumber numberWithFloat:height];
            [_cellShortCommitHeightArray addObject:commentHeight];
            
            [_cellFinalShortCommitHeightArray addObject:commentHeight];
            
            NSNumber *hiddenNumber = [NSNumber numberWithFloat:0];
            [_cellHiddenShortCommitHeightArray addObject:hiddenNumber];
        }
       
    }
    
}

- (void)calculateLongCommitsHeight {
    NSInteger longCommitCount = _longCommitPageModel.comments.count;
    for (NSInteger i = 0; i < longCommitCount; i++) {
        ZDIReplyToModel *replyToModel = [_longCommitPageModel.comments[i] replyTo];
        if (replyToModel) {
            NSString *tempStr = [NSString stringWithFormat:@"%@\n\n//%@:%@", [_longCommitPageModel.comments[i] contentCommitStr],[replyToModel author],[replyToModel contentReplyToStr]];

            CGFloat height = [ZDICommitPageTableViewCell getCellHeight:tempStr];
            NSNumber *totalNumber = [NSNumber numberWithFloat:height];
            [_cellLongCommitHeightArray addObject:totalNumber];
            
            NSString *hiddenTempStr = [NSString stringWithFormat:@"//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
            CGFloat hiddenHeight = [ZDICommitPageTableViewCell getHiddenCellHeight:hiddenTempStr];
            CGFloat shouldHiddenHeight = hiddenHeight - _hiddenStandard;
            if (hiddenHeight > _hiddenStandard) {
                NSNumber *hiddenNumber = [NSNumber numberWithFloat:shouldHiddenHeight];
                [_cellHiddenLongCommitHeightArray addObject:hiddenNumber];
                
                CGFloat finalHeight = height - shouldHiddenHeight;
                NSNumber *finalNumber = [NSNumber numberWithFloat:finalHeight];
                [_cellFinalLongCommitHeightArray addObject:finalNumber];
            } else {
                NSNumber *hiddenNumber = [NSNumber numberWithFloat:0];
                [_cellHiddenLongCommitHeightArray addObject:hiddenNumber];
                
                [_cellFinalLongCommitHeightArray addObject:totalNumber];
            }
        } else {
            CGFloat height = [ZDICommitPageTableViewCell getCellHeight:[_longCommitPageModel.comments[i] contentCommitStr]];
            NSNumber *commentHeight = [NSNumber numberWithFloat:height];
            [_cellLongCommitHeightArray addObject:commentHeight];
            
            [_cellFinalLongCommitHeightArray addObject:commentHeight];
            
            NSNumber *hiddenNumber = [NSNumber numberWithFloat:0];
            [_cellHiddenLongCommitHeightArray addObject:hiddenNumber];
        }
        
    }
}

- (void)unfoldLongWithButtonInCell:(UIButton *)button {
    ZDICommitPageTableViewCell *longCommitCell = (ZDICommitPageTableViewCell *)[[button superview] superview];
    NSIndexPath *indexPath = [_commitPageView.tableView indexPathForCell:longCommitCell];
    
}

- (void)unfoldShortWithButtonInCell:(UIButton *)button{
    
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
