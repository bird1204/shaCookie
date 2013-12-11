//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "profileSideMenuViewController.h"
#import "JsonViewController.h"
#import "loginWithFBViewController.h"
#import "MFSideMenu.h"
#import "aboutUsViewController.h"
#import "newsTimeLineViewController.h"
#import "GetJsonURLString.h"
#import "addInventoryViewController.h"
#import "addRecipeViewController.h"

@implementation profileSideMenuViewController

-(void)viewDidLoad{
    self.array_PofileCategory=[[NSArray alloc]initWithObjects:@"",@"個人檔案",@"動態牆",@"附近好友",@"關於我們",@"新增菜色", nil];
    webGetter =[[WebJsonDataGetter alloc]initWithURLString:[NSString stringWithFormat:GetJsonURLString_Content,User_id]];
    [webGetter setDelegate:self];
    
     self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left.png"]];
    
}
-(void)doThingAfterWebJsonIsOKFromDelegate{

    self.array_Items=[[NSArray alloc]initWithArray:webGetter.webData ];
    
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array_PofileCategory.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {cell.userInteractionEnabled=NO;}

    }
    
    cell.textLabel.text = [self.array_PofileCategory objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];

    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *categoryView=[self buildViewController:indexPath];
    if (categoryView) {
        categoryView.title=[self.array_PofileCategory objectAtIndex:indexPath.row];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        [navigationController setNavigationBarHidden:TRUE animated:TRUE];
        NSArray *controllers = [NSArray arrayWithObject:categoryView];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }else{
        NSLog(@"NOT YET, %d",indexPath.row);
    }
    
}

-(UIViewController *)buildViewController:(NSIndexPath *)indexPath{
    UIViewController *controller=nil;
    switch (indexPath.row) {
        case 1:
            controller=(UIViewController *)[[loginWithFBViewController alloc]initWithNibName:@"loginWithFBViewController" bundle:nil];
            break;
        case 2:
            controller=(UIViewController *)[[newsTimeLineViewController alloc]initWithNibName:@"newsTimeLineViewController" bundle:nil timeLine:self.array_Items];
            break;
        case 3:
            controller=(UIViewController *)[[JsonViewController alloc]initWithNibName:@"JsonViewController" bundle:nil];
            break;
        case 4:
            controller=(UIViewController *)[[aboutUsViewController alloc]initWithNibName:@"aboutUsViewController" bundle:nil];
            break;
        case 5:
            controller=(UIViewController *)[[addRecipeViewController alloc]initWithNibName:@"addRecipeViewController" bundle:nil];
            break;
        default:
            break;
    }

    return controller;
}
@end
