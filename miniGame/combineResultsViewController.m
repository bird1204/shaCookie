//
//  combineResultsViewController.m
//  miniGame
//
//  Created by 趴特萬 on 13/10/3.
//
//

#import "combineResultsViewController.h"
#import "procedureWithMPFlipViewController.h"
#import "GetJsonURLString.h"
#import <CoreMotion/CoreMotion.h>


@interface combineResultsViewController ()

@end

@implementation combineResultsViewController

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
    
    motionManager=[[CMMotionManager alloc] init];
    self.arrayMaterial=[[NSArray alloc]init];
    self.randomRecipes=[[NSString alloc]init];
    NSString *stringName=[self.getMaterial componentsJoinedByString:@","];
    NSString *str=[NSString stringWithFormat:GetJsonURLString_RecipeByNames,stringName];
    webGetter = [[WebJsonDataGetter alloc]init];
    [webGetter requestWithURLString:[NSString stringWithUTF8String:[str UTF8String]]];
    [webGetter setDelegate:self];
    
    
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"搖一搖！！！"
                                                message:@"請搖一搖幫您隨機配菜" delegate:self cancelButtonTitle:@"開始搖！" otherButtonTitles: nil];
    
    [mes show];
    [mes release];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)doThingAfterWebJsonIsOKFromDelegate{
    self.getRecipes=[[NSArray alloc]initWithArray:webGetter.webData];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(self.getRecipes.count ==0){
        self.randomRecipes= nil;
    }else{
        self.randomRecipes= [[self.getRecipes objectAtIndex:arc4random()%self.getRecipes.count]objectForKey:@"id"];
    }
    
    
    
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"cancel");
            
            if (motionManager.gyroAvailable) {
                motionManager.gyroUpdateInterval = 1.0f/3.0f;
                [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData* gyroData, NSError *error){
                    
                    
                    
                    if ((gyroData.rotationRate.x>=3 || gyroData.rotationRate.x<=-3) && (gyroData.rotationRate.z>=3 || gyroData.rotationRate.z<=-3) &&(gyroData.rotationRate.y>=3 || gyroData.rotationRate.y<=-3) )
                    {
                        NSString *recipeId=self.randomRecipes;
                        NSLog(@"show:%@",recipeId);
                        procedureWithMPFlipViewController *pro=[[procedureWithMPFlipViewController alloc]initWithNibName:@"procedureWithMPFlipViewController" bundle:nil recipeId:recipeId];
                        
                        [self.navigationController pushViewController:pro animated:TRUE];
                    }
                    
                }];
                
            } else {
                NSLog(@"陀螺儀未感測");
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
