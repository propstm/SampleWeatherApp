//
//  ViewController.h
//  SampleWeatherApp
//
//  Created by Matthew Propst on 9/10/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONService.h"
#import "CurrentConditions.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, WebServiceDelegate>{
    UITableView *tableView;
}
@property (strong) IBOutlet UITableView *tableView;
@property (strong) NSString *locationCityState;
@property (strong) NSString *locationCountry;
@property (strong) id<WebServiceDelegate> delegate;
@property (strong) JSONService *webService;
@property (strong) NSMutableArray *weatherResults;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)webService:(JSONService *)webService didFailWithError:(NSError *)error;
- (void)webServiceDidComplete:(JSONService *)webService;
//- (CurrentConditions *)createCurrentConditions:(NSDictionary*)dictionary;

@end
