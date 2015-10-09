//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by David Wang on 10/7/15.
//  Copyright © 2015 David Wang. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *excellentPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *satifactoryPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *terriblePercentLabel;
@property (weak, nonatomic) IBOutlet UIStepper *excellentPercentStepper;
@property (weak, nonatomic) IBOutlet UIStepper *satisfactoryPercentStepper;
@property (weak, nonatomic) IBOutlet UIStepper *terriblePercentStepper;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger excellentRate = [self loadSettings:@"excellentRate"];
    [self.excellentPercentStepper setValue:excellentRate];
    [self.excellentPercentLabel setText:[NSString stringWithFormat:@"%d%%", (int)excellentRate]];
    
    NSInteger satisfyRate = [self loadSettings:@"satisfyRate"];
    [self.satisfactoryPercentStepper setValue:satisfyRate];
    [self.satifactoryPercentLabel setText:[NSString stringWithFormat:@"%d%%", (int)satisfyRate]];
    
    NSInteger terribleRate = [self loadSettings:@"terribleRate"];
    [self.terriblePercentStepper setValue:terribleRate];
    [self.terriblePercentLabel setText:[NSString stringWithFormat:@"%d%%", (int)terribleRate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onClickExcellentStepper:(UIStepper *)sender {
    int value = [sender value];
    
    [self.excellentPercentLabel setText:[NSString stringWithFormat:@"%d%%", value]];
    [self saveSettings:@"excellentRate" value:value];
}

- (IBAction)onClickSatisfyStepper:(UIStepper *)sender {
    int value = [sender value];
    
    [self.satifactoryPercentLabel setText:[NSString stringWithFormat:@"%d%%", value]];
    [self saveSettings:@"satisfyRate" value:value];
}

- (IBAction)onClickTerribleStepper:(UIStepper *)sender {
    int value = [sender value];
    
    [self.terriblePercentLabel setText:[NSString stringWithFormat:@"%d%%", value]];
    [self saveSettings:@"terribleRate" value:value];
}

- (void)saveSettings:(NSString *) key value: (int) rate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:rate forKey:key];
    [defaults synchronize];
}

- (NSInteger)loadSettings:(NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults integerForKey:key];
}

@end
