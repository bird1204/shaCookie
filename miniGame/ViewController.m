//
//  ViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/27.
//
//

#import "ViewController.h"
#import "JsonViewController.h"
#import <unistd.h>

@interface ViewController ()

@end

@implementation ViewController
#pragma mark -
#pragma mark Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // UIView *content = [[self.view subviews] objectAtIndex:0];
	//((UIScrollView *)self.view).contentSize = content.bounds.size;
    
    motionManager = [[CMMotionManager alloc] init];
    if (motionManager.gyroAvailable) {
        
        motionManager.gyroUpdateInterval = 1.0/60.0;
        /*[motionManager
         startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical
         toQueue:[NSOperationQueue currentQueue]
         withHandler: ^(CMDeviceMotion *motion, NSError *error) {
         
         CMAttitude *attitude = motion.attitude;
         NSLog(@"%f %f %f", attitude.roll, attitude.pitch, attitude.yaw);
         
         }];*/
        
        //下面就是block
        [motionManager
         startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler: ^(CMDeviceMotion *motion, NSError *error) {
             
             CMAttitude *attitude = motion.attitude;
             //NSLog(@"%f %f %f", attitude.roll, attitude.pitch, attitude.yaw);
             [self movePicWithRollX:attitude.roll withPitchY:attitude.pitch withYawX:attitude.yaw];
         }];
        
    } else {
        NSLog(@"No gyroscope on device.");
    }
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    UIImage *image = [UIImage imageNamed:@"564.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navBar setBackgroundImage:image];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // No autoroation support when adding the HUD to a window!
    // In that case you need to explicitly transform the HUD if you need a rotated version (i.g.,
    // self.transform = CGAffineTransformMakeRotation(PI / 2); )
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	UIView *content = [[self.view subviews] objectAtIndex:0];
	((UIScrollView *)self.view).contentSize = content.bounds.size;
}



-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)movePicWithRollX:(double)roll withPitchY:(double)pitch withYawX:(double)yaw{
    CGRect imageOriginFrame=self.image_star.frame;
    imageOriginFrame.origin.x+=roll;
    imageOriginFrame.origin.y+=pitch;
    [UIView beginAnimations:@"MoveImage" context:nil];
    self.image_star.frame=imageOriginFrame;
    [UIView commitAnimations];

    if(CGRectContainsPoint(self.image_hole.frame,self.image_star.center))
    {
     
        JsonViewController *testView=[[JsonViewController alloc]initWithNibName:@"JsonViewController" bundle:nil];
        [self presentViewController:testView animated:YES completion:nil];
        /*
        // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
        // Add HUD to screen
        [self.navigationController.view addSubview:HUD];
        
        // Regisete for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = self;
        
        HUD.labelText = @"Loading";
        
        // Show the HUD while the provided method executes in a new thread
        [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
  */      
    }
    
}

-(void)dealloc{
    
    [super dealloc];
}


#pragma mark -
#pragma mark IBActions
- (IBAction)button_Skip:(id)sender {
    /*
    // The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	
    // Add HUD to screen
    [self.navigationController.view addSubview:HUD];
	
    // Regisete for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.labelText = @"Loading";
	
    // Show the HUD while the provided method executes in a new thread
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
   */

}

#pragma mark -
#pragma mark Execution code

- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
    // Labels can be changed during the execution
    //HUD.detailsLabelText = @"Something";
    //sleep(3);
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
}

- (void)myMixedTask {
    // Indeterminate mode
    sleep(2);
    // Switch to determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"Downloading";
    float progress = 0.0f;
    while (progress < 1.0f)
    {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(50000);
    }
    // Back to indeterminate mode
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"Cleaning up";
    sleep(2);
	// The sample image is based on the work by www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	//HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Completed";
	sleep(2);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    
    JsonViewController *jsonView=[[JsonViewController alloc] initWithNibName:@"JsonViewController" bundle:nil];
    [self presentViewController:jsonView animated:YES completion:nil];
   // [HUD release];
}

@end