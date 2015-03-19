//
//  ViewController.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/16/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "ViewController.h"
#import "Currency.h"

@interface ViewController ()

@property NSData *dataStuff;

@end

@implementation ViewController

NSMutableString *dataString;
NSOperationQueue *dasQueue;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    dataString = [[NSMutableString alloc] init];
    
    dasQueue = [[NSOperationQueue alloc] init];
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:
                              [NSURL URLWithString:@"http://www.google.com/finance/converter"]];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    // Designate the request a POST request and specify its body data
    [request setHTTPMethod:@"POST"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:dasQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
 
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            self.dataStuff = [string dataUsingEncoding:NSUTF8StringEncoding];
            
        }];
        
        
        
    }];
    
    
    
    
}

-(void)parser:(NSXMLParser *)parser foundInternalEntityDeclarationWithName:(NSString *)name value:(NSString *)value
{
    NSLog(@"Internal ");
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"ERROR %@",parseError.description);
    
}

- (void)parser:(NSXMLParser *)parser foundElementDeclarationWithName:(NSString *)elementName model:(NSString *)model
{
    NSLog(@"Name - %@",elementName);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)parser:(NSXMLParser *)parser foundAttributeDeclarationWithName:(NSString *)attributeName forElement:(NSString *)elementName type:(NSString *)type defaultValue:(NSString *)defaultValue
{
    NSLog(@"%@",attributeName);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    NSLog(@"%@",elementName);
    
          if ( [elementName isEqualToString:@"html"])
          {
              return;
          }
          }
          
          - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
          {
              NSLog(@"Did end element %@",elementName);
              if ([elementName isEqualToString:@"root"])
              {
                  NSLog(@"rootelement end");
              }
              
          }
          - (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
          {
              NSString *tagName = @"column";
              
                  NSLog(@"Characters %@",string);
              
              if([tagName isEqualToString:@"column"])
              {
              }
              
          }

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    
    
    
    NSString *tempData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (tempData.length > 0) {
        
        [dataString appendString:tempData];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *htmlSTR = [[NSString alloc] initWithData:self.dataStuff encoding:NSUTF8StringEncoding];
    NSLog(@"YEAH %d",[htmlSTR length]);
    NSLog(@"%@",dataString);    
    
    
    
}



- (IBAction)Launch:(id)sender {
    
    [self performSegueWithIdentifier:@"EntryScreen" sender:self];
}
@end
