//
//  HHTableIndexView.h
//  HHTableIndexView
//
//  Created by Tran Hoang Ha on 10/2/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHTableIndexView;

@protocol HHTableIndexViewDelegate <NSObject>
- (void) tableIndexView:(HHTableIndexView *)tableIndexView
      didSwipeToSection:(NSUInteger) section;
@end

@interface HHTableIndexView : UIView{
    
}
@property (nonatomic, assign) id<HHTableIndexViewDelegate> delegate;
@property (nonatomic) NSUInteger numberOfSections;
@property (nonatomic) NSUInteger currentSection;
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) NSArray *listOfCharacter;
- (id) initWithTableView:(UITableView*)tableView andWithArray:(NSArray *)arrayChar;
@end