//
//  Calculator.m
//  Kerbal Space Kompanion App and Kalculator
//
//  Created by T.J. Agne and Matthew Farr on 4/13/15.
//  Copyright (c) 2015 T.J. Agne and Matthew Farr. All rights reserved.
//

#import "Calculator.h"

@interface Calculator ()
{
    NSArray *_pickerData;
    
    NSArray *planets;
    NSArray *planetRadii;
    NSArray *semiMajorAxes;
    NSArray *escapeVelocities;
    NSArray *gravitationalParameters;
    NSArray *spheresOfInfluence;
    
    int firstSelection;
    int secondSelection;
}

@end

@implementation Calculator

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Find plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Planets" ofType:@"plist"];
    
    //Load file content and read data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    planets = [dict objectForKey:@"planetNames"];
    planetRadii = [dict objectForKey:@"planetRadii"];
    semiMajorAxes = [dict objectForKey:@"semiMajorAxes"];
    gravitationalParameters = [dict objectForKey:@"gravitationalParameters"];
    spheresOfInfluence = [dict objectForKey:@"spheresOfInfluence"];
    
    // Initialize Data
    _pickerData = planets;
    
    // Connect data
    self.planetPicker.dataSource = self;
    self.planetPicker.delegate = self;
    
    // Connect data
    self.planetPicker2.dataSource = self;
    self.planetPicker2.delegate = self;
    
    firstSelection = 0;
    secondSelection = 0;
    
    self.phaseAngleLabel.text = @"Choose two planets";
    self.ejectionAngleLabel.text = @"Enter a parking orbit height";
    self.ejectionDeltaVLabel.text = @"And press calculate!";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 0)
    {
        firstSelection = (int) row;
    }
    else if (pickerView.tag == 1)
    {
        secondSelection = (int) row;
    }
}

- (IBAction)calculate:(id)sender
{
    if(firstSelection == secondSelection)
    {
        self.phaseAngleLabel.text = [NSString stringWithFormat:@"Choose two DIFFERENT planets"];
        self.ejectionAngleLabel.text = [NSString stringWithFormat:@"Enter a parking orbit height"];
        self.ejectionDeltaVLabel.text = [NSString stringWithFormat:@"And press calculate!"];
        
        return;
    }
    


    if(1000.0 *[self.parkingOrbitField.text doubleValue] <= 0)
    {
        self.phaseAngleLabel.text = [NSString stringWithFormat:@"Please enter a parking orbit which is not"];
        self.ejectionAngleLabel.text = [NSString stringWithFormat:@"inside the origin planet"];
        self.ejectionDeltaVLabel.text = [NSString stringWithFormat:@""];
        
        return;
    }
    
    /*Calculate phase angle for Hohmann transfer between two two planets
    The equation used in this calculation is Kepler's Third Law of Planetary Motion
    which can be stated as 180(1-((r1+r2)/2r2)^1.5)
    where r1 is the semi-major axis of the origin planet
    and r2 is the semi-major axis of the destination planet*/
    double r1 = [[semiMajorAxes objectAtIndex:firstSelection] doubleValue];
    double r2 = [[semiMajorAxes objectAtIndex:secondSelection] doubleValue];
    
    double axesSum = r1 + r2;
    double doubleR2 = 2.0 * r2;
    double baseTerm = axesSum / doubleR2;
    double exponent = pow(baseTerm, 1.5);
    double phase = 180.0 * (1 - exponent);
    
    while (phase <= -360){
        phase += 360;
    }
    
    /*Calculate change in velocity needed for transfer between two planets
    The equation used in this calculation is
    ΔV = √(μ/r1) * (√( 2r2 / (r1+r2)) - 1)
    where r1 is the semi-major axis of the origin planet
    r2 is the semi-major axis of the destination planet
    and μ is the standard gravitation parameter of the central body (the sun)*/
    
    double μSun = [[gravitationalParameters objectAtIndex:[gravitationalParameters count]-1] doubleValue];
    double outerSquare = sqrt(μSun/r1);
    double innerSquare = sqrt(doubleR2/axesSum);
    double deltaV = outerSquare * (innerSquare - 1.0);
    
    /*Calculate the velocity needed at parking orbit to exit origin planet sphere of influence at
    the correct velocity. This is an intermediate step for finding the ejection angle.
    The equation used for this is
    v1 = √((p*(s*v2^2-2*μ)+2*s*μ)/(p*s))
    Where v1 is the velocity we are trying to find
    v2 is the deltaV we just calculated
    p is the height of the parking orbit from the center of the origin planet
    s is the height of the origin planet's sphere of influence from its center
    and μ is the standard gravitation parameter of the origin planet*/
    
    double park = 1000.0 *[self.parkingOrbitField.text doubleValue] + [[planetRadii objectAtIndex:firstSelection] doubleValue];
    double soi = [[spheresOfInfluence objectAtIndex:firstSelection] doubleValue];
    double μOrigin = [[gravitationalParameters objectAtIndex:firstSelection] doubleValue];
    double ejectionV = sqrt(((park * (soi * pow(deltaV,2.0) - 2.0 * μOrigin ))+ 2*soi*μOrigin)/(park*soi));
    
    //Calculate ejection angle for transfer between two planets
    double epsilon = ( pow(ejectionV, 2) / 2) - μOrigin / park;
    
    double h = park * ejectionV;
    
    double e = sqrt(1 + (2 * epsilon * pow(h, 2))/pow(μOrigin, 2));
    
    double theta = acos(1/e);
    if (isnan(theta))
    {
        theta = 0;
    }
    
    double ejectionAngle = 180.0 - theta * 180.0 / M_PI;
    
    self.phaseAngleLabel.text = [NSString stringWithFormat:@"Phase Angle: %.02f°", phase];
    self.ejectionAngleLabel.text = [NSString stringWithFormat:@"Ejection Angle: %.02f°", ejectionAngle];
    self.ejectionDeltaVLabel.text = [NSString stringWithFormat:@"Ejection Δv: %.02f m/s", deltaV];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
