//
//  EncyclopediaEntry.m
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//

#import "EncyclopediaEntry.h"

@interface EncyclopediaEntry ()

@end

@implementation EncyclopediaEntry

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set labels upon entering an encyclopedia entry
    self.titleLabel.text = [self titleString];
    self.majorAxisLabel.text = [NSString stringWithFormat:@"Semi-major Axis: %@", [self majorAxisString]];
    self.radiusLabel.text = [NSString stringWithFormat:@"Equatorial Radius: %@", [self radiusString]];
    self.gravityLabel.text = [NSString stringWithFormat:@"Surface Gravity: %@", [self gravityString]];
    self.atmosphereLabel.text = [NSString stringWithFormat:@"Has Atmosphere: %@", [self atmosphereString]];
    self.oxygenLabel.text = [NSString stringWithFormat:@"Has Oxygen: %@", [self oxygenString]];
    
    //set image
    NSString *imageName = [self img];
    self.planetImage.image = [UIImage imageNamed:imageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
