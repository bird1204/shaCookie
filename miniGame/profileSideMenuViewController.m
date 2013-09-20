//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "profileSideMenuViewController.h"
#import "JsonViewController.h"
#import "loginWithFBViewController.h"
#import "MFSideMenu.h"



@implementation profileSideMenuViewController

-(void)viewDidLoad{
    self.array_PofileCategory=[[NSArray alloc]initWithObjects:@"profile",@"news",@"find friends",@"setting",@"promote us",@"contact us", nil];
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
    }
    
    cell.textLabel.text = [self.array_PofileCategory objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *categoryView=[self buildViewController:indexPath];
    if (categoryView) {
        categoryView.title=[self.array_PofileCategory objectAtIndex:indexPath.row];
        UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
        NSArray *controllers = [NSArray arrayWithObject:categoryView];
        navigationController.viewControllers = controllers;
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }else{
        NSLog(@"NOT YET");
    }
}

-(UIViewController *)buildViewController:(NSIndexPath *)indexPath{
    UIViewController *controller=nil;
    switch (indexPath.row) {
        case 0:
            controller=(UIViewController *)[[loginWithFBViewController alloc]initWithNibName:@"loginWithFBViewController" bundle:nil];
            break;
        case 2:
            controller=(UIViewController *)[[JsonViewController alloc]initWithNibName:@"JsonViewController" bundle:nil];
            break;
        default:
            break;
    }

    return controller;
}
@end