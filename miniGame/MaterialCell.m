//
//  MaterialCell.m
//  miniGame
//
//  Created by 趴特萬 on 13/9/25.
//
//

#import "MaterialCell.h"

@interface MaterialCell ()

@end

@implementation MaterialCell

@synthesize label_Title = _label_Title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"MaterialCell" owner:self options:nil];
        
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

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if(selected) {
        [self.image_Check setHidden:NO];

    }
    else {
        [self.image_Check setHidden:YES];

    }
}
@end