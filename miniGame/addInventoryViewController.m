//
//  addInventoryViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/10/19.
//
//

#import "addInventoryViewController.h"
#import "addRecipeViewController.h"
#import "GetJsonURLString.h"
#import "MMPickerView.h"
#import "AsyncImageView.h"


@interface addInventoryViewController ()

@end

@implementation addInventoryViewController
@synthesize stringWithUrl=_stringWithUrl;
@synthesize name=_name;
@synthesize quantity=_quantity;
@synthesize category=_category;
@synthesize type=_type;
@synthesize quantities=_quantities;
@synthesize categories=_categories;
@synthesize materials=_materials;
@synthesize origin_Array=_origin_Array;
@synthesize steak_Array=_steak_Array;
@synthesize fruit_Array=_fruit_Array;
@synthesize fish_Array=_fish_Array;
@synthesize sauce_Array=_sauce_Array;


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
    _steak_Array=nil;
    _sauce_Array=nil;
    _fruit_Array=nil;
    _origin_Array=nil;
    _fish_Array=nil;
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
                [self showPicker:_steak_Array category:0];
                break;
            case 1:
                [self showPicker:_fruit_Array category:1];
                break;
            case 2:
                [self showPicker:_fish_Array category:2];
                break;
            case 3:
                [self showPicker:_sauce_Array category:3];
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
        _steak_Array=[self arrayRecreate:webGetter.webData category:0];
        [_name setText:[self.steak_Array objectAtIndex:0]];
        _fruit_Array=[self arrayRecreate:webGetter.webData category:1];
        _fish_Array=[self arrayRecreate:webGetter.webData category:2];
        _sauce_Array=[self arrayRecreate:webGetter.webData category:3];
        _origin_Array=webGetter.webData;
    }
}



-(NSArray*)arrayRecreate:(NSArray*)webData category:(NSUInteger)category{
    NSMutableArray *objs=[[ NSMutableArray alloc]init];
    for (NSDictionary *dic in [webData objectAtIndex:category]) {
        [objs addObject:[dic objectForKey:@"name"]];
    };
    return objs;
}
-(void)showPicker:(NSArray*)strings category:(NSUInteger)category{
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
                                for (NSDictionary *dic in [_origin_Array objectAtIndex:category]) {
                                    if ([[dic allKeysForObject:selectedString] count]>0) {
                                        [self showImageByMaterial:[dic objectForKey:@"image_url"]];
                                    }
                                };
                            }];
}

#define IMAGE_VIEW_TAG 99
-(void)showImageByMaterial:(NSString*)filename{
    //add AsyncImageView to cell
    AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:(CGRectMake(0.0f, 0.0f, material_image.frame.size.width, material_image.frame.size.height))];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.tag = IMAGE_VIEW_TAG;
    [material_image addSubview:imageView];
    
    //get image view
    imageView = (AsyncImageView *)[material_image viewWithTag:IMAGE_VIEW_TAG];
    
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
    
    //load the image
    
    NSString *str=[NSString stringWithFormat:GetImageUrl_material,filename];
    imageView.imageURL = [NSURL URLWithString:str];
}

@end
