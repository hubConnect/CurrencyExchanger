//
//  Transaction.h
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/19/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface Transaction : NSObject
<NSCoding>

@property (strong,nonatomic) String fromCurrency;
@property (strong,nonatomic) NSString *toCurrency;
@property float exchangeRate;

-(NSString *) toString;
@end
