//
//  LoginViewController.m
//  piranha
//
//  Created by Jeff Grimes on 5/27/13.
//  Copyright (c) 2013 Jeff Grimes. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

@interface LoginViewController()
- (IBAction)performLogin:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation LoginViewController
@synthesize spinner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (IBAction)performLogin:(id)sender {
    [self.spinner startAnimating];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate openSession];
}

- (void)loginFailed {
    [self.spinner stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end