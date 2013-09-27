//
//  procedureStepViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/9/24.
//
//
#import "procedureWithMPFlipViewController.h"
#import "procedureStepViewController.h"
#import <QuartzCore/QuartzCore.h>

#define FRAME_MARGIN 20


@interface procedureStepViewController ()

@end

@implementation procedureStepViewController
@synthesize titleLabel = _titleLabel;
@synthesize contentArea = _contentArea;
@synthesize imageFrame = _imageFrame;
@synthesize imageView = _imageView;
@synthesize descriptionField = _descriptionField;
@synthesize movieIndex = _movieIndex;
@synthesize rotating = _rotating;

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
	//[self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    
    
    if ([self movieIndex] == 3) {
        UIButton *button_Back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button_Back addTarget:self
                        action:@selector(button_back:)
              forControlEvents:UIControlEventTouchDown];
        [button_Back setTitle:@"Back" forState:UIControlStateNormal];
        button_Back.frame = CGRectMake(0.0, 0.0, 50.0, 50.0);
        [self.view addSubview:button_Back];
    }
    
    self.descriptionField.editable = NO;
    
    //NSArray *material=[[self.array_Recipe objectAtIndex:1]objectAtIndex:0];
    
    
    NSString *recipeName=[[self.array_Recipe objectAtIndex:0] objectForKey:@"name"];
    NSArray *procedure=[[self.array_Recipe objectAtIndex:1]objectAtIndex:1];
    //NSString *costingTime=[[procedure objectAtIndex:[self movieIndex]-1]objectForKey:@"costing_time"];
    NSString *step=[[procedure objectAtIndex:[self movieIndex]-1]objectForKey:@"step"];
    
    self.navigationController.title=recipeName;
    self.descriptionField.text=step;
    
    [self.navigationController setTitle:recipeName];

	[self.imageView setImage:[UIImage imageNamed:@"gamebaby"]];
    
    [self.titleLabel setText:recipeName];
    self.descriptionField.text=step;
    
	
    switch ([self movieIndex]) {
		case 1:
			self.titleLabel.text = @"The Matrix (1999)";
			self.descriptionField.text = @"A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.  Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.  Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.";
			break;
			
		case 2:
			self.titleLabel.text = @"The Matrix Reloaded (2003)";
			self.descriptionField.text = @"Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.  Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.";
			break;
			
		case 3:
			self.titleLabel.text = @"The Matrix Revolutions (2003)";
			self.descriptionField.text = @"The human city of Zion defends itself against the massive invasion of the machines as Neo fights to end the war at another front while also opposing the rogue Agent Smith.  Neo and the rebel leaders estimate that they have 72 hours until 250,000 probes discover Zion and destroy it and its inhabitants. During this, Neo must decide how he can save Trinity from a dark fate in his dreams.";
			break;
			
		default:
			break;
	}
	
	[self.imageFrame.layer setShadowOpacity:0.5];
	[self.imageFrame.layer setShadowOffset:CGSizeMake(0, 1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
	[self setTitleLabel:nil];
	[self setImageFrame:nil];
	[self setImageView:nil];
	[self setDescriptionField:nil];
	[self setContentArea:nil];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self setRotating:YES];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self setShadowPathsWithAnimationDuration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	
	[self setRotating:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	NSLog(@"viewDidDisappear");
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	CGRect frame = self.contentArea.frame;
	CGFloat maxPictureWidth = frame.size.width - 2 * FRAME_MARGIN;
	CGFloat	maxPictureHeight = frame.size.height - 2 * FRAME_MARGIN;
	CGFloat fitToWidthHeight = maxPictureWidth * (3./4);
	CGFloat fitToHeightWidth = maxPictureHeight * (4./3);
    
	BOOL fitToWidth = fitToHeightWidth > maxPictureWidth;
	CGFloat contentGap = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone? 10 : 20;
	
	if (fitToWidth)
	{
		if (maxPictureWidth > 480)
		{
			maxPictureWidth = 480;
			fitToWidthHeight = 360;
		}
		
		CGFloat pictureHeightWithFrame = fitToWidthHeight + 2 * FRAME_MARGIN;
		CGFloat pictureWidthWithFrame = maxPictureWidth + 2 * FRAME_MARGIN;
		
		self.imageFrame.frame = CGRectMake((frame.size.width - pictureWidthWithFrame) / 2, 0, pictureWidthWithFrame, pictureHeightWithFrame);
		self.descriptionField.frame = CGRectMake((frame.size.width - pictureWidthWithFrame) / 2, pictureHeightWithFrame + contentGap, pictureWidthWithFrame, frame.size.height - (pictureHeightWithFrame + contentGap));
	}
	else
	{
		if (maxPictureHeight > 360)
		{
			maxPictureHeight = 360;
			fitToHeightWidth = 480;
		}
		
		CGFloat pictureWidthWithFrame = fitToHeightWidth + 2 * FRAME_MARGIN;
		CGFloat pictureHeightWithFrame = maxPictureHeight + 2 * FRAME_MARGIN;
		
		self.imageFrame.frame = CGRectMake(0, (frame.size.height - pictureHeightWithFrame) / 2, pictureWidthWithFrame, pictureHeightWithFrame);
		self.descriptionField.frame = CGRectMake(pictureWidthWithFrame + contentGap, (frame.size.height - pictureHeightWithFrame) / 2, frame.size.width - (pictureWidthWithFrame + contentGap), pictureHeightWithFrame);
	}
	
	// during rotation we'll get a separate callback and animate the change in shadowPath
	if (![self isRotating])
		[self setShadowPathsWithAnimationDuration:0];
	
	NSLog(@"viewWillLayoutSubviews");
}

- (void)setShadowPathsWithAnimationDuration:(NSTimeInterval)duration
{
	UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:self.imageFrame.bounds];
	CGPathRef oldPath = CGPathRetain([self.imageFrame.layer shadowPath]);
	[self.imageFrame.layer setShadowPath:[newPath CGPath]];
	
	if (duration > 0)
	{
		CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
		[pathAnimation setFromValue:(__bridge id)oldPath];
		[pathAnimation setToValue:(id)[self.imageFrame.layer shadowPath]];
		[pathAnimation setDuration:duration];
		[pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[pathAnimation setRemovedOnCompletion:YES];
		
		[self.imageFrame.layer addAnimation:pathAnimation forKey:@"shadowPath"];
	}
	
	CGPathRelease(oldPath);
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	NSLog(@"viewDidLayoutSubviews");
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	if (parent)
		NSLog(@"willMoveToParentViewController");
	else
		NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
	if (parent)
		NSLog(@"didMoveToParentViewController");
	else
		NSLog(@"didRemoveFromParentViewController");
}
-(void)getRecipeStep:(NSArray *)recipeStep{
    self.array_Recipe=recipeStep;
    NSLog(@"567 %@",self.array_Recipe);
}

- (IBAction)button_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)button_VideoTeaching:(id)sender {
    UIWindow *frontWindow = [[[UIApplication sharedApplication] windows]lastObject];
    self.videoPlayerController = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=1fTIhC1WSew&list=FLEYfH4kbq85W_CiOTuSjf8w&feature=mh_lolz"] quality:LBYouTubeVideoQualityLarge];
    self.videoPlayerController.delegate = self;
    self.videoPlayerController.view.frame =frontWindow.bounds;
    self.videoPlayerController.view.center = frontWindow.center;
    [self presentViewController:self.videoPlayerController animated:YES completion:nil];
    
}
@end
