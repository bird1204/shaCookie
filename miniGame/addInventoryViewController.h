//
//  addInventoryViewController.h
//  miniGame
//
//  Created by BirdChiu on 13/10/19.
//
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"

@interface addInventoryViewController : UIViewController<WebJsonDataGetFinishDelegater>{
    IBOutlet UITextField *name;
    IBOutlet UITextField *quantity;
    IBOutlet UITextField *category;
    IBOutlet UITextField *type;
    IBOutlet UIImageView *material_image;
    WebJsonDataGetter *webGetter;
    BOOL isBelongsToUser;
    BOOL isInsert;
    NSMutableArray *recipeMaterial;
    NSMutableArray *recipeStep;
    NSString *recipeName;
    int isInAddMaterial;
}
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *quantity;
@property (retain, nonatomic) IBOutlet UITextField *category;
@property (retain, nonatomic) IBOutlet UITextField *type;

@property (nonatomic, strong) NSArray *steak_Array;
@property (nonatomic, strong) NSArray *fruit_Array;
@property (nonatomic, strong) NSArray *fish_Array;
@property (nonatomic, strong) NSArray *sauce_Array;
@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *quantities;
@property (nonatomic) NSUInteger *index;
@property (strong,nonatomic) NSArray *materials;



- (IBAction)insert:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isBelongsToUser:(BOOL)isUser recipeMaterial:(NSMutableArray*)material recipeName:(NSString*)Rname isInAddMaterial:(int)isadd recipeStep:(NSMutableArray*)step;

@end
