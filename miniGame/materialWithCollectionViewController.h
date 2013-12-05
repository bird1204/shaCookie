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
    UIImageView *image_Check;
    
}
-(void)materialSearch:(NSString*)recipeType;
- (IBAction)backpage_Material:(id)sender;
- (IBAction)random:(id)sender;

- (IBAction)userMaterial_Botton:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collection_Material;
@property(strong,nonatomic)NSArray * array_Collection;
@property (strong, nonatomic) IBOutlet UIImageView *image_Background;
@property(strong,nonatomic)NSArray * array_MaterialName;

@end
