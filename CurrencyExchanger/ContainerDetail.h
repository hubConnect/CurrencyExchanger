//
//  ContainerDetail.h
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/20/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContainerDetail : UIViewController
- (IBAction)ContainerDetailButton:(id)sender;
@property (strong,nonatomic) NSString *currentSegueIdentifier;
@property (weak, nonatomic) IBOutlet UILabel *ExchangeRate;
@property (weak, nonatomic) IBOutlet UILabel *ExchangedValue;
@end
