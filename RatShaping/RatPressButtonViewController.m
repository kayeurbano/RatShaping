//
//  RatPressButtonViewController.m
//  RatShaping
//
//  Created by Student Worker Catherine Urbano on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RatPressButtonViewController.h"
#define TCP_PORT 12345


@implementation RatPressButtonViewController



-(void) awakeFromNib{
        [self openConnection];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (void)viewWillAppear:(BOOL)animated {  
   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone]; 
}  

-(void) openConnection{
    IP_Address = [[NSUserDefaults standardUserDefaults] stringForKey:@"server_address"];
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost (NULL, (__bridge CFStringRef) IP_Address, TCP_PORT, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    NSLog(@"Connection opened. Host IP Address %@", IP_Address);
}



-(void) sendMessage: (NSString*) message{
    if(isConnected == NO){
        [self openConnection];
        return;
    }
    NSString *response  = [NSString stringWithFormat:@"%@",message];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
}

- (void) messageReceived: (NSString *)message{
    vbInstructions = [message componentsSeparatedByString:@","];
    shapeVisible = [[vbInstructions objectAtIndex:0] boolValue];
    shapePosition = [[vbInstructions objectAtIndex:1] intValue]; 
    shapeImage = [[vbInstructions objectAtIndex:2] intValue]; 
    NSLog(@"Message separated");
    [self xyPosition];
    [self shape];
    CGFloat xpos = midpoint.x;
    CGFloat ypos = midpoint.y;
    UIButton *targetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
    targetButton.frame = CGRectMake(xpos, ypos, 300, 300);
    [targetButton setBackgroundImage:stimulus forState:(UIControlStateNormal)];
    if (shapeVisible == YES) {
        [self.view addSubview:targetButton];
        [targetButton addTarget:self action:@selector(onPressButton:) forControlEvents:UIControlEventTouchUpInside];
    }    
    
    else {
        CGFloat height = self.view.bounds.size.height;
        CGFloat width = self.view.bounds.size.width;
        UIView * ITI = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self.view addSubview:ITI];
        ITI.backgroundColor = [UIColor blackColor];
    }
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
            isConnected = YES;
            NSLog(@"Connection established");
       //     [self sendMessage: [NSString stringWithFormat: @"1"]];
            break;
    
		case NSStreamEventHasBytesAvailable:
            NSLog(@"Receiving msg");
            if (theStream == inputStream) {
                uint8_t buffer[1024];
                int len;
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        NSLog(@"%@", output);
                        if (nil != output) {
                
                [self messageReceived:output];
                           
                        }
                    }
                 
                }
            }
			break;			
            
		case NSStreamEventErrorOccurred:
			isConnected = NO;
            [outputStream close];
            [inputStream close];
			break;
            
		case NSStreamEventEndEncountered:
            isConnected = NO;
            [outputStream close];
            [inputStream close];
			break;
            
	}
    
}

-(void) closeConnection{
    [inputStream close];
    [outputStream close];
    isConnected = NO;
}

- (void) xyPosition {
    switch (shapePosition) {
        case 1:
            midpoint.x = self.view.bounds.size.height/4 - 100;
            midpoint.y = self.view.bounds.origin.y;
        //    midpoint.x = 400;
         //   midpoint.y = 300;
            break;
            
            
            //           midpoint.x = self.view.bounds.size.height/8;
 //           midpoint.y = self.view.bounds.origin.y + (self.view.bounds.size.width/4);
  //          break;
        case 2:
           // midpoint.x = 500;
           // midpoint.y = 300;
            
            midpoint.x = self.view.bounds.size.height/2 - 50;
            midpoint.y = self.view.bounds.origin.y;
           break;
        case 3:
         //   midpoint.x = 600;
         //   midpoint.y = 300;
            midpoint.x = self.view.bounds.size.height;
            midpoint.y = self.view.bounds.origin.y;
       
            break;
 //       case 4:
 //           midpoint.x = self.view.bounds.size.height/8;
 //           midpoint.y = self.view.bounds.origin.y + ((self.view.bounds.size.width*3)/4);
 //           break;
 //       case 5:
 //           midpoint.x = self.view.bounds.size.height/4;
 //           midpoint.y = self.view.bounds.origin.y + ((self.view.bounds.size.width*3)/4);
 //           break;
 //       case 6:
 //           midpoint.x = (self.view.bounds.size.height*6)/8;
 //           midpoint.y = self.view.bounds.origin.y + ((self.view.bounds.size.width*3)/4);
 //           break;
   }
}

- (void) shape{
    switch (shapeImage) {
        case 1:
            stimulus = [UIImage imageNamed:@"8.bmp"];
            break;
       // case 2:
       //     stimulus = [UIImage imageNamed:@"2.bmp"];
       //     break;
       // case 3:
       //     stimulus = [UIImage imageNamed:@"3.bmp"];
       //     break;
       // case 4:
       //     stimulus = [UIImage imageNamed:@"4.bmp"];
       //     break;
    }
}





- (IBAction) onPressButton: (id) sender{ 
//    NSString *deviceId = [[UIDevice currentDevice] name]; 
    //   [self sendMessage: [NSString stringWithFormat: @"%@|%i", deviceId, shapeImage]];
    [self sendMessage: [NSString stringWithFormat: @"%i", shapePosition]];
//        NSLog(@"%@|%i", deviceId, shapeImage);
}


-(void) viewDidDisappear:(BOOL)animated{
        [self closeConnection];
    NSLog(@"Connection closed");
    }





@end
