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


@interface combineResultsViewController : UIViewController<WebJsonDataGetFinishDelegater,UIAlertViewDelegate>{
    CMMotionManager *motionManager;
    WebJsonDataGetter * webGetter;
    UIAlertView *notiMessage;
}
@property(nonatomic,strong)NSArray *getMaterial;
@property(nonatomic,strong)NSArray *arrayMaterial;
@property(nonatomic,strong)NSArray *getRecipes;


@end
