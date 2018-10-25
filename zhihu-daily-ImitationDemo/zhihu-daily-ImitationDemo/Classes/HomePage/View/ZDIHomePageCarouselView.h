//
//  ZDIHomePageCarouselView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class ATCarouselView;
@protocol ATCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselView:(ATCarouselView *)carouselView indexOfClickedImageBtn:(NSUInteger)index;
@end


@interface ZDIHomePageCarouselView : UIView

//传入图片数组
@property (nonatomic, copy) NSArray *images;

//pageControl颜色设置
@property (nonatomic, strong) UIColor *currentPageColor;
@property (nonatomic, strong) UIColor *pageColor;

//是否竖向滚动
@property (nonatomic, assign, getter = isScrollDorectionPortrait)
BOOL scrollDorectionPortrait;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@property (weak, nonatomic) id<ATCarouselViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
