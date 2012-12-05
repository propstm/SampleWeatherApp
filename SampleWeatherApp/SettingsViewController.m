//
//  SettingsViewController.m
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/19/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize toggleButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        //[self.navigationController.view.layer addAnimation:nil forKey:nil];
   //[self setToggleButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    [toggleButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [toggleButton setImage:[UIImage imageNamed:@"F.png"] forState:UIControlStateNormal];
    [toggleButton setImage:[UIImage imageNamed:@"C.png"] forState:UIControlStateSelected];
}

- (void) viewWillAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currValue = [defaults valueForKey:@"ForC"];
    
    if([currValue isEqualToString:@"C"]){
        [toggleButton setSelected:YES];
    }else{
        [toggleButton setSelected:NO];
    }
}


- (void) onClick:(UIButton *)sender {
    NSLog(@"onclick'n");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [sender setSelected:!sender.selected];
    if([sender isSelected]){
        [defaults setValue:@"C" forKey:@"ForC"];
    }else{
        [defaults setValue:@"F" forKey:@"ForC"];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
