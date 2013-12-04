//
//  aboutUsViewController.h
//  miniGame
//
//  Created by BirdChiu on 13/9/20.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface aboutUsViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView_Us;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)button_ContactUs:(id)sender;
- (IBAction)button_PromoteUs:(id)sender;

- (IBAction)birdInfo:(id)sender;
- (IBAction)charmingInfo:(id)sender;
- (IBAction)camelInfo:(id)sender;
- (IBAction)heidiInfo:(id)sender;
- (IBAction)keekilerInfo:(id)sender;



-(void)openActiveSessionWithPublishPermissionsOfFaceBook:(NSArray *)publishPermissions;
@end
