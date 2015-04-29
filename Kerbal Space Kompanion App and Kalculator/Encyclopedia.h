//
//  Encyclopedia.h
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//
//  This class is a view that contains one table view.
//  This represents the main page of the encyclopedia where a user may
//    select an entry to view.
//

#import <UIKit/UIKit.h>

@interface Encyclopedia : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *encyclopediaTable;

@end
