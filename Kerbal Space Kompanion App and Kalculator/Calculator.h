//
//  Calculator.h
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//
//  This class is the calculator portion of the app.
//  It defines methods to accept input from users and
//    performs calculations using those inputs.
//
//
//  This class defines a view that contains the following:
//     two picker views to select two different planets
//     a numeric text field to receive user input
//     a calculate button that updates labels
//
//

#import <UIKit/UIKit.h>

@interface Calculator : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *planetPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *planetPicker2;
@property (weak, nonatomic) IBOutlet UILabel *phaseAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ejectionAngleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ejectionDeltaVLabel;
@property (weak, nonatomic) IBOutlet UITextField *parkingOrbitField;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end
