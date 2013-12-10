//
//  addRecipeViewController.h
//  miniGame
//
//  Created by 趴特萬 on 13/12/10.
//
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"

@interface addRecipeViewController : UIViewController<WebJsonDataGetFinishDelegater,UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITextField *label_recipeCategories;
    IBOutlet UITextField *label_recipeName;
    WebJsonDataGetter *webGetter;
    NSMutableArray *materials;
    NSString *recipeName;
}

- (IBAction)insertRecipe:(id)sender;
- (IBAction)addingMaterial:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_addingMaterial;
@property (strong, nonatomic) IBOutlet UITextField *label_recipeCategories;
@property (strong, nonatomic) IBOutlet UITextField *label_recipeName;
@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *quantities;
@property (strong,nonatomic) NSMutableArray *materials;
@property (strong,nonatomic) NSString *recipeName;
@property (strong, nonatomic) IBOutlet UITableView *table_Material;
@end
