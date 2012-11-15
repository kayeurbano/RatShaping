//
//  MenuViewController.m
//  RatShaping
//
//  Created by Student Worker Catherine Urbano on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "RatPressButtonViewController.h"



@interface MenuViewController ()

@end

@implementation MenuViewController

-(IBAction)onHelp:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController: ShowHelp animated: YES];
}

-(IBAction)onShortcut:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:ShowShortcuts animated:YES];
}

-(IBAction)Settings:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
    //    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:UserDefinedSettings animated:YES];
    UserDefinedPortNumber.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Port_number"];
    UserDefinedHostIP.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"IP_Address"];
}

-(IBAction)onDone:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)onNext:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:NextScreen animated:YES];
}

-(IBAction)onAutoshape:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:Autoshaping animated:YES];
}

-(IBAction)onSuccDiscrimination:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:SuccDiscrimination animated:YES];
}

-(IBAction)onSimulDiscrimination:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
//    [Placeholder popViewControllerAnimated:NO];
    [Placeholder pushViewController:SimulDiscrimination animated:YES];
}

-(IBAction)onPrevScreen:(id)sender{
    UINavigationController *Placeholder = self.navigationController;
    [Placeholder popViewControllerAnimated:YES];
//    [Placeholder pushViewController:PrevScreen animated:YES];
}

@end

