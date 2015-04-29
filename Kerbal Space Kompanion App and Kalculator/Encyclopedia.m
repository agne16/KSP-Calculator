//
//  Encyclopedia.m
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//

#import "Encyclopedia.h"
#import "EncyclopediaEntry.h"

@interface Encyclopedia (){
    NSDictionary *entryData;
    NSMutableArray *titleArray;
    NSMutableArray *subtitleArray;
    NSMutableArray *imageArray;
    NSMutableArray *axisArray;
    NSMutableArray *radiusArray;
    NSMutableArray *gravityArray;
    NSMutableArray *atmosphereArray;
    NSMutableArray *oxygenArray;
}

@end

@implementation Encyclopedia

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.encyclopediaTable.delegate = self;
    self.encyclopediaTable.dataSource = self;
    
    //find the path of EncyclopediaData.plist and load it
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"EncyclopediaData" withExtension:@"plist"];
    entryData = [NSDictionary dictionaryWithContentsOfURL:path];
    
    //read EncyclopediaData.plist and initialize the arrays
    titleArray = [entryData objectForKey:@"Entry"];
    subtitleArray = [entryData objectForKey:@"Category"];
    imageArray = [entryData objectForKey:@"Image"];
    axisArray = [entryData objectForKey:@"Axis"];
    radiusArray = [entryData objectForKey:@"Radius"];
    gravityArray = [entryData objectForKey:@"Gravity"];
    atmosphereArray = [entryData objectForKey:@"Atmosphere"];
    oxygenArray = [entryData objectForKey:@"Oxygen"];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArray count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //find a cell to write into
    static NSString *entryCellId = @"entryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:entryCellId];
    
    //set cell titles
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UITableView *table = [self encyclopediaTable];
    NSIndexPath *indexPath = [table indexPathForSelectedRow];
    
    //initialize all local variables
    NSString *titleString = nil;
    NSString *imageString = nil;
    NSString *axisString = nil;
    NSString *radiusString = nil;
    NSString *gravityString = nil;
    NSString *atmosphereString = nil;
    NSString *oxygenString = nil;

    
    //find the data from each variable's respective array
    titleString = [titleArray objectAtIndex:indexPath.row];
    imageString = [imageArray objectAtIndex:indexPath.row];
    axisString = [axisArray objectAtIndex:indexPath.row];
    radiusString = [radiusArray objectAtIndex:indexPath.row];
    gravityString = [gravityArray objectAtIndex:indexPath.row];
    atmosphereString = [atmosphereArray objectAtIndex:indexPath.row];
    oxygenString = [oxygenArray objectAtIndex:indexPath.row];
    
    //use the segue to pass the data to the view controller
    [[segue destinationViewController] setTitleString:titleString];
    [[segue destinationViewController] setImg:imageString];
    [[segue destinationViewController] setMajorAxisString:axisString];
    [[segue destinationViewController] setRadiusString:radiusString];
    [[segue destinationViewController] setGravityString:gravityString];
    [[segue destinationViewController] setAtmosphereString:atmosphereString];
    [[segue destinationViewController] setOxygenString:oxygenString];
}

@end
