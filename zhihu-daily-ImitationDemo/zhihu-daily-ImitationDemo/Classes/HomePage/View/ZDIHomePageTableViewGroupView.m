//
//  ZDIHomePageTableViewGroupView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/23.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageTableViewGroupView.h"
#import "ZDIHomePageNormalTableViewCell.h"
#import "ZDIHomePageLatestTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kExamplePictureWidth 440.0
#define kExamplePictureHeight 784.0
static NSString *latestCellIdentifier = @"latestDailyCell";
static NSString *someCellIdentifier = @"someDailyCell";

@interface ZDIHomePageTableViewGroupView()<UITableViewDataSource>

@end

@implementation ZDIHomePageTableViewGroupView

- (instancetype) init {
    self = [super init];
    if (self) {
        _everyDailyDateModelMut = [[NSMutableArray alloc] init];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) style:UITableViewStylePlain];
        [_tableView registerClass:[ZDIHomePageLatestTableViewCell class] forCellReuseIdentifier:latestCellIdentifier];
        [_tableView registerClass:[ZDIHomePageNormalTableViewCell class] forCellReuseIdentifier:someCellIdentifier];
        
        self.tableView.dataSource = self;
        [self addSubview:_tableView];
        
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.bounces = NO;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _carousel = [[ZDIHomePageCarouselView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230 / kExamplePictureHeight * kDeviceHeight)];
        _carousel.currentPageColor = [UIColor orangeColor];
        _carousel.pageColor = [UIColor grayColor];
        _tableView.tableHeaderView = _carousel;
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _everyDailyDateModelMut.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _latestDailyDataModel.stories.count;
    } else {
        return [_everyDailyDateModelMut[section - 1] stories].count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZDIHomePageLatestTableViewCell *homePageLatestTableViewCell = [tableView dequeueReusableCellWithIdentifier:latestCellIdentifier forIndexPath:indexPath];
        homePageLatestTableViewCell.titleLabel.text = [_latestDailyDataModel.stories[indexPath.row] title];
        NSArray *titleImageArr = [_latestDailyDataModel.stories[indexPath.row] images];
        NSString *titleImageStr = titleImageArr[0];
        [homePageLatestTableViewCell.titleImageView sd_setImageWithURL:[NSURL URLWithString:titleImageStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        return homePageLatestTableViewCell;
    } else {
        ZDIDailyDataModel *someDailyDataModel = _everyDailyDateModelMut[indexPath.section - 1];
        ZDIHomePageNormalTableViewCell *homePageNormalTableViewCell = [tableView dequeueReusableCellWithIdentifier:someCellIdentifier forIndexPath:indexPath];
        homePageNormalTableViewCell.titleLabel.text = [someDailyDataModel.stories[indexPath.row] title];
        NSArray *titleImageArr = [someDailyDataModel.stories[indexPath.row] images];
        NSString *titleImageStr = titleImageArr[0];
        [homePageNormalTableViewCell.titleImageView sd_setImageWithURL:[NSURL URLWithString:titleImageStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        return homePageNormalTableViewCell;
    }

}

// 根据url获取图片
- (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

- (void)setScrollViewImage:(NSArray *)images andTitles:(NSArray *)titles andID:(NSArray *)ID{
    [_carousel setImages:images andTitles:titles andID:ID];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
