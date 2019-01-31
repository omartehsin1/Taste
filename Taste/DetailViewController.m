//
//  DetailViewController.m
//  Taste
//
//  Created by David on 2019-01-30.
//  Copyright © 2019 Omar Tehsin. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <WKUIDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* recipeUrl = self.recipeInfo.url;
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *wView = [[WKWebView alloc] initWithFrame:self.webView.frame configuration:theConfiguration];
    wView.navigationDelegate = self;
    NSURL* url = [NSURL URLWithString:recipeUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
   
    
    
   
    
    
}


@end
