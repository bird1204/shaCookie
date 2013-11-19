//
//  recipesWithICarouselViewController.m
//  miniGame
//
//  Created by BirdChiu on 13/9/15.
//
//
#import "materialViewController.h"
#import "recipesWithICarouselViewController.h"
#import "GetJsonURLString.h"
#import "procedureWithMPFlipViewController.h"
#import "AsyncImageView.h"
#import "KoaPullToRefresh.h"
#import "UILabel+AutoFrame.h"


@interface recipesWithICarouselViewController ()

@end

@implementation recipesWithICarouselViewController
#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

-(void)recipesSearch:(NSString*)recipeType materialNames:(NSMutableArray *)materialNames{
    webGetter = [[WebJsonDataGetter alloc]init];
    if(recipeType!=nil && materialNames == nil){
        NSString *stringRecipe=[NSString stringWithFormat:GetJsonURLString_Recipe,recipeType];
        [webGetter requestWithURLString:[NSString stringWithUTF8String:[stringRecipe UTF8String]]];
        [webGetter setDelegate:self];
    };
    if(recipeType == nil && materialNames!=nil){
        NSString *stringName=[materialNames componentsJoinedByString:@","];
        NSString *str=[NSString stringWithFormat:GetJsonURLString_RecipeByNames,stringName];
        [webGetter requestWithURLString:[NSString stringWithUTF8String:[str UTF8String]]];
        [webGetter setDelegate:self];
    }

}

-(void)didReceiveMemoryWarning{
    self.array_Items = nil;
    self.carousel=nil;
}


-(void)doThingAfterWebJsonIsOKFromDelegate{
    self.array_Items = webGetter.webData;
    [self.carousel reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.carousel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]];
    self.carousel.type = iCarouselTypeCoverFlow;
    self.carousel.vertical = true;
    
    // Do any additional setup after loading the view from its nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

-(NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return [self.array_Items count];
}
#define IMAGE_VIEW_TAG 99

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    cell = [[CVCell alloc]initWithFrame:CGRectMake(0, 0, 300.0f, 317.0f)];
    
    //add AsyncImageView to cell
    AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(15.0f, 11.0f, 271.0f, 234.0f)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.tag = IMAGE_VIEW_TAG;
    [cell addSubview:imageView];
    
    //get image view
	imageView = (AsyncImageView *)[cell viewWithTag:IMAGE_VIEW_TAG];
	
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
    
    //load the image
    NSString *str=[NSString stringWithFormat:GetRecipesImage,[[self.array_Items objectAtIndex:index]objectForKey:@"image_url"]];
    imageView.imageURL = [NSURL URLWithString:str];
    
    
    NSString *rank=[[self.array_Items objectAtIndex:index]objectForKey:@"rank_avg"];
    [cell.recipeId setText:[[self.array_Items objectAtIndex:index]objectForKey:@"id"]];
    [cell.titleLabel setText:[[self.array_Items objectAtIndex:index]objectForKey:@"name"]];
    [cell.likeLabel setTextWithAutoFrame:[NSString stringWithFormat:@"%@",[[self.array_Items objectAtIndex:index]objectForKey:@"like_sum"]]];
    [cell.shareLabel setTextWithAutoFrame:[NSString stringWithFormat:@"%@",[[self.array_Items objectAtIndex:index]objectForKey:@"share_sum"]]];
    [cell.rankLabel setTextWithAutoFrame:[NSString stringWithFormat:@"%d",[rank integerValue]]];
    
    cell.rankImage.image=[UIImage imageNamed:@"rank"];
    cell.shareImage.image=[UIImage imageNamed:@"share"];
    cell.likeImage.image=[UIImage imageNamed:@"like"];
    
    view=(UIView *)cell;
    
    UIButton *button_like = (UIButton*)[cell viewWithTag:10];
    [button_like addTarget:self
                    action:@selector(button_like:)
          forControlEvents:UIControlEventTouchDown];
    [cell addSubview:button_like];
    
    

    return view;
}



-(IBAction)button_like:(id)sender{
    [cell.likeLabel setText:[NSString stringWithFormat:@"%d",[cell.likeLabel.text integerValue]+1]];
    [self.carousel reloadData];
}
- (IBAction)btn_Share:(id)sender {
    [self.carousel reloadData];
}
-(NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel{
    return 2;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    return nil;
}

-(void)carouselDidEndDecelerating:(iCarousel *)carousel{
    NSString *itemBeforeIndex=[carousel.indexesForVisibleItems objectAtIndex:0];
    NSString *itemAfterIndex=[carousel.indexesForVisibleItems objectAtIndex:3];
    
    if ( itemBeforeIndex != nil && [itemBeforeIndex integerValue] < 0) {
        [self recipesSearch:self.recipeType materialNames:nil];
    }
    
    if ( itemAfterIndex != nil && [itemAfterIndex integerValue] > [self.array_Items count]-1) {
        [self recipesSearch:self.recipeType materialNames:nil];

    }
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSString *recipeId=[[self.array_Items objectAtIndex:index]objectForKey:@"id"];
    procedureWithMPFlipViewController *pro=[[procedureWithMPFlipViewController alloc]initWithNibName:@"procedureWithMPFlipViewController" bundle:nil recipeId:recipeId];

    [self.navigationController pushViewController:pro animated:TRUE];
}
@end
