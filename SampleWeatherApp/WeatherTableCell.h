//
//  WeatherTableCell.h
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/11/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableCell : UITableViewCell{    
//    IBOutlet UIImageView *imageView;
//    IBOutlet UILabel *high;
//    IBOutlet UILabel *low;
}

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (strong) IBOutlet UILabel *date;
@property (strong) IBOutlet UILabel *description;
@property (strong) IBOutlet UILabel *high;
@property (strong) IBOutlet UILabel *low;


@end
