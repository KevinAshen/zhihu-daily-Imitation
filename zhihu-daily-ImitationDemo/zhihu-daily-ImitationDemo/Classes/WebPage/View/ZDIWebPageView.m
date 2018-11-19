//
//  ZDIWebPageView.m
//  zhihu-daily-ImitationDemo
//
//  Created by mac on 2018/11/18.
//  Copyright © 2018 姜凯文. All rights reserved.
//

#import "ZDIWebPageView.h"

@implementation ZDIWebPageView

- (instancetype)initWithFrame:(CGRect)frame AndIDStr:(NSString *)IDStr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUIWithFrame:frame AndIDStr:IDStr];
    }
    return self;
}

- (void)CreateUIWithFrame:(CGRect)frame AndIDStr:(NSString *)IDStr{
    _webView = [[WKWebView alloc] initWithFrame:frame];
    [self addSubview:_webView];
    
    NSString *webViewURLStr = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", IDStr];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webViewURLStr]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
