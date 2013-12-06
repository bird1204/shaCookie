//
//  loginWithFBViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/9/14.
//
//

#import "loginWithFBViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "JsonViewController.h"
#import "GetJsonURLString.h"

@interface loginWithFBViewController ()

@end

@implementation loginWithFBViewController
#pragma mark -
#pragma mark -Template generated code

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login.png"]]
    
    // redraw the image to fit |yourView|'s size
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.f);
    [[UIImage imageNamed:@"login.png"]drawInRect:self.view.bounds];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.label_UserName.alpha=0.0f;
    self.label_UserMail.alpha=0.0f;
    self.label_UserGender.alpha=0.0f;

    
    self.view.backgroundColor=[UIColor colorWithPatternImage:resultImage];
    
    [self initLocationManager];
    [self updateView];
    [self openActiveSessionWithReadPermissionsOfFaceBook];
    
    
        
}



- (void)viewDidAppear:(BOOL)animated {
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    self.buttonLoginLogout = nil;
    self.label_UserGender =nil;
    self.label_UserMail = nil;
    self.label_UserName = nil;
    self.imageView_UserImage = nil;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark -
#pragma mark - locationManager
-(void)initLocationManager{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc=(CLLocation*)[locations lastObject];
    NSInteger userId=1;
    
    NSInteger type=1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    type=2;
	}

    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    CGFloat latitude=loc.coordinate.latitude;
    CGFloat longtitude=loc.coordinate.longitude;
    //userId,type,deviceId,latitude,longtitude
    NSString *urlString = [NSString stringWithFormat:SetJsonURLString_Device,userId,type,deviceId,latitude,longtitude];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    [locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark - FBlogin


-(void)openActiveSessionWithReadPermissionsOfFaceBook{
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [FBSession openActiveSessionWithReadPermissions:@[@"basic_info", @"email",@"user_about_me",@"user_birthday",@"user_likes",@"user_friends"]
                                               allowLoginUI:YES
                                          completionHandler:^(FBSession *session,
                                                              FBSessionState status,
                                                              NSError *error) {
                                              [self updateView];
                                          }];
        }
    }

}

- (void)updateView {
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [FBRequestConnection startWithGraphPath:@"me" parameters:@{@"fields":@"email,name,gender,picture"} HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection,id result,NSError *error) {
            [self.label_UserName setText:[result objectForKey:@"name"]];
            [self.label_UserMail setText:[result objectForKey:@"email"]];
            [self.label_UserGender setText:[result objectForKey:@"gender"]];
            NSString *profileImageURL = [[[result objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"];
            NSData *profileImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profileImageURL]];
            [self.imageView_UserImage setImage:[UIImage imageWithData:profileImageData]];
        }];
    } else {
        // login-needed account UI is shown whenever the session is closed
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
    }
}


// FBSample logic
// handler for button click, logs sessions in or out
- (IBAction)button_SignUp:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, 0.f);
    [[UIImage imageNamed:@"logout.png"]drawInRect:self.view.bounds];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:resultImage];
    
    self.label_UserName.alpha=1.0f;
    self.label_UserMail.alpha=1.0f;
    self.label_UserGender.alpha=1.0f;

    
    // get the app delegate so that we can access the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    }
}

@end
