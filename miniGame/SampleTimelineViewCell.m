//
//  Copyright (c) 2013 Luke Scott
//  https://github.com/lukescott/TimelineView
//  Distributed under MIT license
//

#import "SampleTimelineViewCell.h"

@interface SampleTimelineViewCell ()

@end

@implementation SampleTimelineViewCell
@synthesize color = _color;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self) {

    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    
    if(! self.selected) {
        NSLog(@"setColor");
        //self.backgroundColor = color;
    }
}

- (void)prepareForReuse
{
    // Always call super
    [super prepareForReuse];
    
    _color = nil;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if(highlighted) {
        self.alpha = 0.5f;
    }
    else {
        self.alpha = 1.f;
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if(selected) {
        NSLog(@"select cell : %@",self.recipeName);
    }
    else {
        NSLog(@"deselect cell");
    }
}


@end
