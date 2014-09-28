//
//  FileWidgetViewController.h
//  YKFileWidgetDemo
//
//  Created by george on 9/27/14.
//  Copyright (c) 2014 Gokuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"

#define PROTOCOL @"ykwidget:"
#define REDIRECT_PATH @"select_file"

@interface FileWidgetViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end
