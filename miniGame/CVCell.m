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
#import "AppDelegate.h"
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
    NSLog(@"%@",self.window.subviews);

    self.likeLabel.text=[NSString stringWithFormat:@"%d",[self.likeLabel.text intValue]+1];
    NSString *input=[NSString stringWithFormat:@"http://54.244.225.229/shacookie/useThis/inputLike.php?recipeId=%@",_recipeId];
    NSData *dateUrl=[NSData dataWithContentsOfURL:[NSURL URLWithString:input]];
    NSString *result=[[NSString alloc] initWithData:dateUrl encoding:NSUTF8StringEncoding];
    NSLog(@"%@",result);
    
}

- (IBAction)btn_Share:(id)sender {
    self.sv =[[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil pushName:[_titleLabel text]recipeId:[_recipeId text]];
    [self.sv.recipeName setText:[_titleLabel text]];
    [self.window addSubview:self.sv.view];
}



@end
