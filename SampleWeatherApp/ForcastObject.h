//
//  ForcastObject.h
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/19/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForcastObject : NSObject
@property (strong) NSString *date; 
@property (strong) NSString *precipMM; 
@property (strong) NSString *pressure; 
@property (strong) NSString *tempMax_C;
@property (strong) NSString *tempMax_F; 
@property (strong) NSString *tempMin_C;
@property (strong) NSString *tempMin_F; 
@property (strong) NSString *weatherCode; 
@property (strong) NSString *weatherDesc;
@property (strong) NSString *weatherIconUrl;
@property (strong) NSString *winddir16Point; 
@property (strong) NSString *winddirDegree; 
@property (strong) NSString *windspeedKmph;
@property (strong) NSString *windspeedMiles;

@end
