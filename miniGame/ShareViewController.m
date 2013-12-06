//
//  ShareViewController.m
//  miniGame
//
//  Created by 吳承韋 on 13/10/16.
//
//

#import "ShareViewController.h"
#import "GetJsonURLString.h"
#import "UILabel+AutoFrame.h"
#import "recipesWithICarouselViewController.h"
@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize pushName = _pushName;
@synthesize recipeId = _recipeId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil pushName:(NSString*)pushName recipeId:(NSString *)recipeId
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pushName=pushName;
        _recipeId=recipeId;
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame=CGRectMake(0, 60, 320, 480);
    self.view.backgroundColor=[UIColor clearColor];
    //self.view.layer.opaque=NO;
    [self.parentViewController.navigationController pushViewController:self animated:YES];
    [self.recipeName setTextWithAutoFrame:_pushName];
    NSString *rank=[NSString stringWithFormat:@"%d",(int)_rank.value];
    //NSString *rankString=[[NSString alloc] initWithString:@"%d",rank];
    //self.rankNumber.text=rankString;
    self.rankNumber.text=rank;
    self.nothingShow.alpha=0.0;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareContent:(id)sender {
    NSString *share=_content.text;
   
    if (share==NULL) {
        UIAlertView *errorAlert=[[UIAlertView alloc]initWithTitle:@"你的訊息" message:@"內容值不可以空白" delegate:self cancelButtonTitle:@"完成" otherButtonTitles:nil];
        [errorAlert show];
    }else{
        NSString *input=[NSString stringWithFormat:@"http://54.244.225.229/shacookie/useThis/inputShare.php?rank=%.f&content=%@&recipeId=%@",self.rank.value,share,_recipeId];
        NSData *dateUrl=[NSData dataWithContentsOfURL:[NSURL URLWithString:input]];
        NSString *result=[[NSString alloc] initWithData:dateUrl encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你的訊息"
                                                        message:@"已分享食譜"
                                                       delegate:self
                                              cancelButtonTitle:@"完成"
                                              otherButtonTitles: nil];
        [alert show];
        [self.view removeFromSuperview];
    }
    
    
}

- (IBAction)exitOut:(id)sender {
    [self.view removeFromSuperview];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    [_content resignFirstResponder];
    
    [super touchesBegan:touches withEvent:event];
    
}
-(IBAction)updateLabel:(id)sender{
    NSInteger sliderValue =(int)_rank.value;
    self.rankNumber.text=[NSString stringWithFormat:@"%d" , sliderValue];
}

@end
