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
        
        //_latestDailyDataModel = [[ZDIDailyDataModel alloc] init];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
        [_tableView registerClass:[ZDIHomePageNormalTableViewCell class] forCellReuseIdentifier:normalCellIdentifier];
        
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
        
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.bounces = NO;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _carousel = [[ZDIHomePageCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230 / kExamplePictureHeight * kDeviceHeight)];
        _carousel.images = @[
                            [UIImage imageNamed:@"0.JPG"],
                            [UIImage imageNamed:@"1.JPG"],
                            [UIImage imageNamed:@"2.JPG"],
                            [UIImage imageNamed:@"3.JPG"],
                            [UIImage imageNamed:@"4.JPG"]
                            ];
        _carousel.currentPageColor = [UIColor orangeColor];
        _carousel.pageColor = [UIColor grayColor];
        _tableView.tableHeaderView = _carousel;
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //test
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //test
    return _latestDailyDataModel.stories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDIHomePageNormalTableViewCell *homePageNormalTableViewCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier forIndexPath:indexPath];
    homePageNormalTableViewCell.titleLabel.text = [_latestDailyDataModel.stories[indexPath.row] title];
    NSArray *testArr = [_latestDailyDataModel.stories[indexPath.row] images];
    NSString *titleImageStr = testArr[0];
    homePageNormalTableViewCell.titleImageView.image = [self getImageFromURL:titleImageStr];
    return homePageNormalTableViewCell;
}

// 根据url获取图片
- (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
