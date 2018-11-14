//
//  ZDIHomePageCarouselView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/10/25.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIHomePageCarouselView.h"

static const int imageBtnCount = 3;

@interface ZDIHomePageCarouselView()<UIScrollViewDelegate>

@end

@implementation ZDIHomePageCarouselView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //定义一个scrollView，最主要的轮播控件
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        //横竖两种滚轮都不显示
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        //需要分页
        scrollView.pagingEnabled = YES;
        //不需要回弹（试了一下加不加应该都没什么影响）
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        //在scrollView中添加三个图片按钮，因为后面需要响应点击事件，所以我直接用按钮不用imageView了，感觉更方便一些
        for (int i = 0;i < imageBtnCount; i++) {
            ZDIHomePageCarouselButton *imageBtn = [[ZDIHomePageCarouselButton alloc] init];
            [scrollView addSubview:imageBtn];
        }
        //添加pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
//布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    //设置scrollView的frame
    self.scrollView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    //设置contentSize,不同轮播方向的时候contentSize是不一样的
    if (self.isScrollDorectionPortrait) { //竖向
        //contentSize要放三张图片
        self.scrollView.contentSize = CGSizeMake(width, height * imageBtnCount);
    } else { //横向
        self.scrollView.contentSize = CGSizeMake(width * imageBtnCount, height);
    }
    //设置三张图片的位置，并为三个按钮添加点击事件
    for (int i = 0; i < imageBtnCount; i++) {
        ZDIHomePageCarouselButton *imageBtn = self.scrollView.subviews[i];
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.isScrollDorectionPortrait) { //竖向
            imageBtn.frame = CGRectMake(0, i * height, width, height);
        } else { //横向
            imageBtn.frame = CGRectMake(i * width, 0, width, height);
        }
    }
    //设置contentOffset,显示最中间的图片
    if (self.isScrollDorectionPortrait) { //竖向
        self.scrollView.contentOffset = CGPointMake(0, height);
    } else { //横向
        self.scrollView.contentOffset = CGPointMake(width, 0);
    }
    
    //设置pageControl的位置
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = width - pageW;
    CGFloat pageY = height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
}
//设置pageControl的CurrentPageColor
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}
//设置pageControl的pageColor
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}
//根据传入的图片数组设置图片
- (void)setImages:(NSArray *)images andTitles:(NSArray *)titles {
    _images = images;
    _topImageTitle = titles;
    //pageControl的页数就是图片的个数
    self.pageControl.numberOfPages = images.count;
    //默认一开始显示的是第0页
    self.pageControl.currentPage = 0;
    //设置图片显示内容
    [self setContent];
    //开启定时器
    [self startTimer];
    
}
//设置显示内容
- (void)setContent {
    //设置三个imageBtn的显示图片
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        //取出三个imageBtn
        ZDIHomePageCarouselButton *imageBtn = self.scrollView.subviews[i];
        //这个是为了给图片做索引用的
        NSInteger index = self.pageControl.currentPage;
        //NSLog(@"1--%ld---", index);
        if (i == 0) { //第一个imageBtn，隐藏在当前显示的imageBtn的左侧
            index--; //当前页索引减1就是第一个imageBtn的图片索引
            //NSLog(@"2--%ld---", index);
        } else if (i == 2) { //第三个imageBtn，隐藏在当前显示的imageBtn的右侧
            index++; //当前页索引加1就是第三个imageBtn的图片索引
        }
        //无限循环效果的处理就在这里
        if (index < 0) { //当上面index为0的时候，再向右拖动，左侧图片显示，这时候我们让他显示最后一张图片
            index = self.pageControl.numberOfPages - 1;
            //NSLog(@"4--%ld---", index);
        } else if (index == self.pageControl.numberOfPages) { //当上面的index超过最大page索引的时候，也就是滑到最右再继续滑的时候，让他显示第一张图片
            index = 0;
        }
        imageBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        imageBtn.titleLabel.numberOfLines = 0;
        imageBtn.tag = index;
        //用上面处理好的索引给imageBtn设置图片
        //NSLog(@"$$--%ld---", index);
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateNormal];
        [imageBtn setTitle:_topImageTitle[index] forState:UIControlStateNormal];
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateHighlighted];
        
    }
}
//状态改变之后更新显示内容
- (void)updateContent {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self setContent];
    //唯一跟设置显示内容不同的就是重新设置偏移量，让它永远用中间的按钮显示图片,滑动之后就偷偷的把偏移位置设置回去，这样就实现了永远用中间的按钮显示图片
    //设置偏移量在中间
    if (self.isScrollDorectionPortrait) {
        self.scrollView.contentOffset = CGPointMake(0, height);
    } else {
        self.scrollView.contentOffset = CGPointMake(width, 0);
    }
}

#pragma mark - UIScrollViewDelegate
//拖拽的时候执行哪些操作
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //拖动的时候，哪张图片最靠中间，也就是偏移量最小，就滑到哪页
    //用来设置当前页
    NSInteger page = 0;
    //用来拿最小偏移量
    CGFloat minDistance = MAXFLOAT;
    //遍历三个imageView,看那个图片偏移最小，也就是最靠中间
    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        ZDIHomePageCarouselButton *imageBtn = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.isScrollDorectionPortrait) {
            distance = ABS(imageBtn.frame.origin.y - scrollView.contentOffset.y);
        } else {
            distance = ABS(imageBtn.frame.origin.x - scrollView.contentOffset.x);
        }
        if (distance < minDistance) {
            minDistance = distance;
            page = imageBtn.tag;
        }
    }
    self.pageControl.currentPage = page;
}
//开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
//结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateContent];
}
//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateContent];
}
#pragma mark - 定时器
//开始计时器
- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
//停止计时器
- (void)stopTimer {
    //结束计时
    [self.timer invalidate];
    //计时器被系统强引用，必须手动释放
    self.timer = nil;
}
//通过改变contentOffset * 2换到下一张图片
- (void)nextImage {
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    if (self.isScrollDorectionPortrait) {
        [self.scrollView setContentOffset:CGPointMake(0, 2 * height) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
    }
}


- (void)imageBtnClick:(ZDIHomePageCarouselButton *)btn {
    //    NSLog(@"%ld",btn.tag);
    if ([self.homePageCarouselViewDelegate respondsToSelector:@selector(carouselView:indexOfClickedImageBtn:)])
    {
        //[self.delegate carouselView:self indexOfClickedImageBtn:btn.tag];
        [self.homePageCarouselViewDelegate carouselView:self indexOfClickedImageBtn:btn.tag];
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
