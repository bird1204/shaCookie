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
#import "recipesWithICarouselViewController.h"
#import "addRecipeViewController.h"


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
    NSString *stringName=[self.getMaterial componentsJoinedByString:@","];
    NSString *str=[NSString stringWithFormat:GetJsonURLString_RecipeByNames,stringName];
    webGetter = [[WebJsonDataGetter alloc]init];
    [webGetter requestWithURLString:[NSString stringWithUTF8String:[str UTF8String]]];
    [webGetter setDelegate:self];
    
    notiMessage=[[UIAlertView alloc] initWithTitle:@"搖一搖！！！"
                                                message:@"請搖一搖幫您隨機配菜" delegate:self cancelButtonTitle:@"開始搖！" otherButtonTitles: nil];
    
    [notiMessage show];
    [notiMessage release];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)doThingAfterWebJsonIsOKFromDelegate{
    self.getRecipes=[[NSArray alloc]initWithArray:webGetter.webData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView==notiMessage) {
        [self noti:buttonIndex];
    }else{
        addRecipeViewController *add=[[addRecipeViewController alloc]initWithNibName:@"addRecipeViewController" bundle:nil];
        switch (buttonIndex) {
            case 0:
                [self.navigationController popViewControllerAnimated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:add animated:TRUE];
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.getMaterial=nil;
    self.getRecipes=nil;
    self.arrayMaterial=nil;
    // Dispose of any resources that can be recreated.
}

-(void)noti:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if (motionManager.gyroAvailable) {
                motionManager.gyroUpdateInterval = 1.0f/3.0f;
                [motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMGyroData* gyroData, NSError *error){
                    
                    
                    
                    if ((gyroData.rotationRate.x>=3 || gyroData.rotationRate.x<=-3) || (gyroData.rotationRate.z>=3 || gyroData.rotationRate.z<=-3)  || (gyroData.rotationRate.y>=3 || gyroData.rotationRate.y<=-3) )
                    {
                        if ([self.getMaterial count]<1) {
                            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"沒有結果" message:@"沒有合適的菜色"delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"我要提供", nil];
                            [alert show];
                            
                            
                        }else{
                            recipesWithICarouselViewController *rwicc=[[recipesWithICarouselViewController alloc]initWithNibName:@"recipesWithICarouselViewController" bundle:nil];
                            rwicc.array_Items=self.getRecipes;
                            [self.navigationController pushViewController:rwicc animated:TRUE];
                        }
                        
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

@end
