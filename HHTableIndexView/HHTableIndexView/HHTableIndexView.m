//
//  HHTableIndexView.m
//  HHTableIndexView
//
//  Created by Tran Hoang Ha on 10/2/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import "HHTableIndexView.h"
#import <QuartzCore/QuartzCore.h>

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define TableIndexViewDefaultWidth    40.0f
#define TableIndexViewDefaultMargin   10.0f
#define InterLabelHeightForiPhone4     0.0f
#define InterLabelHeightForiPhone5     3.0f
#define DefaultLabelHeight            12.0f
@interface HHTableIndexView()
- (void) show;
- (void) hide;
@end

@implementation HHTableIndexView
{
    NSMutableArray *array;
}
@synthesize backgroundView;
@synthesize numberOfSections;
@synthesize currentSection;
@synthesize contentView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithTableView:(UITableView *)tableView andWithArray:(NSArray *)arrayChar
{
    self.listOfCharacter = [[NSArray alloc] initWithArray:arrayChar];
    CGRect tableFrame = [tableView frame];
    CGRect outerFrame = CGRectZero;
    
    outerFrame.origin.x = tableFrame.size.width - (TableIndexViewDefaultWidth + TableIndexViewDefaultMargin);
    outerFrame.origin.y = 10;
    outerFrame.size.width  = TableIndexViewDefaultWidth + TableIndexViewDefaultMargin;
    outerFrame.size.height = HEIGHT;

    
    CGRect indexFrame = CGRectZero;
    indexFrame.origin.x = tableFrame.size.width - (TableIndexViewDefaultWidth + TableIndexViewDefaultMargin);
    indexFrame.origin.y = tableFrame.origin.y - 20;
    indexFrame.size.width = TableIndexViewDefaultWidth;
    indexFrame.size.height = [[UIScreen mainScreen] bounds].size.height - indexFrame.origin.y;
    
    if ((self = [super initWithFrame:outerFrame])) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
        
        // Content View (Background color, Round Corners)
        indexFrame.origin.x = 20;
        
        backgroundView = [[UIView alloc] initWithFrame:indexFrame];
        backgroundView.backgroundColor = [UIColor clearColor];
        CGFloat radius = 0.5f*TableIndexViewDefaultWidth;
        backgroundView.layer.cornerRadius = radius;
        
        
        [self addSubview:backgroundView];
        
        numberOfSections = [[tableView dataSource] numberOfSectionsInTableView:tableView];
        
        CGRect contentFrame = CGRectZero;
        contentFrame.origin.x = 0;
        contentFrame.origin.y = radius;
        contentFrame.size.width = TableIndexViewDefaultWidth;
        contentFrame.size.height = indexFrame.size.height - 2*radius;
        
        contentView = [[UIView alloc] initWithFrame:contentFrame];
        contentView.backgroundColor = [UIColor clearColor];
        
        [backgroundView addSubview:contentView];
        
        
        CGFloat labelWidth = contentFrame.size.width;
        CGFloat labelHeight = DefaultLabelHeight;
        
        CGFloat interLabelHeight = (HEIGHT < 568 ? InterLabelHeightForiPhone4 : InterLabelHeightForiPhone5);
        
        CGFloat fontSize = DefaultLabelHeight;
        array = [[NSMutableArray alloc] initWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"X",@"W",@"Y",@"Z",@"#"]];
        for (NSUInteger i=0; i < array.count; i++) {
            
            CGRect labelFrame = CGRectZero;
            labelFrame.size.width  = labelWidth;
            labelFrame.size.height = labelHeight;
            labelFrame.origin.x    = 0;
            labelFrame.origin.y    = i*(labelHeight+interLabelHeight);
            
            UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
            label.text = [NSString stringWithFormat:@"%@", array[i]];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor blueColor];
            if (![arrayChar containsObject:label.text]) {
                label.textColor = [UIColor grayColor];
            } else {
                label.textColor = [UIColor blueColor];
            }
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:fontSize];
            
            [contentView addSubview:label];
        }
        
        [backgroundView setHidden:NO];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}
#pragma mark - Control Actions

- (void) didTap:(id) sender
{
    [backgroundView setHidden:NO];
}

- (void) didRelease:(id) sender
{
    [backgroundView setHidden:NO];
}

- (void) show
{
    [self didTap:nil];
}

- (void) hide
{
    [self didRelease:nil];
}

#pragma mark - UIResponder Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:contentView];
    int newSection = (HEIGHT < 568 ? (int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone4)):(int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone5)));
    if (newSection >= 0 && newSection < 26) {
        NSLog(@"newSection = %i", newSection);
        int index = 0;
        if([self.listOfCharacter containsObject:array[newSection]]) {
            index = [self.listOfCharacter indexOfObject:[array objectAtIndex:newSection]];
            NSLog(@"index: %i", index);
            [delegate tableIndexView:self didSwipeToSection:index];
        }
    }
    [backgroundView setHidden:NO];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:contentView];
    int newSection = (HEIGHT < 568 ? (int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone4)):(int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone5)));
    if (newSection >= 0 && newSection < 26) {
        NSLog(@"newSection = %i", newSection);
        int index = 0;
        if([self.listOfCharacter containsObject:array[newSection]]) {
            index = [self.listOfCharacter indexOfObject:[array objectAtIndex:newSection]];
            NSLog(@"index: %i", index);
            [delegate tableIndexView:self didSwipeToSection:index];
        }
    }
    [backgroundView setHidden:NO];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:contentView];
    int newSection = (HEIGHT < 568 ? (int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone4)):(int)(location.y/(DefaultLabelHeight+InterLabelHeightForiPhone5)));
    if (newSection >= 0 && newSection < 26) {
        NSLog(@"newSection = %i", newSection);
        int index = 0;
        if([self.listOfCharacter containsObject:array[newSection]]) {
            index = [self.listOfCharacter indexOfObject:[array objectAtIndex:newSection]];
            NSLog(@"index: %i", index);
            [delegate tableIndexView:self didSwipeToSection:index];
        }
    }
    [backgroundView setHidden:NO];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [backgroundView setHidden:NO];
}
@end
