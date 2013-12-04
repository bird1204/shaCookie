//
//  Person.m
//  miniGame
//
//  Created by 趴特萬 on 13/3/28.
//
//

#import "Person.h"
#import "GetJsonURLString.h"
@implementation Person
-(id)init{
    self=[super init];
    if (self) {
        dataGetter=[[WebJsonDataGetter alloc] initWithURLString:GetJsonURLString_Device];
        [dataGetter setDelegate:self];
    }
    return self;
    
}
-(void)doThingAfterWebJsonIsOKFromDelegate{
    NSArray *array=(NSArray*)dataGetter.webData;
    self.coord=CLLocationCoordinate2DMake([[[array objectAtIndex:0] objectForKey:@"latitude"] doubleValue], [[[array objectAtIndex:0] objectForKey:@"longtitude"] doubleValue]);
    //NSLog(@"do %f %f",self.coord.latitude,self.coord.longitude);
    [self.delegate doThingAfterWebPersonLoadLocationIsOKFromDelegate];
}
@end
