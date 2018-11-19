//
//  ZDIWebPageView.h
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/18.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDIWebPageView : UIView

@property (nonatomic, strong) WKWebView *webView;

- (instancetype)initWithFrame:(CGRect)frame AndIDStr:(NSString *)IDStr;

@end
NS_ASSUME_NONNULL_END
