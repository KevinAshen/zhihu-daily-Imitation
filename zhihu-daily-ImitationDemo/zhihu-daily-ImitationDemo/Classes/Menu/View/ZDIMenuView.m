//
//  ZDIMenuView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/1.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIMenuView.h"
#import "ZDIMenuTableViewCell.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
static NSString *columnCellIdentifier = @"columnCell";

@interface ZDIMenuView()<UITableViewDataSource>

@end

@implementation ZDIMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self CreateUI];
    }
    return self;
}

- (void)CreateUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[ZDIHomePageNormalTableViewCell class] forCellReuseIdentifier:columnCellIdentifier];
    
    self.tableView.dataSource = self;
    [self addSubview:_tableView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.backgroundColor = [UIColor darkGrayColor];
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240 / kExamplePictureWidth * kDeviceWidth, kDeviceHeight)];
    [self addSubview:testLabel];
    testLabel.backgroundColor = [UIColor yellowColor];
    testLabel.textColor = [UIColor whiteColor];
    testLabel.text = @"TEST";
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
