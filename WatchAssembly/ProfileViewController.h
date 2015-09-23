//
//  ViewController.h
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 9..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>

@class GPPSignInButton;

@interface ProfileViewController : UIViewController <GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (retain, nonatomic) IBOutlet UILabel *displayText;
@property (retain, nonatomic) IBOutlet UILabel *nameText;
@property (retain, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UIView *favorite;
@property (strong, nonatomic) IBOutlet UIView *discussion;

@end
