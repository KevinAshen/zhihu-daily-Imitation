//
//  ZDIWebPageBounceView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZDIWebPageBounceCollectView;

NS_ASSUME_NONNULL_BEGIN

@protocol ZDIWebPageBounceViewDelegate <NSObject>

- (void)changeCollectFlagWithFlag:(BOOL)flag;

@end


@interface ZDIWebPageBounceView : UIView

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view WithFlag:(BOOL)flag;

@property (nonatomic, weak) id<ZDIWebPageBounceViewDelegate> webPageBounceViewDelegate;

@end

NS_ASSUME_NONNULL_END
