//
//  recipesSideViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/9/20.
//
//

#import "recipesSideViewController.h"
#import "GetJsonURLString.h"
#import "MFSideMenu.h"
#import "recipesWithICarouselViewController.h"
#import "addRecipeViewController.h"


@interface recipesSideViewController ()

@end

@implementation recipesSideViewController
@synthesize dictionary_RecipesMenu=_dictionary_RecipesMenu;
@synthesize array_RecipesMenu=_array_RecipesMenu;

- (void)viewDidLoad
{
    [super viewDidLoad];
    webGetter =[[WebJsonDataGetter alloc]init];
    [webGetter requestWithURLString:GetJsonURLString_RecipeType];
    [webGetter setDelegate:self];
  
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left.png"]];
}

-(void)doThingAfterWebJsonIsOKFromDelegate{
    _array_RecipesMenu=[[NSMutableArray alloc]initWithObjects:@"", nil];
    [_array_RecipesMenu addObjectsFromArray:webGetter.webData];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _dictionary_RecipesMenu = nil;
    _array_RecipesMenu = nil;
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_array_RecipesMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    NSString *recipesType=@"0";
    if (indexPath.row==0){
        cell.userInteractionEnabled=NO;
    }else{
        recipesType=[[_array_RecipesMenu objectAtIndex:indexPath.row]objectForKey:@"type"];
    }
    cell.textLabel.text=[self getRecipeTitle:recipesType];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type=[[self.array_RecipesMenu objectAtIndex:indexPath.row]objectForKey:@"type"];
    recipesWithICarouselViewController *recipeView=[[recipesWithICarouselViewController alloc]initWithNibName:@"recipesWithICarouselViewController" bundle:nil ];
    [recipeView recipesSearch:type materialNames:nil];
    
    
    recipeView.title=[self getRecipeTitle:type];

    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    [navigationController setNavigationBarHidden:TRUE animated:TRUE];

    NSArray *controllers = [NSArray arrayWithObject:recipeView];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

-(NSString *)getRecipeTitle:(NSString*)recipesType{
    NSString *type=nil;
    switch ([recipesType intValue]) {
        case 1:
            type= @"熱炒類";
            break;
        case 2:
            type= @"乾煎美食";
            break;
        case 3:
            type= @"甜點類";
            break;
        default:
            break;
    }
    return type;
}

@end
