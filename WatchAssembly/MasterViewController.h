//
//  MasterViewController.h
//  Master
//
//  Created by Jaewon on 2014. 8. 4..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <NSXMLParserDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageArray;

@end

