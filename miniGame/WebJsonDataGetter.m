//
//  WebJsonDataGetter.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/28.
//
//

#import "WebJsonDataGetter.h"
@implementation WebJsonDataGetter
-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}
-(void)requestWithURLString:(NSString *)url{
    webRequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [webRequest setDelegate:self];
    [webRequest startAsynchronous];
}

-(id)initWithURLString:(NSString*)url{
    self=[super init];
    if (self) {
        [self requestWithURLString:url];
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSError* error;
    self.webData= [NSJSONSerialization JSONObjectWithData:request.responseData options:kNilOptions error:&error];
    [self.delegate  doThingAfterWebJsonIsOKFromDelegate];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Failure, %@",request.error);
    
    //要教他們
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"跳我就是沒網路！！！" message:@"BeSure" delegate:nil cancelButtonTitle:@"canel" otherButtonTitles:@"one",@"two", nil];
    [alert setDelegate:self];
    [alert show];
   ;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"cancel");
            break;
        case 1:
            NSLog(@"one");
            break;
        default:
            break;
    }
}
@end
