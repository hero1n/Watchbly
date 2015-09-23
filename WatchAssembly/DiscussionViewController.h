//
//  DiscussionViewController.h
//  WatchAssembly
//
//  Created by Jaewon on 2014. 9. 2..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussionViewController : UITableViewController{
    
    NSArray *board;
    NSArray *comment;
    NSMutableData *data;
}
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mySegmentedControl;
@property (strong, nonatomic) IBOutlet UIView *topicView;
@property (strong,nonatomic) IBOutlet UITableView *mainTableView;

@end
