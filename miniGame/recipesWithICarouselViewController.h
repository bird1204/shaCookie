//
//  recipesWithICarouselViewController.h
//  miniGame
//
//  Created by BirdChiu on 13/9/15.
//
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "WebJsonDataGetter.h"
#import "CVCell.h"


@interface recipesWithICarouselViewController : UIViewController<WebJsonDataGetFinishDelegater,iCarouselDataSource, iCarouselDelegate>{
    WebJsonDataGetter *webGetter;
    CVCell *cell;
    IBOutlet iCarousel *carousel;
}
-(void)recipesSearch:(NSString*)recipeType materialNames:(NSMutableArray *)materialNames;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSArray *array_Items;
@property (nonatomic,strong) NSString* recipeType;

@end
