//
//  RecipeInfo.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/27.
//
//
#import "RecipeInfo.h"
#import <CoreLocation/CoreLocation.h>
#import "JSONKit.h"
@interface RecipeInfo ()

@end

@implementation RecipeInfo
-(id)init{
    self=[super init];
    if (self) {
        
        NSString *url_String_Loc=[NSString stringWithFormat:@"http://54.244.225.229/shacookie/jsondevicelocation.php"];
        NSURL *url_Loc=[NSURL URLWithString:url_String_Loc];
        asiRequest_Loc=[ASIHTTPRequest requestWithURL:url_Loc];
        [asiRequest_Loc setDelegate:self];
        [asiRequest_Loc startAsynchronous];
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSString *jsonStr=[[NSString alloc]initWithData:request.responseData encoding:NSUTF8StringEncoding];
    
    
    self.dictionary_nmlData=[jsonStr objectFromJSONString];
    [self.delegate doThingAfterRecipeInfoIsOkFromDelegate];
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Fail");
}

#pragma mark - 自創方法
-(id)initWithURLString:(NSString*)str_url{
    if (self=[super init]) {
        NSURL *url_Loc=[NSURL URLWithString:str_url];
        asiRequest_Loc=[ASIHTTPRequest requestWithURL:url_Loc];
        [asiRequest_Loc setDelegate:self];
        [asiRequest_Loc startAsynchronous];
    }
    return self;
}

@end