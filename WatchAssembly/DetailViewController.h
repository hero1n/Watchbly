//
//  DetailViewController.h
//  Master
//
//  Created by Jaewon on 2014. 8. 4..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) NSString *linkToOpen;

@end
