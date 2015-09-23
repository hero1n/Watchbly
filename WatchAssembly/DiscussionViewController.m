//
//  DiscussionViewController.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 9. 2..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "DiscussionViewController.h"

@interface DiscussionViewController ()

@end

@implementation DiscussionViewController

@synthesize topicLabel;
@synthesize mySegmentedControl;
@synthesize topicView;
@synthesize mainTableView;
bool bParseFirst = false;
int vote = 1;
NSString *board_index;
UIActivityIndicatorView *indicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //[self.navigationController.navigationBar.layer setBorderWidth:1.0];
    //[self.navigationController.navigationBar.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    
    [topicView.layer setBorderWidth:4.0];
    [topicView.layer setBorderColor:[[UIColor orangeColor]CGColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"작성" style:nil target:self action:@selector(write)];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:mySegmentedControl
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:40];
    [mySegmentedControl addConstraint:constraint];
    [mySegmentedControl.layer setBorderWidth:2.0];
    [mySegmentedControl.layer setBorderColor:[[UIColor orangeColor]CGColor]];
    [mySegmentedControl addTarget:self
                         action:@selector(action)
               forControlEvents:UIControlEventValueChanged];
    
    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:@"http://watchassembly.applepi.kr/selectBoard"]];
    NSLog(@"%@",allCoursesData);
    NSError *error;
    
    NSMutableDictionary *allCourses = [NSJSONSerialization
                                       JSONObjectWithData:allCoursesData
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    NSLog(@"%@",allCourses);
    
    
    NSString *commentURL = @"http://watchassembly.applepi.kr/selectComments.php?idx=";
    board_index = allCourses[@"idx"];
    NSURL *url = [NSURL URLWithString:[commentURL stringByAppendingString:board_index]];
    
    NSLog(@"%@",[NSURL URLWithString:[commentURL stringByAppendingString:board_index]]);
    //NSURL *url = [NSURL URLWithString:@"http://watchassembly.applepi.kr/selectBoard"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    topicLabel.text = allCourses[@"topic"];
    
    [topicLabel setPreferredMaxLayoutWidth:320.0];
    [topicLabel sizeToFit];
}
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

- (void)action{
    NSInteger selectedSegment = mySegmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        vote = 1;
        NSLog(@"Vote : %d",vote);
    }
    else{
        vote = 0;
        NSLog(@"Vote : %d",vote);
    }
}
-(void)write{
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"의견 작성"
                                                     message:@"의견을 작성해주세요."
                                                    delegate:self
                                           cancelButtonTitle:@"취소"
                                           otherButtonTitles:@"쓰기", nil];
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    //dialog.tintColor = [UIColor orangeColor];
    //dialog.backgroundColor = [UIColor orangeColor];
    [dialog.layer setBorderWidth:1.0];
    [dialog.layer setBorderColor:[[UIColor orangeColor]CGColor]];
    //[dialog.layer setBackgroundColor:[[UIColor whiteColor]CGColor]];
    [dialog setTintColor:[UIColor orangeColor]];
    
    UITextField * alertTextField = [dialog textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    switch(vote){
        case 0 : alertTextField.placeholder = @"반대표입니다"; break;
        case 1 : alertTextField.placeholder = @"찬성표입니다"; break;
    }
    [dialog show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        NSLog(@"Clicked %d %s",__LINE__,__PRETTY_FUNCTION__);
        NSLog(@"idx : %@",board_index);
        NSString *user_id = @"노재원";
        NSString *photo = @"https://lh5.googleusercontent.com/-k6l0mhLL_jA/AAAAAAAAAAI/AAAAAAAAAAA/yUgFLCU-6zk/photo.jpg";
        NSString *reply = [[alertView textFieldAtIndex:0]text];
        NSLog(@"reply : %@",reply);
        NSLog(@"vote : %d",vote);
        
        NSString *insertURLString = @"http://watchassembly.applepi.kr/insertComment?";
        NSString *IDString = [NSString stringWithFormat:@"user_id=%@&",user_id];
        NSString *boardString = [NSString stringWithFormat:@"board_idx=%@&",board_index];
        NSString *photoString = [NSString stringWithFormat:@"photo=%@&",photo];
        NSString *replyString = [NSString stringWithFormat:@"reply=%@&",reply];
        NSString *voteString = [NSString stringWithFormat:@"vote=%d",vote];
        NSString *insertURL = [insertURLString stringByAppendingString:IDString];
        insertURL = [[[[insertURL stringByAppendingString:boardString]stringByAppendingString:photoString]stringByAppendingString:replyString]stringByAppendingString:voteString];
        NSLog(@"%@",insertURL);
        
        
        NSURL *myURL = [NSURL URLWithString:insertURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myURL];
        
        
        [mainTableView reloadData];
    }else{
        [mainTableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView;
    errorView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"서버에 문제가 있거나 인터넷에 연결 되어있지 않습니다." delegate:nil  cancelButtonTitle:@"확인" otherButtonTitles:nil];
    
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [indicator stopAnimating];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    comment = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
        [indicator stopAnimating];
    [mainTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [comment count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    //NSLog(@"%@",[[comment objectAtIndex:indexPath.row]objectForKey:@"reply"]);
    
    cell.textLabel.text = [[comment objectAtIndex:indexPath.row]objectForKey:@"reply"];
    
    float resizeWidth = 60.0;
    float resizeHeight = 60.0;
    
    
    NSURL *url = [NSURL URLWithString:[[comment objectAtIndex:indexPath.row ] objectForKey:@"photo"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:imageData scale:0.6f];
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth,resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth,resizeHeight),[img CGImage]);
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    cell.imageView.image = scaledImage;
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    int vote = [[[comment objectAtIndex:indexPath.row]objectForKey:@"vote"] intValue]; // 찬반
    
    if(vote == 1){
        cell.textLabel.textColor = [UIColor blueColor];
    }else{
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
