//
//  MenuViewController.h
//  RatShaping
//
//  Created by Student Worker Catherine Urbano on 10/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RatPressButtonViewController.h"

@interface MenuViewController : RatPressButtonViewController{
    IBOutlet UIViewController *ShowHelp;
    IBOutlet UIViewController *ShowShortcuts;
    IBOutlet UIViewController *PrevScreen;
    IBOutlet UIViewController *NextScreen;
    IBOutlet UIViewController *Autoshaping;
    IBOutlet UIViewController *SuccDiscrimination;
    IBOutlet UIViewController *SimulDiscrimination;
    IBOutlet UIViewController *UserDefinedSettings;
}

-(IBAction)onHelp:(id)sender;
-(IBAction)onShortcut:(id)sender;
-(IBAction)onDone:(id)sender;
-(IBAction)onNext:(id)sender;
-(IBAction)onAutoshape:(id)sender;
-(IBAction)onSuccDiscrimination:(id)sender;
-(IBAction)onSimulDiscrimination:(id)sender;
-(IBAction)onPrevScreen:(id)sender;
-(IBAction)Settings:(id)sender;


@end
