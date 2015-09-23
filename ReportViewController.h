//
//  ReportViewController.h
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 15..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UITableViewController{
    IBOutlet UITableView *mainTableView;
    
    NSArray *report;
    NSMutableData *data;
}

@end