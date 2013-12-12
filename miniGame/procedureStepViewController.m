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
#import "GetJsonURLString.h"
#import "AsyncImageView.h"


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
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define IMAGE_VIEW_TAG 99
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	//[self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    
    
    if ([self movieIndex] == self.step) {
        UIButton *button_Back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button_Back addTarget:self
                        action:@selector(button_back:)
              forControlEvents:UIControlEventTouchDown];
        [button_Back setTitle:@"Back" forState:UIControlStateNormal];
        button_Back.frame = CGRectMake(0.0, 0.0, 50.0, 50.0);
        [self.view addSubview:button_Back];
        
    }
    
    self.descriptionField.editable = NO;
    self.titleLabel.text = [[self.array_Items objectAtIndex:0]objectForKey:@"name"];
    
    
    //add AsyncImageView to cell
    AsyncImageView *image = [[AsyncImageView alloc] initWithFrame:CGRectMake(self.imageFrame.frame.origin.x, self.titleLabel.frame.size.height,self.imageView.frame.size.width-10, self.imageView.frame.size.height-20)];
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    image.tag = IMAGE_VIEW_TAG;
    [self.imageFrame addSubview:image];
    
    //get image view
	//image = (AsyncImageView *)[self.imageView viewWithTag:IMAGE_VIEW_TAG];
	
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:image];
    [[AsyncImageLoader sharedLoader] setLoadingTimeout:3];

    
    //load the image
    NSString *str=[NSString stringWithFormat:GetRecipesImage,[[[[self.array_Items objectAtIndex:1]objectForKey:@"step"]objectAtIndex:[self movieIndex]-1]objectForKey:@"image_url"]];
    //NSLog(@"imgae: %@",str);
    image.imageURL = [NSURL URLWithString:str];


    self.descriptionField.text = [[[[self.array_Items objectAtIndex:1]objectForKey:@"step"] objectAtIndex:[self movieIndex]-1]objectForKey:@"step"];
    self.descriptionField.backgroundColor=[UIColor clearColor];
	
	[self.imageFrame.layer setShadowOpacity:0.5];
	[self.imageFrame.layer setShadowOffset:CGSizeMake(0, 1)];
    self.imageView.userInteractionEnabled=YES;
    
    

    
    //listen tap event
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.descriptionField addGestureRecognizer:doubleTap];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIWindow *frontWindow = [[[UIApplication sharedApplication] windows]lastObject];
    //@"http://www.youtube.com/watch?v=1fTIhC1WSew&list=FLEYfH4kbq85W_CiOTuSjf8w&feature=mh_lolz"
    self.videoPlayerController = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:self.step_url] quality:LBYouTubeVideoQualityLarge];
    self.videoPlayerController.view.frame =frontWindow.bounds;
    self.videoPlayerController.view.center = frontWindow.center;
    [self presentViewController:self.videoPlayerController animated:YES completion:nil];
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
	//NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	//NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	//NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	//NSLog(@"viewDidDisappear");
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
	
	//NSLog(@"viewWillLayoutSubviews");
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
	//NSLog(@"viewDidLayoutSubviews");
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
//	if (parent)
//		NSLog(@"willMoveToParentViewController");
//	else
//		NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
//	if (parent)
//		NSLog(@"didMoveToParentViewController");
//	else
//		NSLog(@"didRemoveFromParentViewController");
}
-(void)getRecipeStep:(NSArray *)recipeStep{
    self.array_Items=recipeStep;
    self.step=[[[recipeStep objectAtIndex:1]objectForKey:@"step"]count];
    self.step_url=[[[[self.array_Items objectAtIndex:1]objectForKey:@"step"] objectAtIndex:0]objectForKey:@"stepMovie"];
}

- (IBAction)button_back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)button_VideoTeaching:(id)sender {
    UIWindow *frontWindow = [[[UIApplication sharedApplication] windows]lastObject];
    //@"http://www.youtube.com/watch?v=1fTIhC1WSew&list=FLEYfH4kbq85W_CiOTuSjf8w&feature=mh_lolz"
    self.videoPlayerController = [[LBYouTubePlayerViewController alloc] initWithYouTubeURL:[NSURL URLWithString:self.step_url] quality:LBYouTubeVideoQualityLarge];
    self.videoPlayerController.view.frame =frontWindow.bounds;
    self.videoPlayerController.view.center = frontWindow.center;
    [self presentViewController:self.videoPlayerController animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark LBYouTubeExtractorDelegate

-(void)youTubeExtractor:(LBYouTubeExtractor *)extractor didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    
}

-(void)youTubeExtractor:(LBYouTubeExtractor *)extractor failedExtractingYouTubeURLWithError:(NSError *)error {
   
}

#pragma mark -
#pragma mark UITapGestureRecognizer method

- (void)singleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    [_tableView setHidden:TRUE];
}

- (void)doubleTapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.descriptionField.frame style:UITableViewStylePlain];
    _tableView = tableView;
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
    //listen tap event
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    singleTap.numberOfTapsRequired = 1;
    [_tableView addGestureRecognizer:singleTap];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyCellIdentifier = @"MyCellIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
    NSString *name=[[[[self.array_Items objectAtIndex:1]objectForKey:@"material"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSString *quantity=[[[[self.array_Items objectAtIndex:1]objectForKey:@"material"]objectAtIndex:indexPath.row]objectForKey:@"quantity"];
    NSString *type=[[[[self.array_Items objectAtIndex:1]objectForKey:@"material"]objectAtIndex:indexPath.row]objectForKey:@"type"];
    if ([quantity isEqual:@"0"]) {
        quantity=@"";
    }
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text=name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@",quantity,type];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.array_Items objectAtIndex:1]objectForKey:@"material"]count];
}

@end
