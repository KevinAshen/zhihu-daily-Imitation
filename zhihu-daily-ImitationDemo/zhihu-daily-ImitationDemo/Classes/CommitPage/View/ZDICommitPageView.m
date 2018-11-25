//
//  ZDICommitPageView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageView.h"
#import "YUCustomHeaderView.h"
#import "ZDICommitPageTableViewCell.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
static NSString *commitCellIdentifier = @"commitCell";

@interface UIView () <YUFoldingTableViewDelegate>

@end

@implementation ZDICommitPageView

- (instancetype)initWithFrame:(CGRect)frame andLongCommits:(int)longCommits andShortCommits:(int)shortCommits
{
    self = [super initWithFrame:frame];
    if (self) {
        _shortCommits = shortCommits;
        _longCommits = longCommits;
        _allCommits = longCommits + shortCommits;
        [self createData];
        [self createUI];
    }
    return self;
}

- (void) createData {
    if (_longCommits == 0) {
        _flag = 0;
    } else {
        _flag = 1;
    }
    
    self.cellLongCommitHeightArray = [NSMutableArray array];
    self.cellShortCommitHeightArray = [NSMutableArray array];
    
    _longCommitPageModel = [[ZDICommitPageModel alloc] init];
    _shortCommitPageModel = [[ZDICommitPageModel alloc] init];
    
    [self calculateHeight];
}

-(void)createUI {
    if (_longCommits == 0) {
        _commitPagePlaceholderView = [[ZDICommitPagePlaceholderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 400 / kExamplePictureHeight * kDeviceHeight)];
        [self addSubview:_commitPagePlaceholderView];
    
        _foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64)];
        [self addSubview:_foldingTableView];
        _foldingTableView.foldingDelegate = self;
        // 可以设置cell默认展开，不设置的话，默认折叠
        //_foldingTableView.foldingState = YUFoldingSectionStateShow;
        
        _foldingTableView.tableHeaderView = _commitPagePlaceholderView;
    } else {
        _foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64)];
        [self addSubview:_foldingTableView];
        _foldingTableView.foldingDelegate = self;
        // 可以设置cell默认展开，不设置的话，默认折叠
        _foldingTableView.foldingState = YUFoldingSectionStateShow;
        
    }
    [_foldingTableView registerClass:[ZDICommitPageTableViewCell class] forCellReuseIdentifier:commitCellIdentifier];

}

- (void)calculateHeight {
    //NSInteger longCommitCount = _longCommitPageModel.comments.count;
    NSInteger shortCommitCount = _shortCommitPageModel.comments.count;
    for (NSInteger i = 0; i < shortCommitCount; i++) {
        CGFloat height = [ZDICommitPageTableViewCell cellComment:[_shortCommitPageModel.comments[i] contentCommitStr] size:CGSizeMake(self.frame.size.width, 0)];
        NSNumber *commentHeight = [NSNumber numberWithFloat:height];
        NSLog(@"--test%f-QST-", height);
        [_cellShortCommitHeightArray addObject:commentHeight];
    }
}


#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 1 + _flag;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return _cellShortCommitHeightArray.count;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellShortCommitHeightArray[indexPath.row] floatValue];
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZDICommitPageTableViewCell *commitPageTableViewCell = [yuTableView dequeueReusableCellWithIdentifier:commitCellIdentifier forIndexPath:indexPath];
    commitPageTableViewCell.contentLabel.text = [_shortCommitPageModel.comments[indexPath.row] contentCommitStr];
    commitPageTableViewCell.authorLabel.text = [_shortCommitPageModel.comments[indexPath.row] author];
    commitPageTableViewCell.timeLabel.text = [_shortCommitPageModel.comments[indexPath.row] time];
    return commitPageTableViewCell;
}

#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）
// 自定义sectionHeaderView
- (UIView *)yuFoldingTableView:(UITableView *)yuTableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    YUCustomHeaderView *headerFooterView = [yuTableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (headerFooterView == nil) {
        headerFooterView = [[YUCustomHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    headerFooterView.contentView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2];
    if (_flag == 1) {
        if (section == 0) {
            headerFooterView.title = [NSString stringWithFormat:@" %d条长评", _longCommits];
        } else {
            headerFooterView.title = [NSString stringWithFormat:@" %d条短评", _shortCommits];
        }
    } else {
        headerFooterView.title = [NSString stringWithFormat:@" %d条短评", _shortCommits];
    }
//    headerFooterView.descriptionText = [NSString stringWithFormat:@"自定义的sectionHeaderView - %ld", section];
    return headerFooterView;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Title %ld",section];
}
// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return YUFoldingSectionHeaderArrowPositionLeft;
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"detailText";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
