//
//  materialSideWithCollectionViewController.h
//  miniGame
//
//  Created by 趴特萬 on 13/9/24.
//
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"
#import "ASIHTTPRequest.h"

@interface materialWithCollectionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,WebJsonDataGetFinishDelegater,UICollectionViewDelegateFlowLayout>{
    NSMutableDictionary *dictionary_MaterialName;
    NSMutableArray *array_Material;
    WebJsonDataGetter * webGetter;
    ASIHTTPRequest *asiRequest;
    
}
-(void)materialSearch:(NSString*)recipeType;

- (IBAction)userMaterial_Botton:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collection_Material;
@property(strong,nonatomic)NSArray * array_Collection;
@property(strong,nonatomic)NSArray * array_MaterialName;

@end
