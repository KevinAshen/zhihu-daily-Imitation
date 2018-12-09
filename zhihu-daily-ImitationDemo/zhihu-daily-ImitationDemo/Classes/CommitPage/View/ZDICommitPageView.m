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
static NSString *shortCommitCellIdentifier = @"shortCommitCell";
static NSString *longCommitCellIdentifier = @"longCommitCell";

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
    
    _longCommitsCellFoldStateArray = [NSMutableArray arrayWithObjects:@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    _shortCommitsCellFoldStateArray = [NSMutableArray arrayWithObjects:@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, nil];
    
    
    _longCommitPageModel = [[ZDICommitPageModel alloc] init];
    _shortCommitPageModel = [[ZDICommitPageModel alloc] init];
}

-(void)createUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 64) style:UITableViewStyleGrouped];
    [self addSubview:_tableView];
    
    self.tableView.dataSource = self;
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    
    [_tableView registerClass:[ZDICommitPageTableViewCell class] forCellReuseIdentifier:longCommitCellIdentifier];
    [_tableView registerClass:[ZDICommitPageTableViewCell class] forCellReuseIdentifier:shortCommitCellIdentifier];
    
    if (_longCommits == 0) {
        _commitPagePlaceholderView = [[ZDICommitPagePlaceholderView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight - 114 / kExamplePictureHeight * kDeviceHeight)];
        _tableView.tableHeaderView = _commitPagePlaceholderView;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section + _flag == 1) {
        ZDICommitPageTableViewCell *longCommitPageTableViewCell = [tableView dequeueReusableCellWithIdentifier:longCommitCellIdentifier forIndexPath:indexPath];
        
        ZDIReplyToModel *replyToModel = [_longCommitPageModel.comments[indexPath.row] replyTo];
        if (replyToModel) {
            NSString *replyString = [NSString stringWithFormat:@"\n//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
            longCommitPageTableViewCell.replyLabel.text = replyString;
            
            longCommitPageTableViewCell.unfoldButton.hidden = [self judgeButtonHiddenWithString:replyString andLineHeight:longCommitPageTableViewCell.replyLabel.font.lineHeight];
        } else {
            longCommitPageTableViewCell.replyLabel.text = @" ";
            longCommitPageTableViewCell.unfoldButton.hidden = YES;
        }
        NSString *avatarString = [_longCommitPageModel.comments[indexPath.row] avatar];
        NSMutableString *str = [[NSMutableString alloc]initWithString:avatarString];
        [str insertString:@"s" atIndex:4];
        
        longCommitPageTableViewCell.contentLabel.text = [_longCommitPageModel.comments[indexPath.row] contentCommitStr];
        
        [longCommitPageTableViewCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:str]];
        longCommitPageTableViewCell.upvoteLabel.text = [_longCommitPageModel.comments[indexPath.row] likes];
        
        longCommitPageTableViewCell.authorLabel.text = [_longCommitPageModel.comments[indexPath.row] author];
        longCommitPageTableViewCell.timeLabel.text = [self getDateStringWithTimeStr:[_longCommitPageModel.comments[indexPath.row] time]];
        
        if ([_longCommitsCellFoldStateArray[indexPath.row] isEqual:@NO]) {
            longCommitPageTableViewCell.replyLabel.numberOfLines = 3;
            [longCommitPageTableViewCell.unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
        } else {
            longCommitPageTableViewCell.replyLabel.numberOfLines = 0;
            [longCommitPageTableViewCell.unfoldButton setTitle:@"收起" forState:UIControlStateNormal];
        }
        
        [longCommitPageTableViewCell.unfoldButton addTarget:self action:@selector(clickLongUnfoldButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return longCommitPageTableViewCell;
    } else {
        ZDICommitPageTableViewCell *shortCommitPageTableViewCell = [tableView dequeueReusableCellWithIdentifier:shortCommitCellIdentifier forIndexPath:indexPath];
        
        ZDIReplyToModel *replyToModel = [_shortCommitPageModel.comments[indexPath.row] replyTo];
        if (replyToModel) {
            NSString *replyString = [NSString stringWithFormat:@"\n//%@:%@", [replyToModel author],[replyToModel contentReplyToStr]];
            shortCommitPageTableViewCell.replyLabel.text = replyString;
            
            shortCommitPageTableViewCell.unfoldButton.hidden = [self judgeButtonHiddenWithString:replyString andLineHeight:shortCommitPageTableViewCell.replyLabel.font.lineHeight];
        } else {
            shortCommitPageTableViewCell.replyLabel.text = @" ";
            shortCommitPageTableViewCell.unfoldButton.hidden = YES;
        }
        NSString *avatarString = [_shortCommitPageModel.comments[indexPath.row] avatar];
        NSMutableString *str = [[NSMutableString alloc]initWithString:avatarString];
        [str insertString:@"s" atIndex:4];
        
        shortCommitPageTableViewCell.upvoteLabel.text = [_shortCommitPageModel.comments[indexPath.row] likes];
        
        shortCommitPageTableViewCell.contentLabel.text = [_shortCommitPageModel.comments[indexPath.row] contentCommitStr];
        
        [shortCommitPageTableViewCell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:str]];
        
        shortCommitPageTableViewCell.authorLabel.text = [_shortCommitPageModel.comments[indexPath.row] author];
        shortCommitPageTableViewCell.timeLabel.text = [self getDateStringWithTimeStr:[_shortCommitPageModel.comments[indexPath.row] time]];
        
        if ([_shortCommitsCellFoldStateArray[indexPath.row] isEqual:@NO]) {
            shortCommitPageTableViewCell.replyLabel.numberOfLines = 3;
            [shortCommitPageTableViewCell.unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
        } else {
            shortCommitPageTableViewCell.replyLabel.numberOfLines = 0;
            [shortCommitPageTableViewCell.unfoldButton setTitle:@"收起" forState:UIControlStateNormal];
        }
        
        [shortCommitPageTableViewCell.unfoldButton addTarget:self action:@selector(clickShortUnfoldButton:) forControlEvents:UIControlEventTouchUpInside];
        
        return shortCommitPageTableViewCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + _flag;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section + _flag == 1) {
        return _longCommitPageModel.comments.count;
    } else {
        if (_tapFlag == 1) {
            return 0;
        } else {
            return _shortCommitPageModel.comments.count;
        }
    }
}

//长评的unfoldButton的点击事件
- (void)clickLongUnfoldButton:(UIButton *)button{
    if ([self.commitPageViewDelegate respondsToSelector:@selector(unfoldLongWithButtonInCell:)]) {
        [_commitPageViewDelegate unfoldLongWithButtonInCell:button];
    }
}
    
//短评的unfoldButton的点击事件
- (void)clickShortUnfoldButton:(UIButton *)button{
    if ([self.commitPageViewDelegate respondsToSelector:@selector(unfoldShortWithButtonInCell:)]) {
        [_commitPageViewDelegate unfoldShortWithButtonInCell:button];
    }
}

- (BOOL)judgeButtonHiddenWithString:(NSString *)replyString andLineHeight:(CGFloat) lineHeight {
    double line = [ZDICommitPageTableViewCell getHiddenCellHeight:replyString] / lineHeight - 0.1;
    if (line >= 3) {
        return NO;
    } else {
        return YES;
    }
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
