//
//  JsonViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/27.
//
//
#import <unistd.h>
#import "JsonViewController.h"
#import "GetJsonURLString.h"
#import "KoaPullToRefresh.h"
#import "ViewController.h"

@interface JsonViewController ()

@end

@implementation JsonViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        webGetter=[[WebJsonDataGetter alloc] init];
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter=kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
     [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //Add pull to refresh
    __block JsonViewController *jc = self;
    [self.tableView_Json addPullToRefreshWithActionHandler:^{
        [jc refreshTable];
    } withBackgroundColor:[UIColor colorWithRed:0.251 green:0.663 blue:0.827 alpha:1] withPullToRefreshHeightShowed:4];
    
    //Customize pulltorefresh text colors
    [self.tableView_Json.pullToRefreshView setTextColor:[UIColor whiteColor]];
    [self.tableView_Json.pullToRefreshView setTextFont:[UIFont fontWithName:@"OpenSans-Semibold" size:16]];
    
    //Set fontawesome icon
    [self.tableView_Json.pullToRefreshView setFontAwesomeIcon:@"icon-refresh"];
    
    //Set titles
    [self.tableView_Json.pullToRefreshView setTitle:@"Pull" forState:KoaPullToRefreshStateStopped];
    [self.tableView_Json.pullToRefreshView setTitle:@"Release" forState:KoaPullToRefreshStateTriggered];
    [self.tableView_Json.pullToRefreshView setTitle:@"Loading" forState:KoaPullToRefreshStateLoading];
    
    //Hide scroll indicator
    [self.tableView_Json setShowsVerticalScrollIndicator:NO];
    [self.tableView_Json.pullToRefreshView startAnimating];
    
     self.tableView_Json.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView_Json.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.tableView_Json=nil;
    // Dispose of any resources that can be recreated.
}

- (void)refreshTable
{
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor]UUIDString];
    [webGetter requestWithURLString:[NSString stringWithFormat:GetJsonURLString_Device,deviceId]];
    [webGetter setDelegate:self];

    [self.tableView_Json performSelector:@selector(reloadData) withObject:nil afterDelay:2];
    [self.tableView_Json.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    Array_locaions=locations;
    [locationManager stopUpdatingLocation];
}

-(void)doThingAfterWebJsonIsOKFromDelegate{
    self.array_nearUsers=webGetter.webData;
    [self.tableView_Json reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array_nearUsers count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //抓陣列的值
    
    static NSString *CellIndentifier=@"MyCell01";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
        
    }

    NSString *main_text=[NSString stringWithFormat:@"%@",[[self.array_nearUsers objectAtIndex:indexPath.row]objectForKey:@"display_name"]];
    cell.textLabel.text=main_text;
    
    CLLocation *loc=[Array_locaions lastObject];
    CLLocation *default_Location=[[CLLocation alloc]initWithLatitude:[[[self.array_nearUsers objectAtIndex:indexPath.row]objectForKey:@"latitude"] doubleValue] longitude:[[[self.array_nearUsers objectAtIndex:indexPath.row]objectForKey:@"longtitude"] doubleValue]];
    CLLocationDistance meters =[loc distanceFromLocation:default_Location];
    
    NSString *detail_text=[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"DISTANCE:%fKM",(CGFloat)meters/1000]];
    cell.detailTextLabel.text=detail_text;
    cell.backgroundColor=[UIColor clearColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)button_Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

