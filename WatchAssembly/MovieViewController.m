//
//  MovieViewController.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 15..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

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
    
    UIAlertView *errorView;
    errorView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"영상은 아직 구현중입니다. 이용에 불편을 드려 죄송합니다." delegate:nil  cancelButtonTitle:@"확인" otherButtonTitles:nil];
    
    
    [errorView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
