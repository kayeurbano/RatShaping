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
    BOOL shapeVisible;
    int shapePosition;
    int shapeImage;
    CGPoint midpoint;
    UIImage *stimulus;
    NSString *IP_Address;
}

-(IBAction) onPressButton: (id) sender;
- (void) messageReceived: (NSString *)message;

@end
