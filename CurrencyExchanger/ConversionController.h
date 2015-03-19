//
//  ConversionController.h
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//
#import "Transaction.h"
#import <UIKit/UIKit.h>

@interface ConversionController : UIViewController
<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *ConvertButtonOutlet;
@property (weak, nonatomic) IBOutlet UITextField *ConversionAmountOutlet;

- (IBAction)Convert:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *toImage;
@property (weak, nonatomic) IBOutlet UIImageView *fromImage;
@property (strong, nonatomic) UITableView *tableViewOfCurrency;
@property (weak, nonatomic) IBOutlet UIButton *FromButton;
@property (weak, nonatomic) IBOutlet UIButton *ToButton;
- (IBAction)FromButtonAction:(id)sender;
- (IBAction)ToButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containercontroller;

-(void) addTransaction:(Transaction *) trans;
- (void) updateTransaction;
@end
