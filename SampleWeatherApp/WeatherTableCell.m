//
//  WeatherTableCell.m
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/11/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import "WeatherTableCell.h"

@implementation WeatherTableCell
@synthesize date = _date;
@synthesize description = _description;
@synthesize high = _high;
@synthesize low = _low;
@synthesize imageView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
