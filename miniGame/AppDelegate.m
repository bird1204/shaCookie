//
//  AppDelegate.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/27.
//
//
#import "MFSideMenu.h"
#import "AppDelegate.h"
#import "profileSideMenuViewController.h"
#import "refViewController.h"
#import "menuViewController.h"
#import "ViewController.h"
#import "loginWithFBViewController.h"
#import "recipesWithICarouselViewController.h"
#import "materialSideViewController.h"
#import "recipesSideViewController.h"
#import "entryViewController.h"
#import "materialWithCollectionViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    

    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:[self refrigeratorView],[self recipesView],
                                          [self friendsView],nil]];
    
    tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"under.png"];
    
    self.window.rootViewController = tabBarController;
//
//    procedureWithLeavesView *produce=[[procedureWithLeavesView alloc]init];
//    self.window.rootViewController=produce;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [FBAppEvents activateApp];
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.session close];
}

// FBSample logic
// The native facebook application transitions back to an authenticating application when the user
// chooses to either log in, or cancel. The url passed to this method contains the token in the
// case of a successful login. By passing the url to the handleOpenURL method of FBAppCall the provided
// session object can parse the URL, and capture the token for use by the rest of the authenticating
// application; the return value of handleOpenURL indicates whether or not the URL was handled by the
// session object, and does not reflect whether or not the login was successful; the session object's
// state, as well as its arguments passed to the state completion handler indicate whether the login
// was successful; note that if the session is nil or closed when handleOpenURL is called, the expression
// will be boolean NO, meaning the URL was not handled by the authenticating application
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:self.session];
}



#pragma mark -
#pragma mark - sideView

-(MFSideMenuContainerViewController *)friendsView{
    //ViewController *newAdd=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    loginWithFBViewController *profile=[[loginWithFBViewController alloc]initWithNibName:@"loginWithFBViewController" bundle:nil];
    
    UINavigationController *profileView=[[UINavigationController alloc]initWithRootViewController:profile];
    [profileView setNavigationBarHidden:TRUE animated:TRUE];
    profileSideMenuViewController *leftSideView= [[profileSideMenuViewController alloc ]init];
    MFSideMenuContainerViewController *container=[MFSideMenuContainerViewController containerWithCenterViewController:profileView leftMenuViewController:leftSideView rightMenuViewController:nil];
    [profile setTitle:@"profile" ];
    container.tabBarItem.image=[UIImage imageNamed:@"good"];

    [container setTitle:@"profile"];
    return container;
}

-(MFSideMenuContainerViewController *)recipesView{
    recipesWithICarouselViewController *refrigerator= [[recipesWithICarouselViewController alloc ]initWithNibName:@"recipesWithICarouselViewController" bundle:nil];
    [refrigerator recipesSearch:@"2" materialNames:nil];

    UINavigationController *refrigeratorView=[[UINavigationController alloc]initWithRootViewController:refrigerator];
    [refrigeratorView setNavigationBarHidden:TRUE animated:TRUE];

    //loaded the "recipesWithICarouselViewController" nib but the view outlet was not set.
    //SEE:
    // http://ios-imaxlive.blogspot.tw/2013/08/xcode-addsubview-exception-loaded-xxx.html
    recipesSideViewController *leftSideView= [[recipesSideViewController alloc ]init];
    MFSideMenuContainerViewController *container=[MFSideMenuContainerViewController containerWithCenterViewController:refrigeratorView leftMenuViewController:leftSideView rightMenuViewController:nil];
    [refrigerator setTitle:@"Recipes"];
    
    container.tabBarItem.image=[UIImage imageNamed:@"recipe"];

    [container setTitle:@"Recipes"];
    return container;
}

-(MFSideMenuContainerViewController *)refrigeratorView{
    materialWithCollectionViewController *main=[[materialWithCollectionViewController alloc]initWithNibName:@"materialWithCollectionViewController" bundle:nil];
    [main materialSearch:@"1"];
    
    UINavigationController *mainView=[[UINavigationController alloc]initWithRootViewController:main];
    [mainView setNavigationBarHidden:TRUE animated:TRUE];
    materialSideViewController *leftSideView= [[materialSideViewController alloc ]init];
    MFSideMenuContainerViewController *container=[MFSideMenuContainerViewController containerWithCenterViewController:mainView leftMenuViewController:leftSideView rightMenuViewController:nil];
    [main setTitle:@"refrigerator"];
    container.tabBarItem.image=[UIImage imageNamed:@"knife"];
    [container setTitle:@"refrigerator"];
      [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbackgound.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    return container;
}
@end
