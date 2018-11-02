//
//  ZDIHomePageTableViewGroupView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageTableViewGroupView.h"
#import "ZDIHomePageNormalTableViewCell.h"
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
static NSString *titleCellIdentifier = @"titleCell";
static NSString *normalCellIdentifier = @"normalCell";

@interface ZDIHomePageTableViewGroupView()<UITableViewDataSource>

@end

@implementation ZDIHomePageTableViewGroupView

- (instancetype) init {
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
        [_tableView registerClass:[ZDIHomePageNormalTableViewCell class] forCellReuseIdentifier:normalCellIdentifier];
        
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //test
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //test
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDIHomePageNormalTableViewCell *homePageNormalTableViewCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier forIndexPath:indexPath];
    return homePageNormalTableViewCell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
