//
//  ReportViewController.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 15..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportDetailViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController



int idx = 1;
UIActivityIndicatorView *indicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    self.navigationController.title = @"성적표";
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"검색" style:nil target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_search.png"] style:nil target:nil action:nil];
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator bringSubviewToFront:self.view];
    [indicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL *url = [NSURL URLWithString:@"http://watchassembly.applepi.kr/selectMembers.php?flag=all"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    [indicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    report = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
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
    return [report count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        
        CGRect frame1=CGRectMake(220,18, 80, 40);
        UILabel *label1=[[UILabel alloc]init];
        label1.frame=frame1;
        label1.text= [[report objectAtIndex:indexPath.row] objectForKey:@"countSum"];
        label1.tag = 1001;
        [cell.contentView addSubview:label1];
        
    }
    
    
    float resizeWidth = 60.0;
    float resizeHeight = 80.0;
    
    
    NSURL *url = [NSURL URLWithString:[[report objectAtIndex:indexPath.row ] objectForKey:@"photo"]];
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
    
    
    
    cell.textLabel.text = [[report objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.detailTextLabel.text = [[report objectAtIndex:indexPath.row] objectForKey:@"party"];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    /*
    UILabel *label1=[cell viewWithTag:1001];
    label1.text=[[report objectAtIndex:indexPath.row] objectForKey:@"countSum"];
    */
    
    /*
    NSUserDefaults *myPrefs = [NSUserDefaults standardUserDefaults];
    [myPrefs setObject:[[report objectAtIndex:indexPath.row]objectForKey:@"idx"] forKey:@"index"];
    [myPrefs synchronize];
    */
    return cell;
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSString *string = [report[indexPath.row] objectForKey: @"idx"];
    
    ReportDetailViewController *detailViewController = [segue destinationViewController];
    detailViewController.Idx = string;
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
