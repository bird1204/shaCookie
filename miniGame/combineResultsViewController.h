//
//  combineResultsViewController.h
//  miniGame
//
//  Created by 趴特萬 on 13/10/3.
//
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"
#import "iCarousel.h"
#import <CoreMotion/CoreMotion.h>


@interface combineResultsViewController : UIViewController<WebJsonDataGetFinishDelegater>{
    CMMotionManager *motionManager;

    WebJsonDataGetter * webGetter;
}
@property(nonatomic,strong)NSArray *getMaterial;
//@property(nonatomic,strong)NSString *stringRandom;
@property(nonatomic,strong)NSArray *arrayMaterial;
@property(nonatomic,strong)NSArray *getRecipes;
@property(nonatomic,strong)NSString *randomRecipes;


@end
