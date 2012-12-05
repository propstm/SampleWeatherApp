//
//  ViewController.m
//  SampleWeatherApp
//
//  Created by Matt Propst on 9/10/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//  

#import "ViewController.h"
#import "WeatherTableCell.h"
#import "CurrentConditions.h"
#import "ForcastObject.h"
#import "SettingsViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView = _tableView;
@synthesize locationCityState = _locationCityState;
@synthesize locationCountry = _locationCountry;
@synthesize delegate = _delegate;
@synthesize webService = _webService;
@synthesize weatherResults = _weatherResults;

- (void)viewDidLoad
{
[super viewDidLoad];
    self.navigationController.navigationBar.topItem.title = @"Weather Service";
    
    _webService = [[JSONService alloc] initWithDelegate:self];
    [_webService start];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults valueForKey:@"ForC"] == nil || [defaults valueForKey:@"ForC"] == NULL){
        NSString *defaultFormat = @"F";
        [defaults setValue:defaultFormat forKey:@"ForC"];
        defaultFormat = [defaults valueForKey:@"ForC"];
    }
    NSLog(@"INITIAL VALUE: %@", [defaults valueForKey:@"ForC"]);
    
    //SETUP SETTINGS VC
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsClicked)];          
    self.navigationItem.rightBarButtonItem = settingsButton;
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultFormat = [defaults valueForKey:@"ForC"];
    NSLog(@"Current Value: %@", defaultFormat);
    [_tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setTableView:nil];
    [self setLocationCityState:nil];
    [self setLocationCountry:nil];
    [self setDelegate:nil];
    [self setWebService:nil];
    [self setWeatherResults:nil];

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SampleTableCell";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *defaultFormat = [defaults valueForKey:@"ForC"];
    WeatherTableCell *cell = (WeatherTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(_weatherResults != nil){
        if(indexPath.row == 0) {
            if (cell == nil) {
                CurrentConditions *cc = (CurrentConditions *)[_weatherResults objectAtIndex:indexPath.row];
                
                NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"WeatherTableCell" owner:self options:nil];
                for (UIView *view in nibContents) {
                    if ([view isMemberOfClass:[WeatherTableCell class]]) {
                        cell = (WeatherTableCell *)view;
                        break;
                    }
                }
                // cell background
                cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"menu-cell-bg-default.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 55, 261)]];
                
                // cell title
                [[cell description] setBackgroundColor:[UIColor clearColor]];
                [[cell description] setAdjustsFontSizeToFitWidth:YES];
                
                NSString *output = [NSString stringWithFormat:@"CURRENTLY:%@ - %@F", [cc weatherDesc], [cc temp_F]];
                [[cell description] setText:output];
                NSLog(@"CC DESCRIPTION: %@", [cc weatherDesc]);
            }

        }else{
            ForcastObject *fo = (ForcastObject *)[_weatherResults objectAtIndex:indexPath.row];
            
            if (cell == nil) {
                NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"WeatherTableCell" owner:self options:nil];
                for (UIView *view in nibContents) {
                    if ([view isMemberOfClass:[WeatherTableCell class]]) {
                        cell = (WeatherTableCell *)view;
                        break;
                    }
                }
                // cell background
                cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"menu-cell-bg-default.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(7, 7, 55, 261)]];
                cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"menu-cell-bg-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(2,1,74,319)]];
                
                // cell title
                [[cell description] setBackgroundColor:[UIColor clearColor]];
                [[cell description] setAdjustsFontSizeToFitWidth:YES];
                [[cell date] setText:[NSString stringWithFormat:@"%@",[fo date]]];
                [[cell description] setText:[NSString stringWithFormat:@"%@",[fo weatherDesc]]];
                    NSLog(@"Current Value in Reloading Data: %@", defaultFormat);
                if([defaultFormat isEqualToString:@"F"]){
                    [[cell high] setText:[NSString stringWithFormat:@"HIGH: %@",[fo tempMax_F]]];
                    [[cell low] setText:[NSString stringWithFormat:@"LOW: %@",[fo tempMin_F] ]];
                }else{
                    [[cell high] setText:[NSString stringWithFormat:@"HIGH: %@",[fo tempMax_C]]];
                    [[cell low] setText:[NSString stringWithFormat:@"LOW: %@",[fo tempMin_C] ]];
                }
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[fo weatherIconUrl]]]];
                [[cell imageView] setImage:image];
                
            }

        }
        

    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!_weatherResults){
        return 0;
    }else{
        return [_weatherResults count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row > 0){
        return 70;
    }else {
        return 100;
    }
}

- (void)webService:(JSONService *)webService didFailWithError:(NSError *)error{
    NSLog(@"ERROR IN DIDFAILWITHERROR BLOCK");
     NSLog(@"ERROR: %@", error);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"Failure to return weather data"
                          message: @"Make sure you have a valid internet connection and are searching for a valid location"
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
    
}
- (void)webServiceDidComplete:(JSONService *)webService{
    if(_weatherResults == nil){
        _weatherResults = [[NSMutableArray alloc] init];
    }
    
    [_weatherResults addObject:[webService currentConditions]];
    CurrentConditions *cc = [webService currentConditions];
    NSLog(@"CURRENDESCRIPTION: %@", cc.weatherDesc);
    
    NSMutableArray *forcastArray = [webService weatherForcast];
    for(int x = 0; x< [forcastArray count]; x++){
        ForcastObject *oo = [forcastArray objectAtIndex:x];
        NSLog(@"TEMP OO MAXF: %@", [oo tempMax_F]);
        [_weatherResults addObject:[forcastArray objectAtIndex:x]];
    }
    
    ForcastObject *forObj = [_weatherResults objectAtIndex:1];
    NSLog(@"FOROBJ TEMPMAXF %@", [forObj tempMax_F]);
    [self.tableView reloadData];
}

- (void)settingsClicked{
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];


    [self.navigationController pushViewController:settingsVC animated:YES];
}


@end