//
//  ContainerDetail.m
//  CurrencyExchanger
//
//  Created by Jon Kotowski on 2/20/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "ContainerDetail.h"
#import "AppDelegate.h"
#import "ConversionController.h"

#define SegueIdentifierFirst @"embedFirst"
#define SegueIdentifierSecond @"embedSecond"

@implementation ContainerDetail


- (IBAction)ContainerDetailButton:(id)sender {
    [((ConversionController *)self.parentViewController) updateTransaction];
    //[self performSegueWithIdentifier:@"EmbedDefault" sender:self];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.borderWidth = 4.0f;
    self.view.backgroundColor = [UIColor darkGrayColor];
    AppDelegate * appd = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appd setUivc:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbedDefault"])
    {
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
        }
        else {
            [self addChildViewController:segue.destinationViewController];
            ((UIViewController *)segue.destinationViewController).view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:((UIViewController *)segue.destinationViewController).view];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    else if ([segue.identifier isEqualToString:@"Default"])
    {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:segue.destinationViewController];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
    }];
}

- (void)swapViewControllers
{
    self.currentSegueIdentifier = ([self.currentSegueIdentifier  isEqual: SegueIdentifierFirst]) ? SegueIdentifierSecond : SegueIdentifierFirst;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
