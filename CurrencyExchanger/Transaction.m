////
//  Transaction.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/19/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fromCurrency forKey:@"FromCurrency"];
    [aCoder encodeObject:self.toCurrency   forKey:@"ToCurrency"];
    [aCoder encodeFloat:self.exchangeRate forKey:@"ExchangeRate"];
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self setFromCurrency:[aDecoder decodeObjectForKey:@"FromCurrency"]];
        [self setToCurrency:[aDecoder decodeObjectForKey:@"ToCurrency"]];
        [self setExchangeRate:[aDecoder decodeFloatForKey:@"ExchangeRate"]];
    }
    return self;
}

-(NSString *)toString {
    
    NSString * transactionString = [NSString stringWithFormat:@"from=%@to=%@",self.fromCurrency,self.toCurrency];
    
    NSLog(@"%@",transactionString);
    return transactionString;
}

@end
