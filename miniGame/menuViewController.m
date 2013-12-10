//
//  menuViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/5/22.
//
//

#import "menuViewController.h"
#import "foodDetailViewController.h"
#import "matchMaterialViewController.h"
#import "refViewController.h"
#import "moveFinishViewController.h"
#import "GetJsonURLString.h"
#import "ASIHTTPRequest.h"
#import "WebJsonDataGetter.h"
@interface menuViewController ()

@end

@implementation menuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar_back.alpha=0.0;
    mutableDictionary_SelectedFood=[[NSMutableDictionary alloc] init];
    
    //PlsitRead *readPlist=[[PlsitRead alloc] initWithFileName:@"foodData.plist"];
    //array_Food=[readPlist readFromFile];
    //origin_Food = array_Food; 這行意義不明
    
    
    
    UIBarButtonItem *btn_sent=[[UIBarButtonItem alloc] initWithTitle:@"sent" style:UIBarButtonItemStylePlain target:self action:@selector(sentTheData:)];
    [self.navigationItem setRightBarButtonItem:btn_sent];
// 搜尋以後用
//    UIBarButtonItem *btn_needSearch=[[UIBarButtonItem alloc] initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAppear:)];
//    [self.navigationItem setRightBarButtonItem:btn_needSearch];
	// Do any additional setup after loading the view, typically from a nib.
    
    motionManager = [[CMMotionManager alloc] init];
    
    UIDevice *device=[UIDevice currentDevice];
    [device beginGeneratingDeviceOrientationNotifications];
    UIDeviceOrientation orientation=device.orientation;
    [device endGeneratingDeviceOrientationNotifications];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


-(void)materialSearch:(NSString*)materialTypeCase{
    webGetter = [[WebJsonDataGetter alloc]init];
    NSString *str=[NSString stringWithFormat:GetJsonURLString_Material,materialTypeCase];
    [webGetter requestWithURLString:[NSString stringWithUTF8String:[str UTF8String]]];
    [webGetter setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.array_Material=nil;
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionInTableView:(UITableView *)tableView{
    return 1;
}


-(void)doThingAfterWebJsonIsOKFromDelegate{
    self.array_Material=[[NSArray alloc]initWithArray:webGetter.webData];
    [self.tableView_Food reloadData];
    
    //mutableDictionary_SelectedFood=[[NSMutableDictionary alloc] init];
   
    
}
#pragma mark -
#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array_Material count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //抓陣列的值
    static NSString *CellIndentifier=@"MyCell01";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text=[[webGetter.webData objectAtIndex:indexPath.row] objectForKey:@"name"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [mutableDictionary_SelectedFood removeObjectForKey:indexPath];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [mutableDictionary_SelectedFood setObject:[ webGetter.webData objectAtIndex:indexPath.row] forKey:indexPath];
    }
    
    //如果無資料 則不需跳下一頁
    /*if (![[[array_Food objectAtIndex:0] objectForKey:@"Name" ] isEqualToString:@"NO DATA"]) {
     
     foodDetailViewController *foodView=[[foodDetailViewController alloc] initWithNibName:@"foodDetailViewController" bundle:nil];
     foodView.dict=[array_Food objectAtIndex:indexPath.row];
     //[foodView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
     //[self presentViewController:foodView animated:YES completion:nil];
     [self.navigationController pushViewController:foodView animated:YES];
     }
     */
    
}
#pragma mark -
#pragma mark - 篩選按鈕
-(void)sentTheData:(id)sender{
    matchMaterialViewController *secView=[[matchMaterialViewController alloc]initWithNibName:@"matchMaterialViewController" bundle:nil];
    secView.dictionary_SelectedFood=mutableDictionary_SelectedFood;
    [self.navigationController pushViewController:secView animated:YES];
    
    
}
#pragma mark -
#pragma mark - 炒菜按鈕
- (IBAction)button_StartMotion:(id)sender {

        
    refViewController *rv=[[refViewController alloc] init];
    moveFinishViewController *mv=[[moveFinishViewController alloc] init];
        if (motionManager.gyroAvailable) {
            motionManager.gyroUpdateInterval = 1.0f/3.0f;
            [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData* gyroData, NSError *error){
                
                               
            if ((gyroData.rotationRate.x>=10 || gyroData.rotationRate.x<=-10))
            {
                [self presentViewController:mv animated:YES completion:nil];
            }
                
            if ((gyroData.rotationRate.z>=8 || gyroData.rotationRate.z<=-8))
            {
                [self presentViewController:rv animated:YES completion:Nil];
            }
            
            if ((gyroData.rotationRate.y>=8 || gyroData.rotationRate.y<=-8))
            {
                NSLog(@"炒菜動作成功");
            }
            if ((gyroData.rotationRate.x>=3 || gyroData.rotationRate.x<=-3) && (gyroData.rotationRate.z>=3 || gyroData.rotationRate.z<=-3) &&(gyroData.rotationRate.y>=3 || gyroData.rotationRate.y<=-3) )
            {
                NSLog(@"炸動作成功");
            }
            
        }];
        
    } else {
        NSLog(@"陀螺儀未感測");
    }
    
    
}



// 搜尋以後用

//-(void)searchBarAppear:(id)sender{
//    self.searchBar_back.alpha=1.0-self.searchBar_back.alpha;
//    self.tableView_Food.frame=CGRectMake(0, 44, 320, 416);
//}



//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//    NSPredicate *pre=[NSPredicate predicateWithFormat:@"Name contains[cd] %@",searchText ];
//    //cd is ==
//    array_Food=[origin_Food filteredArrayUsingPredicate:pre];
//    
//    //無資料之動作
//    if (![array_Food count]) {
//        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
//        [dict setObject:@"NO DATA" forKey:@"Name"];
//        [dict setObject:@"try again" forKey:@"No"];
//        
//        array_Food =[NSArray arrayWithObject:dict];
//    }
//    
//    
//    [self.tableView_Food reloadData ];
//}
//
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    UIBarButtonItem *btn=[[UIBarButtonItem alloc] initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyBord:)];
//    [self.navigationItem setRightBarButtonItem:btn];
//}

//-(void)dismissKeyBord:(id)sender{
//    //把畫面重置
//    self.searchBar_back.alpha=0.0;
//    array_Food=origin_Food;
//    [self.tableView_Food reloadData ];
//    
//    //NSLog(@"dismiss keyboard");
//    //把鍵盤關掉
//    [self.searchBar_back resignFirstResponder];
//    //把Done關掉
//    [self.navigationItem setRightBarButtonItem:nil];
//    UIBarButtonItem *btn_needSearch=[[UIBarButtonItem alloc] initWithTitle:@"search" style:UIBarButtonItemStylePlain target:self action:@selector(searchBarAppear:)];
//    [self.navigationItem setRightBarButtonItem:btn_needSearch];
//    self.tableView_Food.frame=CGRectMake(0, 0, 320, 416);
//}
@end