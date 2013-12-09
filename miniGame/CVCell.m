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
#import "WebJsonDataGetter.h"
#import "GetJsonURLString.h"
@implementation CVCell

@synthesize titleLabel = _titleLabel;
@synthesize recipeId=_recipeId;

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
    NSString *userId=@"3";
    webGetter = [[WebJsonDataGetter alloc]initWithURLString:[NSString stringWithFormat:SetJsonURLString_Like,[_recipeId text],userId]];
    [webGetter setDelegate:self];
}

- (IBAction)btn_Share:(id)sender {
    self.sv =[[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil pushName:[_titleLabel text]recipeId:[_recipeId text]];
    [self.sv.recipeName setText:[_titleLabel text]];
    [self.window addSubview:self.sv.view];
}


-(void)doThingAfterWebJsonIsOKFromDelegate{
    webGetter=nil;
}


@end
