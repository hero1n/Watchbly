//
//  MainVC.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 2..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

- (NSIndexPath *)initialIndexPathForLeftMenu
{
    return [NSIndexPath indexPathForRow:1 inSection:0];
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    NSString *identifier;

    switch (indexPath.row) {
        case 0:
            identifier = @"Profile";
            break;
        case 1:
            identifier = @"Main";
            break;
        case 2:
            identifier = @"Report";
            break;
        case 3:
            identifier = @"Discussion";
            break;
        case 4:
            identifier = @"Movie";
            break;

    }
    return identifier;
}
-(void) configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame.origin = (CGPoint){0,0};
    frame.size = (CGSize){20,20};
    
    button.frame = frame;
    [button setImage:[UIImage imageNamed:@"menu_20.png"] forState:UIControlStateNormal];
}

-(CGFloat)leftMenuWidth{
    return 200;
}
-(CGFloat)maxDarknessWhileLeftMenu{
    return 0.5;
}
/*
-(CGFloat)openAnimationDuration{
    return 0.3;
}
-(CGFloat)closeAnimationDuration{
    return 0.7;
}
 */
-(BOOL)deepnessForLeftMenu{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
