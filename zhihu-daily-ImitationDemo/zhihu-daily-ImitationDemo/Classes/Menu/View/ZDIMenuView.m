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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 240 / kExamplePictureWidth * kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[ZDIMenuTableViewCell class] forCellReuseIdentifier:columnCellIdentifier];
    
    self.tableView.dataSource = self;
    [self addSubview:_tableView];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    self.tableView.separatorStyle = UIAccessibilityTraitNone;
    self.backgroundColor = [UIColor colorWithRed:0.14f green:0.16f blue:0.19f alpha:1.00f];
    
    _menuTableHeadView = [[ZDIMenuTableHeadView alloc] initWithFrame:CGRectMake(0, 0, 240 / kExamplePictureWidth * kDeviceWidth, 135 / kExamplePictureHeight * kDeviceHeight)];
    self.tableView.tableHeaderView = _menuTableHeadView;
    
    _menuTableFootView = [[ZDIMenuTableFootView alloc] initWithFrame:CGRectMake(0, 734 / kExamplePictureHeight * kDeviceHeight, 240 / kExamplePictureWidth * kDeviceWidth, 50 / kExamplePictureHeight * kDeviceHeight)];
    [self addSubview:_menuTableFootView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //test
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //test
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDIMenuTableViewCell *menuTableViewCell = [tableView dequeueReusableCellWithIdentifier:columnCellIdentifier forIndexPath:indexPath];
    menuTableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return menuTableViewCell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
