//
//  Currency.h
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/16/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (strong, nonatomic) NSString *abbrv;
@property (strong, nonatomic) NSString * name;


-(id)initWithAbbrv:(NSString *)abbrv andName:(NSString *)name;
@end
