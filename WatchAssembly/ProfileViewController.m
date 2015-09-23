//
//  ViewController.m
//  WatchAssembly
//
//  Created by Jaewon on 2014. 8. 9..
//  Copyright (c) 2014년 App:ple Pi. All rights reserved.
//

#import "ProfileViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize signInButton;
@synthesize nameText;
@synthesize profileImage;

GPPSignIn *signIn;
NSString *description;

static NSString * const kClientId = @"699836929078-nq3c3uc4fjmudeltbpijpcgqgbr80f74.apps.googleusercontent.com";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayText.hidden = YES;
    self.nameText.hidden = YES;
    self.profileImage.hidden = YES;
    self.favorite.hidden = YES;
    self.discussion.hidden = YES;
    
    [self.favorite.layer setBorderWidth:2.0];
    [self.discussion.layer setBorderWidth:2.0];
    [self.favorite.layer setBorderColor:[[UIColor orangeColor]CGColor]];
    [self.discussion.layer setBorderColor:[[UIColor orangeColor]CGColor]];
    
    
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    //signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ kGTLAuthScopePlusMe ] ;
    //signIn.scopes = @[@"https://www.googleapis.com/auth/plus.me"];
    //signIn.scopes = @[@"profile"];
    signIn.shouldFetchGoogleUserID = YES;
    
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    [signIn trySilentAuthentication];
}



- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        self.displayText.hidden = NO;
        self.nameText.hidden = NO;
        self.profileImage.hidden = NO;
        self.favorite.hidden = NO;
        self.discussion.hidden = NO;
        
        NSLog(@"Login Success!");
        NSString *userID = signIn.authentication.userID;
        NSString *id = signIn.userID;
        NSLog(@"id : %@",id);
        NSLog(@"userID : %@",userID);
        NSString *userEmail = signIn.authentication.userEmail;
        NSLog(@"userEmail : %@",userEmail);
        
        self.displayText.text = [NSString stringWithFormat:@"%@",userEmail];
        self.nameText.text = [NSString stringWithFormat:@"노재원"];
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}

- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}
- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}
@end
