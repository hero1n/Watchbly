//
//  MasterViewController.m
//  Master
//
//  Created by Jaewon on 2014. 8. 4..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//




#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *pubDate;
    NSString *element;
}

@end

@implementation MasterViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize imageArray;


int maxCount = 0;
int const maxRange = 4;
int randCount = 4;
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /*
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"victory_stand.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
     */
    
    
    imageArray = [[NSArray alloc] initWithObjects:@"page_1.jpg", @"page_2.jpg", @"page_3.jpg", nil];
    
    for (int i = 0; i < [imageArray count]; i++) {
        //We'll create an imageView object in every 'page' of our scrollView.
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], scrollView.frame.size.height);
    
    NSString *URList;
    feeds = [[NSMutableArray alloc] init];
    
    int num[randCount];
    for(int i = 0 ; i < randCount ; i++){
        num[i] = i;
    }
    
    //섞는거
    for(int i = 0 ; i < 20 ; i++){
        int temp;
        int dest = arc4random() % randCount; // 시작
        int src = arc4random() % randCount; // 끝
        if(dest == src){
            continue;
        }else{
            temp = num[dest];
            num[dest] = num[src];
            num[src] = temp;
        }
    }
    
    
    for(int i = 0 ; i < randCount ; i++){
        switch(num[i]){
            case 0 : URList = @"http://rss.donga.com/politics.xml"; break;
            case 1 : URList = @"http://www.hani.co.kr/rss/politics/"; break;
            case 2 : URList = @"http://rss.ohmynews.com/rss/politics.xml"; break;
            case 3 : URList = @"http://rss.hankyung.com/new/news_politics.xml"; break;
        }
        
        NSURL *url = [NSURL URLWithString:URList];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        [parser parse];
    }
    
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellStyleSubtitle;
    
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    cell.detailTextLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"] && maxCount < maxRange) {
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        pubDate    = [[NSMutableString alloc] init];
        maxCount++;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"pubDate"]){
        [pubDate appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
        
    if ([elementName isEqualToString:@"item"] && maxCount < maxRange) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    maxCount = 0;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        
}

@end
