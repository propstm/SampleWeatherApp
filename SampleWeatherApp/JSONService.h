//
//  JSONService.h
//  WebServiceSample
//
//  Created by Matthew Propst on 9/17/12.
//  Copyright (c) 2012 Matthew Propst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentConditions.h"
#import "ForcastObject.h"

@protocol WebServiceDelegate;
@interface JSONService : NSObject<NSURLConnectionDelegate> {
	BOOL cancel;
}

@property (nonatomic, assign) id<WebServiceDelegate> delegate;
@property (strong) CurrentConditions *currentConditions;
@property (strong) NSMutableArray *weatherForcast;

- (id)initWithDelegate:(id<WebServiceDelegate>)aDelegate;
- (void)start;
- (void)cancel;
- (void)processData:(NSData *)data;
- (void)notifyDelegateOfError:(NSError *)error;
- (void)notifyDelegateOfCompletion;

@end

@protocol WebServiceDelegate <NSObject>
@optional

- (void)webService:(JSONService *)webService didFailWithError:(NSError *)error;
- (void)webServiceDidComplete:(JSONService *)webService;

@end
