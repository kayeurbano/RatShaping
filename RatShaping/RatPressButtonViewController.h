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
//    BOOL shapeVisible;
//    int shapePosition;
    int Image1;
    int Image2;
    int Image3;
    int Image4;
    int Image5;
    int Image6;
    int shapePosition;
    UIImage *stimulus;
    NSString *IP_Address;
}

-(IBAction) onPressButton: (id) sender;
- (void) messageReceived: (NSString *)message;
-(void) SquareOne: (int) shapevalue;
-(void) SquareTwo: (int) shapevalue;
-(void) SquareThree: (int) shapevalue;
-(void) SquareFour: (int) shapevalue;
-(void) SquareFive: (int) shapevalue;
-(void) SquareSix: (int) shapevalue;
@end
