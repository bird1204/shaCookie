//
//  materialMenuViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/9/19.
//
//

#import "materialSideViewController.h"
#import "GetJsonURLString.h"
#import "MFSideMenu.h"
#import "WebJsonDataGetter.h"
#import "menuViewController.h"
#import "materialWithCollectionViewController.h"



@implementation materialSideViewController

#pragma mark -
#pragma mark - UITableViewDataSource


 -(void)viewDidLoad{
    [super viewDidLoad];
     self.array_MaterialMenu=[[NSMutableArray alloc]initWithObjects:@"", nil];

     webGetter=[[WebJsonDataGetter alloc]initWithURLString:GetJsonURLString_MaterialType];
    [webGetter setDelegate:self];
     
     UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left.png"]];
     [tempImageView setFrame:self.tableView.frame];
     
     self.tableView.backgroundView = tempImageView;
     [tempImageView release];
     
     //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left.png"]];
}
 



-(void)doThingAfterWebJsonIsOKFromDelegate{
    [self.array_MaterialMenu addObjectsFromArray:webGetter.webData];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array_MaterialMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.backgroundColor=[UIColor clearColor];
        if (indexPath.row==0) {
            NSLog(@"d");
            cell.userInteractionEnabled=NO;
        }


    }
    
    //cell.textLabel.text = [[self.array_MaterialMenu objectAtIndex:indexPath.row]objectForKey:@"category"];
    switch (indexPath.row) {
        case 1:
            cell.textLabel.text=@"青菜類";
            break;
        case 2:
            cell.textLabel.text=@"肉類";
            break;
        case 3:
            cell.textLabel.text=@"海鮮類";
            break;
        case 4:
            cell.textLabel.text=@"調味料";
            
        default:
            break;
    }
    return cell;
}


#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *materialType=[[self.array_MaterialMenu objectAtIndex:indexPath.row]objectForKey:@"category"];
     materialWithCollectionViewController *menuView=[[materialWithCollectionViewController alloc]initWithNibName:@"materialWithCollectionViewController" bundle:nil ];
    
    [menuView materialSearch:materialType];
    menuView.title=[self getMenuTitle:materialType];
    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
   // [navigationController setNavigationBarHidden:TRUE animated:TRUE];
    
    NSArray *controllers = [NSArray arrayWithObject:menuView];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

-(NSString *)getMenuTitle:(NSString*)materialTypeCase{
    NSString *materialType=nil;
    switch ([materialType intValue]) {
        case 1:
            materialType=@"蔬菜類";
            break;
            
        case 2:
            materialType= @"肉類";
            break;
            
        case 3:
            materialType= @"海鮮類";
            break;
            
        case 4:
            materialType= @"調味料";
            break;
            
        default:
            break;
    }
    return materialType;
}
@end
