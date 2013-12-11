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
   WebJsonDataGetter *webGetter;
   BOOL isBelongsToUser;
   NSMutableArray *recipeMaterial;
    NSString *recipeName;
    int isInAddMaterial;
}
@property (retain, nonatomic) IBOutlet UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *quantity;
@property (retain, nonatomic) IBOutlet UITextField *category;
@property (retain, nonatomic) IBOutlet UITextField *type;

@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *quantities;

- (IBAction)insert:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isBelongsToUser:(BOOL)isUser recipeMaterial:(NSMutableArray*)material recipeName:(NSString*)Rname isInAddMaterial:(int)isadd;

@end
