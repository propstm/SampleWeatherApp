//
//  CurrentConditions.h
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/19/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//


/*
 SAMPLE OUTPUT
 "current_condition": [ {
 "cloudcover": "0", 
 "humidity": "26", 
 "observation_time": "10:08 PM", 
 "precipMM": "0.0", 
 "pressure": "1018", 
 "temp_C": "19", 
 "temp_F": "67", 
 "visibility": "16", 
 "weatherCode": "113",  
 "weatherDesc": [ {"value": "Sunny" } ], 
 "weatherIconUrl": [ {
 "value": "http:\/\/www.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0001_sunny.png" } ], 
 "winddir16Point": "S", 
 "winddirDegree": "180", 
 "windspeedKmph": "13", 
 "windspeedMiles": "8" 
 } ],
 //MORE BELOW FOR FORECAST
 */

#import <Foundation/Foundation.h>

@interface CurrentConditions : NSObject
@property (strong) NSString *cloudcover; 
@property (strong) NSString *humidity; 
@property (strong) NSString *observation_time; 
@property (strong) NSString *precipMM; 
@property (strong) NSString *pressure; 
@property (strong) NSString *temp_C; 
@property (strong) NSString *temp_F; 
@property (strong) NSString *visibility; 
@property (strong) NSString *weatherCode; 
@property (strong) NSString *weatherDesc;
@property (strong) NSString *weatherIconUrl;
@property (strong) NSString *winddir16Point; 
@property (strong) NSString *winddirDegree; 
@property (strong) NSString *windspeedKmph;
@property (strong) NSString *windspeedMiles;
@end
