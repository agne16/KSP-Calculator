//
//  ViewController.m
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSMutableArray *titleArray;
    NSMutableArray *subtitleArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    titleArray = [[NSMutableArray alloc]initWithObjects:@"Calculator", @"Encyclopedia", nil];
    subtitleArray = [[NSMutableArray alloc]initWithObjects:@"Calculate ideal trajectories for the game", @"Read up about the metagame", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *mainCellId = nil;
    
    if (indexPath.row == 0){
        mainCellId = @"calculatorCell";
    }
    else if (indexPath.row == 1){
        mainCellId = @"encyclopediaCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
