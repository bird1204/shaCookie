//
//  addStepViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/12/11.
//
//

#import "addStepViewController.h"
#import "addRecipeViewController.h"
#import "GetJsonURLString.h"


@interface addStepViewController ()

@end

@implementation addStepViewController
@synthesize textStep =_textStep;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil recipeStep:(NSMutableArray*)step recipeName:(NSString *)Rname isInAddMaterial:(int)isadd recipeMaterial:(NSMutableArray *)material
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        recipeStep=step;
        recipeName=Rname;
        isInAddMaterial=isadd;
        recipeMaterial=material;
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _textStep =nil;
    // Dispose of any resources that can be recreated.
}

- (IBAction)sent:(id)sender {
    if ([[_textStep text] isEqualToString:@""] || [_textStep text] == (NSString*)[NSNull null]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"錯誤"
                                                        message:@"請輸入食材名稱"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }else{
        addRecipeViewController *recipe=[[addRecipeViewController alloc]initWithNibName:@"addRecipeViewController" bundle:nil];
        //recipe.materials=[[NSMutableArray alloc]initWithObjects:[_name text], nil];
        if ([recipeStep count]<1) {
            recipeStep=[[NSMutableArray alloc]init];
        }
        [recipeStep addObject:[_textStep text]];
        recipe.isInAddMaterial=isInAddMaterial;
        recipe.steps=[[NSMutableArray alloc]initWithArray:recipeStep];
        recipe.recipeName=recipeName;
        recipe.materials=recipeMaterial;
        
        [self.navigationController pushViewController:recipe animated:TRUE];
    }

}

-(void)doThingAfterWebJsonIsOKFromDelegate{
    webGetter=nil;
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
