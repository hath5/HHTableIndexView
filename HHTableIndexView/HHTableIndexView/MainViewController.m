//
//  MainViewController.m
//  HHTableIndexView
//
//  Created by Tran Hoang Ha on 10/2/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    NSMutableArray *arrayCharacters;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrayCharacters = [[NSMutableArray alloc] initWithArray:@[@"A",@"B",@"D",@"E",@"G",@"J",@"K",@"L",@"N",@"O",@"P",@"Q",@"R",@"W",@"Y"]];
    HHTableIndexView *hhTableIndexView = [[HHTableIndexView alloc] initWithTableView:_myTableView andWithArray:arrayCharacters];
    hhTableIndexView.delegate = self;
    [self.view addSubview:hhTableIndexView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayCharacters.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [arrayCharacters objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"HHTableViewCell";
    return cell;
}

-(void)tableIndexView:(HHTableIndexView *)tableIndexView didSwipeToSection:(NSUInteger)section
{
    [_myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                            inSection:section]
                        atScrollPosition:UITableViewScrollPositionTop
                                animated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
