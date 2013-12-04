//
//  CVCell.m
//  miniGame
//
//  Created by 趴特萬 on 13/5/22.
//
//

#import "CVCell.h"
#import "ShareViewController.h"
#import "ViewController.h"
@implementation CVCell

@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CVCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}
- (IBAction)btn_Like:(id)sender{
   self.likeLabel.text=[NSString stringWithFormat:@"%d",[self.likeLabel.text intValue]+1];
    
}

- (IBAction)btn_Share:(id)sender {
    self.sv =[[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil pushName:[_titleLabel text]recipeId:[_recipeId text]];
    [self.sv.recipeName setText:[_titleLabel text]];
    [self.window addSubview:self.sv.view];
   // [carousel reloadData];
    
    //
    //    UITextField *textField;
    //    UITextField *textField2;
    //
    //    UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Username and password"
    //                                                     message:@"nnn" // IMPORTANT
    //                                                    delegate:nil
    //                                           cancelButtonTitle:@"Cancel"
    //                                           otherButtonTitles:@"Enter", nil];
    //
    //    textField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)];
    //    [textField setBackgroundColor:[UIColor whiteColor]];
    //    [textField setPlaceholder:@"username"];
    //    [prompt addSubview:textField];
    //
    //    textField2 = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)];
    //    [textField2 setBackgroundColor:[UIColor whiteColor]];
    //    [textField2 setPlaceholder:@"password"];
    //    [textField2 setSecureTextEntry:YES];
    //    [prompt addSubview:textField2];
}



@end
