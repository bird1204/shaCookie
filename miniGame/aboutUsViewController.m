//
//  aboutUsViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/9/20.
//
//
#import <FacebookSDK/FacebookSDK.h>
#import "aboutUsViewController.h"
#import "AppDelegate.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

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
    self.textView_Us.editable=NO;
    self.textView_Us.selectable = NO;
    self.textView_Us.alpha = 1;
    self.textView_Us.text=@"hi,we are shaCookie.";
    self.textView_Us.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - ContactUS
- (IBAction)button_ContactUs:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"A Message from shacookie"];
        NSArray *toRecipients = [NSArray arrayWithObjects:@"bird1204@gmail.com", @"secondMail@example.com", nil];
        [mailer setToRecipients:toRecipients];
        UIImage *myImage = [UIImage imageNamed:@"icon@2x.png"];
        NSData *imageData = UIImagePNGRepresentation(myImage);
        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        NSString *emailBody = @"Have you seen the shacookie web site?";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark - PromoteUs
- (IBAction)button_PromoteUs:(id)sender {
    //TODO:
    //改成 open graph
    NSArray *publishPermissions = @[@"publish_actions"];
    [self openActiveSessionWithPublishPermissionsOfFaceBook:publishPermissions];
}

- (IBAction)birdInfo:(id)sender {
    [self showInfo:@"你也可以叫他Bird Chiu,一個能夠善用最新工具開發並管理進度的高手,目前持續鑽研RoR以及iOS的開發中.隨時學習並能不斷接受新的挑戰."];
}

- (IBAction)charmingInfo:(id)sender {
    [self showInfo:@"她是阿咪\n她是陳姿瑾"];
}

- (IBAction)camelInfo:(id)sender {
    [self showInfo:@"她是卡毛\n他是吳承韋"];
}

- (IBAction)heidiInfo:(id)sender {
    [self showInfo:@"她是嬰兒\n她是張詩羽"];
}

- (IBAction)keekilerInfo:(id)sender {
    [self showInfo:@"她是江子翠蛇王\n他是高華夏"];
}

- (IBAction)dismissInfo:(id)sender {
    [self.imageView setHidden:NO];
    self.imageView.alpha=1.0f;
    [self.textView_Us setHidden:YES];
}

-(void)openActiveSessionWithPublishPermissionsOfFaceBook:(NSArray *)publishPermissions{
    //  Check if this session have publish permission.
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound || !FBSession.activeSession.accessTokenData) {
        
        [FBSession openActiveSessionWithPublishPermissions:publishPermissions
                                           defaultAudience:FBSessionDefaultAudienceEveryone
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                             
                                             if (session.isOpen && !error) {
                                                 [self publishStory];
                                                 
                                             }else {
                                                 NSLog(@"open publish permission error : %@", error);
                                             }
                                         }];
        
    } else {
        [self publishStory];
    }
}

- (void)publishStory
{
    //SEE:
    // https://developers.facebook.com/docs/reference/api/publishing/
    NSMutableDictionary *arguments = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      @"it's a great App that really upgrade my cooking skill !!!", @"message",
                                      @"https://www.facebook.com/shaCookie", @"link",
                                      @"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-prn1/1176168_402744496493444_1041679152_n.png", @"picture",
                                      @"shaCookie", @"name",
                                      @"Build great cooking apps and get more recipes.", @"caption",
                                      @"cook hard, cook fun", @"description",
                                      nil];
    
    [FBRequestConnection startWithGraphPath:@"me/feed" parameters:arguments HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (error) {
                                  NSLog(@"Share Error : %@", error);
                                  
                              } else {
                                  NSLog(@"Result : %@", result);
                                  NSLog(@"Token : %@", FBSession.activeSession.accessTokenData);
                              }
                          }];
}

#pragma mark -
#pragma mark - info method
-(void)showInfo:(NSString*)info{
    self.imageView.alpha=0.5f;
//    [self.imageView setHidden:YES];
    
    self.textView_Us =[[UITextView alloc]init];
    self.textView_Us.frame=CGRectMake(self.imageView.frame.origin.x+75,self.imageView.frame.origin.y+75,self.imageView.frame.size.width-150,self.tabBarController.tabBar.frame.origin.y-150);
    [self.textView_Us setFont:[UIFont fontWithName:@"system" size:12]];
    self.textView_Us.editable=NO;
    self.textView_Us.textAlignment=NSTextAlignmentCenter;
    self.textView_Us.backgroundColor=[UIColor lightTextColor];
    [self.textView_Us setText:[NSString stringWithFormat:@"\n%@\n",info]];
    
    UIButton *leaveDesc = [UIButton buttonWithType:UIButtonTypeCustom];
    [leaveDesc addTarget:self
                      action:@selector(dismissInfo:)
            forControlEvents:UIControlEventTouchDown];
    [leaveDesc setTitle:@"" forState:UIControlStateNormal];
    leaveDesc.frame = self.textView_Us.frame;
    
    [self.textView_Us addSubview:leaveDesc];
    [self.view addSubview:self.textView_Us];
    

    
}


@end
