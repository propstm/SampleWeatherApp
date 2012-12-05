//
//  JSONService.m
//  WebServiceSample
//
//  Created by Matthew Propst on 9/17/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import "JSONService.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kWeatherURL [NSURL URLWithString: @"http://free.worldweatheronline.com/feed/weather.ashx?q=Detroit%2c+Michigan,United+States&format=json&num_of_days=5&key=427c2e262b014042121109"]

@implementation JSONService
@synthesize delegate;
@synthesize currentConditions;// = _currentConditions;
@synthesize weatherForcast;// = _weatherForcast;

- (void)start{
    dispatch_async(kBgQueue, ^{
        NSError *error = nil;
        NSData* data = [NSData dataWithContentsOfURL:kWeatherURL options:NSDataReadingUncached error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            [self notifyDelegateOfError:error];
            
        } else {
            NSLog(@"Data has loaded successfully.");
        }
        
        [self performSelectorOnMainThread:@selector(processData:) withObject:data waitUntilDone:YES];
    });
}
- (void)cancel{
    //TODO KILL THE SERVICE (GRACEFULLY!!!!!) -- ALLOW VC'S TO CANCEL THE SERVICE & PREVENT SEGFAULTS
    
}

- (id)initWithDelegate:(id<WebServiceDelegate>)aDelegate
{
    self = [super init];
    if (self) {
        [self setDelegate:aDelegate];
    }
    return self;
}

- (void)processData:(NSData *)data{
    
    //parse out the json data
    NSError* error;
    if(data == nil){
        error = [NSError errorWithDomain:@"NO_DOMAIN" code:001 userInfo:nil];
        [self notifyDelegateOfError:error];
        return;
    }
    //EITHER NSDictionary = json or NSMutableArray = json
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data 
                                                    options:kNilOptions
                                                      error:&error];
    NSArray *dataArray = [[json objectForKey:@"data"] objectForKey:@"current_condition"];
    NSDictionary *ccDataDict = [dataArray objectAtIndex:0]; 
    currentConditions = [self createCurrentConditions:ccDataDict];
    
    NSArray *weatherArray = [[json objectForKey:@"data"] objectForKey:@"weather"];
    if(weatherForcast == nil){
        weatherForcast = [[NSMutableArray alloc] init];
    }
    for(int i=0; i<[weatherArray count]; i++){
        NSDictionary *weatherDataDict = [weatherArray objectAtIndex:i]; 
        ForcastObject *forcastObj = [self createForcastObject:weatherDataDict];
        NSLog(@"ALL FORCAST OBJ: %@", forcastObj.tempMax_F);
        [weatherForcast addObject:forcastObj];        
    }

    //NO ERRORS ALL DONE!
    [self notifyDelegateOfCompletion];
        
}

#pragma mark - CREATE WEATHER OBJECTS
- (CurrentConditions *)createCurrentConditions:(NSDictionary*)data{
    CurrentConditions *cc = [[CurrentConditions alloc]init];
    
    cc.cloudcover       = [data objectForKey: @"cloudcover"];
    cc.humidity         = [data objectForKey: @"humidity"];
    cc.precipMM         = [data objectForKey: @"precipMM"];
    cc.pressure         = [data objectForKey: @"pressure"];
    cc.temp_C           = [data objectForKey: @"temp_C"];
    cc.temp_F           = [data objectForKey: @"temp_F" ];
    cc.visibility       = [data objectForKey: @"visibility"];
    cc.weatherCode      = [data objectForKey: @"weatherCode"];
    
    NSArray *tempDescArray = [data objectForKey:@"weatherDesc"];
    NSDictionary *tempDescDict = [tempDescArray objectAtIndex:0];
    
    cc.weatherDesc      = [tempDescDict objectForKey:@"value"];
    
    
    NSArray *tempIconUrlArray = [data objectForKey:@"weatherIconUrl"];
    NSDictionary *tempIconUrlDict = [tempIconUrlArray objectAtIndex:0];
    
    cc.weatherIconUrl   = [tempIconUrlDict objectForKey: @"value"];
    cc.winddir16Point   = [data objectForKey: @"winddir16Point"];
    cc.winddirDegree    = [data objectForKey: @"winddirDegree"];
    cc.windspeedKmph    = [data objectForKey: @"windspeedKmph"];
    cc.windspeedMiles   = [data objectForKey: @"windspeedMiles"];
    
    return cc;
}


- (ForcastObject*)createForcastObject:(NSDictionary*)data{
    ForcastObject *fo = [[ForcastObject alloc] init];
    
    fo.date             = [data objectForKey:@"date"];

    fo.precipMM         = [data objectForKey: @"precipMM"];
    fo.pressure         = [data objectForKey: @"pressure"];
    fo.tempMax_C        = [data objectForKey: @"tempMaxC"];
    fo.tempMax_F        = [data objectForKey: @"tempMaxF" ];
    NSLog(@"fo description: %@", fo.description);
    fo.tempMin_C        = [data objectForKey: @"tempMinC"];
    fo.tempMin_F        = [data objectForKey: @"tempMinF" ];
    fo.weatherCode      = [data objectForKey: @"weatherCode"];
    
    NSArray *tempDescArray = [data objectForKey:@"weatherDesc"];
    NSDictionary *tempDescDict = [tempDescArray objectAtIndex:0];
    
    fo.weatherDesc      = [tempDescDict objectForKey:@"value"];
    
    NSArray *tempIconUrlArray = [data objectForKey:@"weatherIconUrl"];
    NSDictionary *tempIconUrlDict = [tempIconUrlArray objectAtIndex:0];
    
    fo.weatherIconUrl   = [tempIconUrlDict objectForKey: @"value"];
    fo.winddir16Point   = [data objectForKey: @"winddir16Point"];
    fo.winddirDegree    = [data objectForKey: @"winddirDegree"];
    fo.windspeedKmph    = [data objectForKey: @"windspeedKmph"];
    fo.windspeedMiles   = [data objectForKey: @"windspeedMiles"];
    
    return fo;
}

- (void)notifyDelegateOfError:(NSError *)error{
    [delegate webService:self didFailWithError: error];
}


- (void)notifyDelegateOfCompletion
{	
	if ([delegate respondsToSelector:@selector(webServiceDidComplete:)]) {
        ForcastObject *fo = [weatherForcast objectAtIndex:0];
        NSLog(@"FO: %@",fo);
        NSLog(@"FIRST DAY MAX TEMP: %@", fo.tempMax_F);
        [self setWeatherForcast:weatherForcast];
        [delegate webServiceDidComplete:self];
	}
}

@end
