//
//  materialMenuViewController.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/19.
//
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "ASIHTTPRequest.h"
#import "WebJsonDataGetter.h"

@interface materialSideViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,WebJsonDataGetFinishDelegater>{
    ASIHTTPRequest *asiRequest;
    WebJsonDataGetter *webGetter;
}

@property (strong,nonatomic)NSDictionary *dictionary_MaterialMenu;
@property(strong,nonatomic)NSMutableArray *array_MaterialMenu;


@end
