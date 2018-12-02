//
//  ZDICommitPageView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDICommitPageView.h"
#import "ZDICommitPageTableViewCell.h"
#import <UIImageView+WebCache.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
static NSString *commitCellIdentifier = @"commitCell";

@interface ZDICommitPageView ()<UITableViewDataSource>

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
    _tapFlag = 1;
    if (_longCommits == 0) {
        _flag = 0;
    } else {
        _flag = 1;
    }
    
    self.cellLongCommitHeightArray = [NSMutableArray array];
    self.cellShortCommitHeightArray = [NSMutableArray array];
    
    _longCommitPageModel = [[ZDICommitPageModel alloc] init];
    _shortCommitPageModel = [[ZDICommitPageModel alloc] init];
}

-(void)createUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64) style:UITableViewStyleGrouped];
    [self addSubview:_tableView];
    
    self.tableView.dataSource = self;
    
    [_tableView registerClass:[ZDICommitPageTableViewCell class] forCellReuseIdentifier:commitCellIdentifier];
    
    if (_longCommits == 0) {
        _commitPagePlaceholderView = [[ZDICommitPagePlaceholderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 114 / kExamplePictureHeight * kDeviceHeight)];
        _tableView.tableHeaderView = _commitPagePlaceholderView;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section + _flag == 1) {
        ZDICommitPageTableViewCell *commitPageTableViewCell = [tableView dequeueReusableCellWithIdentifier:commitCellIdentifier forIndexPath:indexPath];
        
        ZDIReplyToModel *replyToModel = [_longCommitPageModel.comments[indexPath.row] replyTo];
        if (replyToModel) {
            NSString *replyString = [NSString stringWithFormat:@"\n//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
            commitPageTableViewCell.replyLabel.text = replyString;
        } else {
           commitPageTableViewCell.replyLabel.text = @" ";
        }
        NSString *avatarString = [_longCommitPageModel.comments[indexPath.row] avatar];
        NSMutableString *str = [[NSMutableString alloc]initWithString:avatarString];
        [str insertString:@"s" atIndex:4];
        
        commitPageTableViewCell.contentLabel.text = [_longCommitPageModel.comments[indexPath.row] contentCommitStr];
        
        [commitPageTableViewCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:str]];
        
        commitPageTableViewCell.authorLabel.text = [_longCommitPageModel.comments[indexPath.row] author];
        commitPageTableViewCell.timeLabel.text = [_longCommitPageModel.comments[indexPath.row] time];
        return commitPageTableViewCell;
    }
    ZDICommitPageTableViewCell *commitPageTableViewCell = [tableView dequeueReusableCellWithIdentifier:commitCellIdentifier forIndexPath:indexPath];
    
    ZDIReplyToModel *replyToModel = [_shortCommitPageModel.comments[indexPath.row] replyTo];
    if (replyToModel) {
         NSString *replyString = [NSString stringWithFormat:@"\n//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
        commitPageTableViewCell.replyLabel.text = replyString;
    } else {
        commitPageTableViewCell.replyLabel.text = @" ";
    }
    NSString *avatarString = [_shortCommitPageModel.comments[indexPath.row] avatar];
    NSMutableString *str = [[NSMutableString alloc]initWithString:avatarString];
    [str insertString:@"s" atIndex:4];
    
    commitPageTableViewCell.contentLabel.text = [_shortCommitPageModel.comments[indexPath.row] contentCommitStr];
    
    [commitPageTableViewCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    commitPageTableViewCell.authorLabel.text = [_shortCommitPageModel.comments[indexPath.row] author];
    commitPageTableViewCell.timeLabel.text = [_shortCommitPageModel.comments[indexPath.row] time];
    return commitPageTableViewCell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + _flag;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section + _flag == 1) {
        return _longCommitPageModel.comments.count;
    } else {
        if (_tapFlag == 1) {
            return _shortCommitPageModel.comments.count;
        } else {
            return 0;
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
