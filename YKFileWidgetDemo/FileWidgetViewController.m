//
//  FileWidgetViewController.m
//  YKFileWidgetDemo
//
//  Created by george on 9/27/14.
//  Copyright (c) 2014 Gokuai. All rights reserved.
//

#import "FileWidgetViewController.h"


@implementation FileWidgetViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:frame];
    NSString *requestURL = [[NSString alloc]initWithFormat:@"http://yunku.goukuai.cn/widget/gkc?mode=chooser&link_type=download_link&client_id=ffb1970084cf5f49a76e3ee879786c9b&redirect_uri=%@%@",PROTOCOL,REDIRECT_PATH];
    NSLog(@"------REQUEST URL %@--------",requestURL);
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]]];
    [self.view addSubview:webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"%@",requestString);
    NSString *protocol = PROTOCOL;
    
    if ([requestString hasPrefix:protocol]) {
        NSString *requestContent = [requestString substringFromIndex:[protocol length]];
        NSArray *vals = [requestContent componentsSeparatedByString:@"?"];
       
        if ([vals[0] isEqualToString:REDIRECT_PATH]) {
            NSString *queryStr = vals[1];
            NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
            NSArray *urlComponents = [queryStr componentsSeparatedByString:@"&"];
            for (NSString *keyValuePair in urlComponents)
            {
                NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
                NSString *key = [pairComponents objectAtIndex:0];
                NSString *value = [pairComponents objectAtIndex:1];
                [queryStringDictionary setObject:value forKey:key];
            }
            SBJsonParser * parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *file = [parser objectWithString:[[queryStringDictionary objectForKey:@"file"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"file:%@", [file description]);
        }
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"START");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Finish");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}


@end
