//
//  UIViewController+EmailViewController.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 10. 23..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "EmailViewController.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

@synthesize View;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [View.layer setBorderWidth:4.0];
    [View.layer setBorderColor:[[UIColor orangeColor]CGColor]];
}
@end

