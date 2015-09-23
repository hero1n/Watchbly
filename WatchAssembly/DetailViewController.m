//
//  DetailViewController.m
//  Master
//
//  Created by Jaewon on 2014. 8. 4..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//



#import "DetailViewController.h"

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *haystack  = self.url;
    
//    self.url = [self.url substringToIndex:self.url.length - 9];
    
//    int index = [self.url rangeOfString:@"url="].location;
    
    //NSLog(@"location : %d\n",index);
    
//    self.url = [self.url substringFromIndex:index+4];
//    self.url = [self.url substringToIndex:self.url.length - ];
 //   self.url = [@"http://m." stringByAppendingString:self.url];
    NSLog(@"SendText : %s\n",[self.url UTF8String]);
    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    _webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
}


@end
