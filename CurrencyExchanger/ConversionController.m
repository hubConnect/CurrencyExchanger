//
//  ConversionController.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "ConversionController.h"
#import "AppDelegate.h"
#import "Currency.h"
#import "Transaction.h"

@interface ConversionController ()

@end

@implementation ConversionController

NSString *urlForConversion = @"http://currency-api.appspot.com/api/";
NSArray *tmpListOfCurrencies;
NSMutableDictionary *transactions;
NSString *whoCalledTable = @"None";
NSString *tableUpOrDown = @"Up";
Currency *currentlySelectedFromCurrency = nil;
Currency *currentlySelectedToCurrency = nil;
CGRect lastPosition;
bool isAnimating = NO;
NSOperationQueue * asynchQueue;
Boolean transactionIsUpdating = NO;
NSString * apiKey = @"afa679ec9195d2b2a160f2eecf2d525f9b3e5d71";
UITableViewCell * previouslySelectedCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        
        [[[UIAlertView alloc] initWithTitle:@"Please enter a real number." message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil] show];
        return NO;
    }
    NSString *fromCurrency = self.FromButton.titleLabel.text;
    NSString *toCurrency = self.ToButton.titleLabel.text;
    
    if (![fromCurrency isEqualToString:@"From"] && ![toCurrency isEqualToString:@"To"]) {
        [self Convert:self];
    }
    [textField resignFirstResponder];
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return ((AppDelegate *)[UIApplication sharedApplication].delegate).listOfCurrencies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Currency *currency = [((AppDelegate *)[UIApplication sharedApplication].delegate).listOfCurrencies objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currency.abbrv;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",currency.abbrv]];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TopCell.png"]];
    } else if (indexPath.row < ((AppDelegate *)[UIApplication sharedApplication].delegate).listOfCurrencies.count - 1) {
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MiddleCell.png"]];
    } else {
        
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BottomCell.png"]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    
    if ([whoCalledTable isEqualToString:@"From"]) {
        currentlySelectedFromCurrency = [appD.listOfCurrencies objectAtIndex:indexPath.row];
        [self.FromButton setTitle:currentlySelectedFromCurrency.abbrv forState:UIControlStateNormal];
        
        [self animateFlag:@"From" withCell:[tableView cellForRowAtIndexPath:indexPath]atIndexPath:indexPath];
        
        
        
    } else if ([whoCalledTable isEqualToString:@"To"]) {
        NSLog(@"TO");
        currentlySelectedToCurrency = [appD.listOfCurrencies objectAtIndex:indexPath.row];
        [self.ToButton setTitle:currentlySelectedToCurrency.abbrv forState:UIControlStateNormal];
        
        [self animateFlag:@"To" withCell:[tableView cellForRowAtIndexPath:indexPath]atIndexPath:indexPath];
    }
    [self.tableViewOfCurrency deselectRowAtIndexPath:indexPath
                                            animated:YES];
    
    [self pushTableView:self.view.frame.size.width];
    
    [UIView animateWithDuration:1.0f animations:^{
        
            self.ConvertButtonOutlet.alpha = 1;
        
    }];
}

- (void) animateFlag:(NSString *)toTarget withCell:(UITableViewCell *) cell atIndexPath:(NSIndexPath *) indexPath
{
    
    CGRect frameForTarget;
    NSString *imageViewName = nil;
    if ([toTarget isEqualToString:@"From"]) {
        frameForTarget = self.fromImage.frame;
        imageViewName = [NSString stringWithFormat:@"%@.png",currentlySelectedFromCurrency.abbrv];
    }
    else {
        frameForTarget = self.toImage.frame;
        imageViewName = [NSString stringWithFormat:@"%@.png",currentlySelectedToCurrency.abbrv];
        NSLog(@"To in animate");
    }
    
    NSLog(@"%f %f ",frameForTarget.origin.x,frameForTarget.origin.y);
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageViewName]];
    
    
    CGRect rect = [self.tableViewOfCurrency rectForRowAtIndexPath:indexPath];
    [iv setFrame: CGRectMake((self.view.frame.size.width - self.tableViewOfCurrency.frame.size.width) + 15,rect.origin.y + 16, iv.image.size.width, iv.image.size.height)];
    
    [self.view addSubview: iv];
    
    [cell.imageView setHidden:YES];
    NSLog(@"%f %f origin",iv.frame.origin.x,iv.frame.origin.y);
    if (previouslySelectedCell)
        previouslySelectedCell.imageView.hidden = NO;
    
    
    [UIView animateWithDuration:1 animations:^{
        
        
        [iv setFrame:frameForTarget];
        
    } completion:^(BOOL finished) {
        
        if ([toTarget isEqualToString:@"From"])
            self.fromImage.image = iv.image;
        else
            self.toImage.image = iv.image;
            
        
        [iv removeFromSuperview];
    }];
    
    previouslySelectedCell = cell;
}

- (void) pushTableView:(float) XPositionToPushTo
{
    isAnimating = YES;
    
    [UIView animateWithDuration: 1 animations:^{
        float y = 0;;
        float x = self.view.frame.size.width - self.tableViewOfCurrency.frame.size.width;
        
        if ([tableUpOrDown isEqualToString:@"Up"] && self.tableViewOfCurrency.frame.origin.x != self.view.frame.size.width) {
            
            y= self.tableViewOfCurrency.frame.origin.y + (self.tableViewOfCurrency.frame.size.height / 2);
            x += self.tableViewOfCurrency.frame.size.width;
            
            tableUpOrDown = @"Down";
        } else if ([tableUpOrDown isEqualToString:@"Down"] && self.tableViewOfCurrency.frame.origin.x != self.view.frame.size.width) {
            
            y -= (self.tableViewOfCurrency.frame.size.height / 2);
            x += self.tableViewOfCurrency.frame.size.width;
            tableUpOrDown = @"Up";
            
        }
        self.tableViewOfCurrency.frame = CGRectMake(x, y, self.tableViewOfCurrency.frame.size.width, self.tableViewOfCurrency.frame.size.height);
 
        
    } completion:^(BOOL finished) {
        
        isAnimating = NO;
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview: self.tableViewOfCurrency];
}

- (void) setAnimated: (bool) animated
{
    isAnimating = animated;
}

-(void)viewWillAppear:(BOOL)animated {
    
    UIImage *bg = [UIImage imageNamed:@"newworldbg.png"];
    UIColor *background = [[UIColor alloc] initWithPatternImage:bg];
    self.view.backgroundColor = background;
}

-(void) imageToBG:(UIImage *) image
{
    CGRect rect = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    UIImage *img=[UIImage imageWithData:imageData];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:img]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *bgImage = [UIImage imageNamed:@"newworldbg.png"];
    //[self imageToBG:bgImage];
    [self imageToBG:bgImage];
    
    self.ConversionAmountOutlet.delegate = self;
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    NSMutableArray *tmp = appD.listOfCurrencies;
    
    transactions = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    asynchQueue = [[NSOperationQueue alloc] init];
    [self.containercontroller setAlpha:.4f];
    
    if (!transactions)
        transactions = [[NSMutableDictionary alloc] init];

    self.tableViewOfCurrency = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.origin.y - 100, 100, self.view.frame.size.height)
                                ];
    
    [self.tableViewOfCurrency setBackgroundColor: [UIColor clearColor]];
    
    [self.tableViewOfCurrency setAlpha:.4f];
    [self.view addSubview:self.tableViewOfCurrency];
    [self.tableViewOfCurrency setDelegate:self];
    [self.tableViewOfCurrency setDataSource:self];
    [self.view addSubview:self.tableViewOfCurrency];
}

- (NSString*)archivePath
{
    NSArray *documentDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // It's the only one
    NSString *docDir = documentDirs[0];
    
    return [docDir stringByAppendingPathComponent:@"Transactions"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTransaction:(Transaction*) transaction
{
    if (transaction){
        [transactions setObject:transaction forKey:transaction.toString];
        [NSKeyedArchiver archiveRootObject:transactions toFile:[self archivePath]];
    }
}


- (IBAction)FromButtonAction:(id)sender {
    
    
    if (!isAnimating) {
        whoCalledTable = @"From";
        [self pushTableView:self.view.frame.size.width -
          self.tableViewOfCurrency.frame.size.width];
        
        [UIView animateWithDuration:1.0f animations:^{
            if (self.ConvertButtonOutlet.alpha == 0)
                self.ConvertButtonOutlet.alpha = 1;
            else
                self.ConvertButtonOutlet.alpha = 0;
            
        }];
        
        
    }
}

- (IBAction)ToButtonAction:(id)sender {
    
    if (!isAnimating) {
        whoCalledTable = @"To";
        [self pushTableView:self.view.frame.size.width -
          self.tableViewOfCurrency.frame.size.width];
        
        [UIView animateWithDuration:1.0f animations:^{
            if (self.ConvertButtonOutlet.alpha == 0)
                self.ConvertButtonOutlet.alpha = 1;
            else
                self.ConvertButtonOutlet.alpha = 0;
        }];
    }
}

- (IBAction)Convert:(id)sender {
    
    NSString *fromCurrency = self.FromButton.titleLabel.text;
    NSString *toCurrency = self.ToButton.titleLabel.text;
    
    if ([self.ConversionAmountOutlet isFirstResponder])
        [self.ConversionAmountOutlet resignFirstResponder];
    
   if ([fromCurrency isEqualToString:@"From"] || [toCurrency isEqualToString:@"To"]) {
       
        [[[UIAlertView alloc] initWithTitle:@"Please enter both currencies." message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil] show];
   } else if ([fromCurrency isEqualToString:toCurrency]) {
   
       AppDelegate *appd = [UIApplication sharedApplication].delegate;
       appd.uivc.ExchangedValue.text = [NSString stringWithFormat:@"%@.00000",self.ConversionAmountOutlet.text ];
       appd.uivc.ExchangeRate.text = @"1.00000";
   } else {
    
       NSString *checkString = [NSString stringWithFormat: @"from=%@to=%@",fromCurrency,toCurrency];
       Transaction *trans = [transactions objectForKey:checkString];
    
       if (!trans)
           [self updateTransaction];
       else
           [self setTransaction:trans];
   }
}

- (void) updateTransaction
{
    if (!transactionIsUpdating) {
        
        transactionIsUpdating = YES;
        NSString *fromCurrency = self.FromButton.titleLabel.text;
        NSString *toCurrency = self.ToButton.titleLabel.text;
        
        AppDelegate *appd = [UIApplication sharedApplication].delegate;
        appd.uivc.ExchangeRate.text = @"Loading...";
        
        NSString *urlToQuery = [[NSString alloc] initWithFormat:@"%@%@/%@.json?key=%@",urlForConversion,fromCurrency,toCurrency,apiKey ];
        [asynchQueue addOperationWithBlock:^{
            
            NSURL * url = [[NSURL alloc] initWithString:urlToQuery];
            NSURLResponse *response = nil;
            NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
            
            if (data) {
                NSString *tempstr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *json = [self downloadJSON:data];
                if (json) {
                    
                    if ([[json objectForKey:@"success"]boolValue] == YES) {
                        
                        Transaction *newTrans = [[Transaction alloc] init];
                        newTrans.fromCurrency = [json objectForKey:@"source"];
                        newTrans.toCurrency = [json objectForKey:@"target"];
                        NSString * exchangerate = [json objectForKey:@"rate"];
                        NSLog(@"%@",exchangerate);
                        float exchangeRate = [exchangerate floatValue];
                        newTrans.exchangeRate = exchangeRate;
                        [self addTransaction:newTrans];
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [self setTransaction:newTrans];
                            
                        }];
                    } else {
                        NSLog(@"FAIL");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            [appd.uivc.ExchangeRate setText:@"Cannot convert."];
                            [appd.uivc.ExchangedValue setText:@"Clank."];
                            
                        }];
                    }
                    
                }
            }
            transactionIsUpdating = NO;
            
        }];
    }
}

- (void) setTransaction: (Transaction *) trans
{
    AppDelegate *appd = [UIApplication sharedApplication].delegate;
    
    appd.uivc.ExchangeRate.text = [NSString stringWithFormat:@"%f",trans.exchangeRate];
    float exchanged =  [self.ConversionAmountOutlet.text floatValue] * trans.exchangeRate;
    appd.uivc.ExchangedValue.text = [NSString stringWithFormat:@"%f",exchanged];
    
}

- (NSDictionary *)downloadJSON:(NSData *) data
{
    NSError *error;
    NSMutableDictionary *allCourses = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    
    NSArray * array = [allCourses allKeys];
    
    for (NSString *key in array) {
        NSLog(@"%@   %@",key,[allCourses objectForKey:key]);
    }
    
    return allCourses;
}

@end
