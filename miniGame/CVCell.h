//
//  CVCell.h
//  miniGame
//
//  Created by 趴特萬 on 13/5/22.
//
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"
@interface CVCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) IBOutlet UILabel *rankLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image_recipe;
- (IBAction)btn_Like:(id)sender;

@property (nonatomic, strong) ShareViewController *sv;
@property (strong, nonatomic) IBOutlet UIImageView *likeImage;
@property (strong, nonatomic) IBOutlet UIImageView *rankImage;
@property (strong, nonatomic) IBOutlet UIImageView *shareImage;

- (IBAction)btn_Share:(id)sender;

@end
