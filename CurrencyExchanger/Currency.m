//
//  Currency.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/16/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "Currency.h"

@implementation Currency


- (id) initWithAbbrv: (NSString *) abbrv andName: (NSString *) name {
    
    if (self = [super init]) {
        
        self.abbrv = abbrv;
        self.name = name;
    }
        
    
    return self;
}

@end
