//
//  MaterialCell.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/25.
//
//

#import <UIKit/UIKit.h>

@interface MaterialCell : UICollectionViewCell



@property (nonatomic, getter=isSelected) BOOL selected;


@property (strong, nonatomic) IBOutlet UIImageView *image_Material;
@property (strong, nonatomic) IBOutlet UIImageView *image_Check;
- (IBAction)image_Hidden:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *label_Title;
@end
