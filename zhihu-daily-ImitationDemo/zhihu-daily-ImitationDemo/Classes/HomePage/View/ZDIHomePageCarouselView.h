//
//  ZDIHomePageCarouselView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDIHomePageCarouselButton.h"

NS_ASSUME_NONNULL_BEGIN

@class ZDIHomePageCarouselView;
@protocol ZDIHomePageCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselView:(ZDIHomePageCarouselView *)homePageCarouselView indexOfClickedImageBtn:(NSUInteger)index;
@end


@interface ZDIHomePageCarouselView : UIView

//传入图片数组
@property (nonatomic, copy) NSArray *images;

//传入标题数组
@property (nonatomic, copy) NSArray *topImageTitle;

//传入网页ID数组
@property (nonatomic, copy) NSArray *topIDStr;

//pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;

//是否竖向滚动
@property (nonatomic, assign, getter = isScrollDorectionPortrait)
BOOL scrollDorectionPortrait;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) id<ZDIHomePageCarouselViewDelegate> homePageCarouselViewDelegate;

- (void)setImages:(NSArray *)images andTitles:(NSArray *)titles andID:(NSArray *)ID;

@end

NS_ASSUME_NONNULL_END
