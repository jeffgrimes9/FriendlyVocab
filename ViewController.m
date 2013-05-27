//
//  ViewController.m
//  piranha
//
//  Created by Jeff Grimes on 5/27/13.
//  Copyright (c) 2013 Jeff Grimes. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfilePicture;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation ViewController

extern NSString *const SCSessionStateChangedNotification;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(sessionStateChanged:)
         name:SCSessionStateChangedNotification
         object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (FBSession.activeSession.isOpen) {
        [self populateUserDetails];
    }
}

- (void)sessionStateChanged:(NSNotification*)notification {
    [self populateUserDetails];
}

- (void)populateUserDetails {
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.userNameLabel.text = user.name;
                 self.userProfilePicture.profileID = user.id;
             }
         }];
    }
}

- (IBAction)logoutButtonPressed:(id)sender {
    [FBSession.activeSession closeAndClearTokenInformation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end