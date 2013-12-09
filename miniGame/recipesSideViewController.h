//
//  recipesSideViewController.h
//  miniGame
//
//  Created by BirdChiu on 13/9/20.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "WebJsonDataGetter.h"

@interface recipesSideViewController : UITableViewController<WebJsonDataGetFinishDelegater>{
    WebJsonDataGetter *webGetter;
}

@property (strong,nonatomic)NSDictionary *dictionary_RecipesMenu;
@property(strong,nonatomic)NSMutableArray *array_RecipesMenu;


@end
