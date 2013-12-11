//
//  addInventoryViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/10/19.
//
//

#import "addInventoryViewController.h"
#import "MMPickerView.h"
#import "addRecipeViewController.h"
#import "GetJsonURLString.h"


@interface addInventoryViewController ()

@end

@implementation addInventoryViewController
@synthesize name=_name;
@synthesize quantity=_quantity;
@synthesize category=_category;
@synthesize type=_type;
@synthesize quantities=_quantities;
@synthesize categories=_categories;
@synthesize materials=_materials;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isBelongsToUser:(BOOL)isUser recipeMaterial:(NSMutableArray*)material recipeName:(NSString*)Rname isInAddMaterial:(int)isadd        recipeStep:(NSMutableArray *)step
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isBelongsToUser=isUser;
        recipeMaterial=material;
        recipeName=Rname;
        isInAddMaterial=isadd;
        recipeStep=step;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webGetter = [[WebJsonDataGetter alloc]initWithURLString:[NSString stringWithFormat:GetJsonURLString_MaterialName]];
    isInsert=FALSE;
    [webGetter setDelegate:self];
    _categories=[[NSArray alloc]initWithObjects:@"肉",@"蔬菜",@"海鮮",@"調味料", nil];
    _quantities=[[NSArray alloc]initWithObjects:
                 @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                 @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                 @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    [_category setText:@"肉"];
    [_quantity setText:@"1"];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _category=nil;
    _name=nil;
    _type=nil;
    _quantity=nil;
    // Dispose of any resources that can be recreated.
}

- (IBAction)insert:(id)sender {
    if ([[_name text] isEqualToString:@""] || [_name text] == (NSString*)[NSNull null]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"錯誤"
                                                        message:@"請輸入食材名稱"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }else{
        if (isBelongsToUser) {
            webGetter = [[WebJsonDataGetter alloc]initWithURLString:[NSString stringWithFormat:SetJsonURLString_UserInventory,User_id,[_type text],[_category text],[_name text],[_quantity text]]];
            isInsert = true;
            [webGetter setDelegate:self];
        }else{
            addRecipeViewController *recipe=[[addRecipeViewController alloc]initWithNibName:@"addRecipeViewController" bundle:nil];
            if ([recipeMaterial count]<1) {
                recipeMaterial=[[NSMutableArray alloc]init];
            }
            [recipeMaterial addObject:[_name text]];
            recipe.isInAddMaterial=isInAddMaterial;
            recipe.materials=[[NSMutableArray alloc]initWithArray:recipeMaterial];
            recipe.recipeName=recipeName;
            recipe.steps=recipeStep;
            
            NSLog(@"zzzz : %@",recipe.materials);
            [self.navigationController pushViewController:recipe animated:TRUE];
        }
        
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_quantity==textField) {
        [self.view endEditing:TRUE];
        [MMPickerView showPickerViewInView:self.view
                               withStrings:_quantities
                               withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor lightGrayColor],
                                             MMbuttonColor: [UIColor blackColor],
                                             MMfont: [UIFont systemFontOfSize:24],
                                             MMvalueY: @3,
                                             MMselectedObject:[_quantity text],
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    [_quantity setText:selectedString];
                                }];
        return NO;
    }
    if (_category==textField) {
        [self.view endEditing:TRUE];
        
        [MMPickerView showPickerViewInView:self.view
                               withStrings:_categories
                               withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor lightGrayColor],
                                             MMbuttonColor: [UIColor blackColor],
                                             MMfont: [UIFont systemFontOfSize:24],
                                             MMvalueY: @3,
                                             MMselectedObject:[_category text],
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    [_category setText:selectedString];
                                }];
        return NO;
    }
    if (_name==textField) {
        switch ([_categories indexOfObject:[_category text]]) {
            case 0:
                [self showPicker:self.steak_Array];
                break;
            case 1:
                [self showPicker:self.fruit_Array];
                break;
            case 2:
                [self showPicker:self.fish_Array];
                break;
            case 3:
                [self showPicker:self.sauce_Array];
                break;
            default:
                NSLog(@"not found");
                break;
        }
        
        [self.view endEditing:TRUE];
        
        
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:TRUE];
    return YES;
}

-(void)doThingAfterWebJsonIsOKFromDelegate{
    if (isInsert) {
        [self.navigationController popViewControllerAnimated:TRUE];
        webGetter=nil;
    }else{
        self.steak_Array=[self arrayRecreate:webGetter.webData category:0];
        [_name setText:[self.steak_Array objectAtIndex:0]];
        self.fruit_Array=[self arrayRecreate:webGetter.webData category:1];
        self.fish_Array=[self arrayRecreate:webGetter.webData category:2];
        self.sauce_Array=[self arrayRecreate:webGetter.webData category:3];
    }
}



-(NSArray*)arrayRecreate:(NSArray*)webData category:(NSInteger)category{
    NSMutableArray *objs=[[ NSMutableArray alloc]init];
    for (NSDictionary *dic in [webData objectAtIndex:category]) {
        [objs addObject:[dic objectForKey:@"name"]];
//        NSString *urlString = [NSString stringWithFormat:@"http://54.244.225.229/shacookie/image/material/%@",[dic objectForKey:@"image_url"]];
//        NSURL *imageUrl =[NSURL URLWithString:urlString];
//        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
//        material_image.image = [UIImage imageWithData:imageData];
//        NSLog(@"%@",urlString);
    };
    NSLog(@"%@",objs);
    return objs;
}

-(void)showPicker:(NSArray*)strings{
    NSDictionary *options =@{MMbackgroundColor: [UIColor lightTextColor],
                             MMtextColor: [UIColor blackColor],
                             MMtoolbarColor: [UIColor lightGrayColor],
                             MMbuttonColor: [UIColor blackColor],
                             MMfont: [UIFont systemFontOfSize:24],
                             MMvalueY: @3,
                             MMtextAlignment:@1};
    [MMPickerView showPickerViewInView:self.view
                            withStrings:strings
                            withOptions:options
                            completion:^(NSString *selectedString) {
                                [_name setText:selectedString];
                            }];

}

@end
