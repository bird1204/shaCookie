//
//  addStepViewController.h
//  miniGame
//
//  Created by 趴特萬 on 13/12/11.
//
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"


@interface addStepViewController : UIViewController<WebJsonDataGetFinishDelegater>{
    
    IBOutlet UITextField *textStep;
    WebJsonDataGetter *webGetter;
    NSMutableArray *recipeStep;
    NSMutableArray *recipeMaterial;

    NSString *recipeName;
    int isInAddMaterial;
    
}
@property (strong, nonatomic) IBOutlet UITextField *textStep;

- (IBAction)sent:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil recipeStep:(NSMutableArray*)step recipeName:(NSString*)Rname isInAddMaterial:(int)isadd recipeMaterial:(NSMutableArray*)material;


@end
