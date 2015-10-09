//
//  ViewController.m
//  tipCalculator
//
//  Created by David Wang on 10/6/15.
//  Copyright © 2015 David Wang. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *perPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *personNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *increasePersonNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *decreasePeopleNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *excellentPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *satisfyPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *terriblePercentLabel;

@property (strong, nonatomic) NSArray *tipValues;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tip Calculator";
    
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSInteger excellentRate = [self loadSettings:@"excellentRate"];
    NSInteger satisfyRate = [self loadSettings:@"satisfyRate"];
    NSInteger terribleRate = [self loadSettings:@"terribleRate"];
    
    if (!excellentRate) {
        excellentRate = 25;
    }
    
    if (!satisfyRate) {
        satisfyRate = 20;
    }
    
    if (!terribleRate) {
        terribleRate = 15;
    }
    
    self.tipValues = @[@(excellentRate/100.0), @(satisfyRate/100.0), @(terribleRate/100.0)];
    
    self.excellentPercentLabel.text = [NSString stringWithFormat:@"%d%%", (int)excellentRate];
    
    self.satisfyPercentLabel.text = [NSString stringWithFormat:@"%d%%", (int)satisfyRate];
    
    self.terriblePercentLabel.text = [NSString stringWithFormat:@"%d%%", (int)terribleRate];
    
    [self updateValues];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (IBAction)onTipValueChanged:(id)sender {
    [self updateValues];
}

- (IBAction)onStartEnterTip:(UITextField *)sender {
    self.billTextField.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.billTextField.alpha = 1;
    }];
}

- (void)updateValues {
    // Get bill amount
    float billAmount = [self.billTextField.text floatValue];
    
    // Compute the tip and total
    float tipAmount = [_tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    float personAmount = totalAmount / [self.personNumberLabel.text intValue];
    
    // Update the UI
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.perPersonLabel.text = [NSString stringWithFormat:@"$%0.2f", personAmount];
    
}

- (IBAction)onClickIncreasePeopleNumberButton:(UIButton *)sender {
    int people = [self.personNumberLabel.text intValue];
    people = people + 1;
    
    self.personNumberLabel.text = [NSString stringWithFormat:@"%d", people];
    [self updateValues];
}

- (IBAction)onClickDecreasePeopleNumberButton:(UIButton *)sender {
    int people = [self.personNumberLabel.text intValue];
    
    if (people > 1) {
        people = people - 1;
        self.personNumberLabel.text = [NSString stringWithFormat:@"%d", people];
        [self updateValues];
    }
}

- (NSInteger)loadSettings:(NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults integerForKey:key];
}

@end
