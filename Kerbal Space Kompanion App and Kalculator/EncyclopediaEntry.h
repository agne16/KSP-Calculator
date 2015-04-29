//
//  EncyclopediaEntry.h
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//
//  This class is a detail view that updates its labels given information from a segue.
//

#import <UIKit/UIKit.h>

@interface EncyclopediaEntry : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planetImage;
@property (weak, nonatomic) IBOutlet UILabel *majorAxisLabel;
@property (weak, nonatomic) IBOutlet UILabel *radiusLabel;
@property (weak, nonatomic) IBOutlet UILabel *gravityLabel;
@property (weak, nonatomic) IBOutlet UILabel *atmosphereLabel;
@property (weak, nonatomic) IBOutlet UILabel *oxygenLabel;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *majorAxisString;
@property (strong, nonatomic) NSString *radiusString;
@property (strong, nonatomic) NSString *gravityString;
@property (strong, nonatomic) NSString *atmosphereString;
@property (strong, nonatomic) NSString *oxygenString;

@end
