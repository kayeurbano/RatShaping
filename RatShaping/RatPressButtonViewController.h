//
//  RatPressButtonViewController.h
//  RatShaping
//
//  Created by Student Worker Catherine Urbano on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RatPressButtonViewController : UIViewController<NSStreamDelegate>{
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    BOOL isConnected;
    NSArray* vbInstructions;
    int Image1;
    int Image2;
    int Image3;
    int Image4;
    int Image5;
    int Image6;
    int shapePosition;
    UIImage *stimulus;
    int Port_Number;
    NSString *IP_Address;
    IBOutlet UINavigationController* MenuNavigation;
    IBOutlet UITextField *UserDefinedPortNumber;
    IBOutlet UITextField *UserDefinedHostIP;
    IBOutlet UISwitch *toggleDimming;
    NSString *switchValue;
}

@property (strong, nonatomic) IBOutlet UITextField *UserDefinedPortNumber;
@property (strong, nonatomic) IBOutlet UITextField *UserDefinedHostIP;
@property (strong, nonatomic) IBOutlet UISwitch *toggleDimming;


-(void)didTap;
-(void)ResetConnection;
-(IBAction) onPressButton: (id) sender;
- (void) messageReceived: (NSString *)message;
-(void) SquareOne: (int) shapevalue;
-(void) SquareTwo: (int) shapevalue;
-(void) SquareThree: (int) shapevalue;
-(void) SquareFour: (int) shapevalue;
-(void) SquareFive: (int) shapevalue;
-(void) SquareSix: (int) shapevalue;
- (IBAction)SaveSettings:(id)sender;

@end
