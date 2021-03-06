//
//  addRecipeViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/12/10.
//
//

#import "addRecipeViewController.h"
#import "MMPickerView.h"
#import "GetJsonURLString.h"
#import "addInventoryViewController.h"
#import "addStepViewController.h"


@interface addRecipeViewController ()

@end

@implementation addRecipeViewController
@synthesize table_Material=_table_Material;
@synthesize categories=_categories;
@synthesize label_recipeCategories=_label_recipeCategories;
@synthesize label_recipeName=_label_recipeName;
@synthesize materials=_materials;
@synthesize steps=_steps;
@synthesize recipeName=_recipeName;
@synthesize isInAddMaterial=_isInAddMaterial;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _categories=[[NSArray alloc]initWithObjects:@"熱炒類",@"乾煎美食",@"甜點類", nil];
    [_label_recipeName setText:_recipeName];
    [_label_recipeCategories setText:@"熱炒類"];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _label_recipeCategories=nil;
    _label_recipeName=nil;
    _table_Material=nil;
    _categories=nil;
    _materials=nil;
    _steps=nil;
    _recipeName=nil;
    _isInAddMaterial=nil;

    // Dispose of any resources that can be recreated.
}

- (IBAction)insertRecipe:(id)sender {
    if ([[_label_recipeName text] isEqualToString:@""] || [_label_recipeName text] == (NSString*)[NSNull null]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"錯誤"
                                                        message:@"請輸入食材名稱"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }else{
        NSString *category=@"1";
        if ([[_label_recipeCategories text] isEqualToString:@"熱炒類"]){category=@"1";}
        if ([[_label_recipeCategories text] isEqualToString:@"乾煎美食"]){category=@"2";}
        if ([[_label_recipeCategories text] isEqualToString:@"甜點類"]){category=@"3";}
        

        NSString *tempStringFromMaterials=[_materials componentsJoinedByString:@"shacookie"];
        NSString *tempStringFromSteps=[_steps componentsJoinedByString:@"shacookie"];
        
        NSString *urlString = [NSString stringWithFormat:SetJsonURLString_recipe,User_id,category,[_label_recipeName text],tempStringFromSteps,tempStringFromMaterials];
        
        webGetter = [[WebJsonDataGetter alloc]initWithURLString:urlString];
        [webGetter setDelegate:self];
        
        _materials=nil;
        _steps=nil;
        [_table_Material reloadData];
    }
    
}

- (IBAction)addingMaterial:(id)sender {
    if(_isInAddMaterial==1){
        addInventoryViewController *inventory=[[addInventoryViewController alloc]initWithNibName:@"addInventoryViewController" bundle:nil isBelongsToUser:FALSE recipeMaterial:_materials recipeName:[_label_recipeName text] isInAddMaterial:_isInAddMaterial recipeStep:_steps];
        [self.navigationController  pushViewController:inventory animated:YES];
    }else{
        addStepViewController *stepss=[[addStepViewController alloc]initWithNibName:@"addStepViewController" bundle:nil recipeStep:_steps  recipeName:[_label_recipeName text] isInAddMaterial:_isInAddMaterial recipeMaterial:_materials];
        [self.navigationController  pushViewController:stepss animated:YES];
    }
}

- (IBAction)addingStep:(id)sender {
    _isInAddMaterial=0;
    [_table_Material reloadData];
}

- (IBAction)addingFood:(id)sender {
    _isInAddMaterial=1;
    [_table_Material reloadData];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_label_recipeCategories==textField) {
        [self.view endEditing:TRUE];
        [MMPickerView showPickerViewInView:self.view
                               withStrings:_categories
                               withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor lightGrayColor],
                                             MMbuttonColor: [UIColor blackColor],
                                             MMfont: [UIFont systemFontOfSize:24],
                                             MMvalueY: @3,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    [_label_recipeCategories setText:selectedString];
                                }];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:TRUE];
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isInAddMaterial==1){
        return [_materials count];
    }else{
        return [_steps count];
    }
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"identifier"];
   
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
    }
    
    if(_isInAddMaterial==1){
        cell.textLabel.text =  [_materials objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text =  [_steps objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)doThingAfterWebJsonIsOKFromDelegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                                    message:@"謝謝你的分享"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
    [alert show];
}
@end
