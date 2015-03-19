//
//  AppDelegate.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/16/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "AppDelegate.h"
#import "Currency.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (!self.listOfCurrencies) {
        self.listOfCurrencies = [[NSMutableArray alloc] init];
    }
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"AUD" andName:@"Australian Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"CAD" andName:@"Canadian Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"CHF" andName:@"Swiss Frank"]];
    
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"DKK" andName:@"Danish Krone"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"EUR" andName:@"Euro"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"GBP" andName:@"Pound Sterling"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"HKD" andName:@"Hong Kong Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"JPY" andName:@"Japanese Yen"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"MXN" andName:@"Mexican Peso"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"NZD" andName:@"New Zealand Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"PHP" andName:@"Philippine Peso"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"SEK" andName:@"Swedish Krona"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"SGD" andName:@"Singapore Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"THB" andName:@"Thailand Baht"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"USD" andName:@"US Dollar"]];
    [self.listOfCurrencies addObject:[[Currency alloc] initWithAbbrv:@"ZAR" andName:@"South African Rand"]];


    NSLog(@"List of curr %d",self.listOfCurrencies.count);
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
