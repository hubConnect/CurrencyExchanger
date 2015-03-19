//
//  AppDelegate.h
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/16/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerDetail.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray * listOfCurrencies;
@property (weak, nonatomic) ContainerDetail * uivc;

@end
