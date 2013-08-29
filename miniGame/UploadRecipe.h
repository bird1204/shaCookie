//
//  UploadRecipe.h
//  miniGame
//
//  Created by 趴特萬 on 13/5/31.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "RecipeInfo.h"
@interface UploadRecipe : UIViewController<RecipeInFoDelegate>
{
    RecipeInfo *myRecipe;
    ASIHTTPRequest *asiRequest;
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *food;
@property (strong, nonatomic) IBOutlet UITextField *step;

- (IBAction)submit:(id)sender;

@end