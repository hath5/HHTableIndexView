//
//  MainViewController.h
//  HHTableIndexView
//
//  Created by Tran Hoang Ha on 10/2/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTableIndexView.h"

@interface MainViewController : UIViewController<HHTableIndexViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet UITableView *myTableView;
@end
