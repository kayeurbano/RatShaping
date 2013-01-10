//
//  RatPressButtonViewController.m
//  RatShaping
//
//  Created by Student Worker Catherine Urbano on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RatPressButtonViewController.h"




@interface RatPressButtonViewController()
@end

@implementation RatPressButtonViewController

@synthesize UserDefinedHostIP;
@synthesize UserDefinedPortNumber;

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

-(void)viewWillAppear:(BOOL)animated { 
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone]; 
    self.view.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInstructions)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 3;
    [self.view addGestureRecognizer:tap];
    UITapGestureRecognizer *reset = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResetConnection)];
    reset.numberOfTapsRequired = 2;
    reset.numberOfTouchesRequired = 2; 
    [self.view addGestureRecognizer:reset];
    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"Avalue"]])
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"Avalue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSelector:@selector(showInstructions) withObject:nil afterDelay:1];
    }
}

-(IBAction)SaveSettings:(id)sender{
    NSUserDefaults *Settings = [NSUserDefaults standardUserDefaults];
    [Settings setObject:UserDefinedHostIP.text forKey:@"IP_Address"];
    int portnumber = [UserDefinedPortNumber.text intValue];
    [Settings setInteger:portnumber forKey:@"Port_Number"]; 
    [Settings synchronize];
}


-(void)showInstructions{
    [[NSBundle mainBundle] loadNibNamed: @"MenuNavigation" owner:self options:nil];
    MenuNavigation.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:MenuNavigation animated:YES];
}

-(void)ResetConnection{
[self openConnection];
}

-(void) openConnection{
    IP_Address = [[NSUserDefaults standardUserDefaults] stringForKey:@"IP_Address"];
    Port_Number = [[NSUserDefaults standardUserDefaults] integerForKey:@"Port_Number"];
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost (NULL, (__bridge CFStringRef) IP_Address, Port_Number, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    NSLog(@"Connection opened. Host IP Address %@", IP_Address);
    NSLog(@"Port number %u", Port_Number);
    
//    [self performSelector:@selector(showAlert) withObject:nil afterDelay:10];    
}

//-(void)showAlert{
//    if (isConnected == NO){
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to establish a connection using IP address and/or port number." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    [inputStream close];
//    [outputStream close];
//    }
//    else {
//        return;
//    }
//}

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
    Image1 = [[vbInstructions objectAtIndex:0] intValue]; 
    Image2 = [[vbInstructions objectAtIndex:1] intValue]; 
    Image3 = [[vbInstructions objectAtIndex:2] intValue]; 
    Image4 = [[vbInstructions objectAtIndex:3] intValue]; 
    Image5 = [[vbInstructions objectAtIndex:4] intValue]; 
    Image6 = [[vbInstructions objectAtIndex:5] intValue]; 
    NSLog(@"Message separated");
    NSLog(@"Image1 = %i", Image1);
    NSLog(@"Image2 = %i", Image2);
    NSLog(@"Image3 = %i", Image3);
    [self SquareOne:Image1];
    [self SquareTwo:Image2];
    [self SquareThree:Image3];
    [self SquareFour:Image4];
    [self SquareFive:Image5];
    [self SquareSix:Image6];    
}
    
- (void) SquareOne: (int) shapevalue{
    UIButton *View1 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View1.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, 300, 300);
    View1.tag = 1;
    if (shapevalue != 0)
    {
        
        [View1 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];

    }
    else {
        View1.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:View1];
    NSLog(@"Image 1 picture: %@", View1.currentBackgroundImage);
    [View1 addTarget:self action:@selector(onPressButton: ) forControlEvents:UIControlEventTouchDown];
}

- (void) SquareTwo: (int) shapevalue{
    UIButton *View2 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View2.frame = CGRectMake(self.view.bounds.size.height/2 - 25, self.view.bounds.origin.y, 300, 300);
    View2.tag = 2;
    if (shapevalue != 0)
    {
        
        [View2 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];
        
    }
    else {
        View2.backgroundColor = [UIColor blackColor];
        
    }
    [self.view addSubview:View2];
    NSLog(@"Image 2 picture: %@", View2.currentBackgroundImage);
    [View2 addTarget:self action:@selector(onPressButton: )  forControlEvents:UIControlEventTouchDown];
}

- (void) SquareThree: (int) shapevalue{
    UIButton *View3 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View3.frame = CGRectMake(self.view.bounds.size.height - 40, self.view.bounds.origin.y, 300, 300);
    View3.tag = 3;
    if (shapevalue != 0)
    {
        [View3 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];
        }
    else {
        View3.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:View3];
    NSLog(@"Image 3 picture: %@", View3.currentBackgroundImage);
    [View3 addTarget:self action:@selector(onPressButton:)  forControlEvents:UIControlEventTouchDown];
}

- (void) SquareFour: (int) shapevalue{
    UIButton *View4 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View4.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.width/2 - 50, 300, 300);
    View4.tag = 4;
    if (shapevalue != 0)
    {
       [View4 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];
    }
    else {
        View4.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:View4];
    [View4 addTarget:self action:@selector(onPressButton:)  forControlEvents:UIControlEventTouchDown];
}

- (void) SquareFive: (int) shapevalue{
    UIButton *View5 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View5.frame = CGRectMake(self.view.bounds.size.height/2-25, self.view.bounds.size.width/2 - 50, 300, 300);
    View5.tag = 5;
    if (shapevalue != 0)
    {
      [View5 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];
    }
    else {
        View5.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:View5];
    [View5 addTarget:self action:@selector(onPressButton: )  forControlEvents:UIControlEventTouchDown];
}

- (void) SquareSix: (int) shapevalue{
    UIButton *View6 = [UIButton buttonWithType:UIButtonTypeCustom]; 
    View6.frame = CGRectMake(self.view.bounds.size.height-40, self.view.bounds.size.width/2 - 50, 300, 300);
    View6.tag = 6;
    if (shapevalue != 0)
    {
      [View6 setBackgroundImage:[self shape: shapevalue] forState:(UIControlStateNormal)];
    }
    else {
        View6.backgroundColor = [UIColor blackColor];
    }
    [self.view addSubview:View6];
    [View6 addTarget:self action:@selector(onPressButton: )  forControlEvents:UIControlEventTouchDown];
}



- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
            isConnected = YES;
            NSLog(@"Connection established");
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
//            [outputStream close];
//            [inputStream close];
//            for (UIButton *btn in self.view.subviews){
//                [btn removeFromSuperview];
//            }
            //For Leising Lab:
            [self openConnection];
            [self sendMessage: [NSString stringWithFormat: @"9"]];            
			break;
            
		case NSStreamEventEndEncountered:
            isConnected = NO;
//            [outputStream close];
//            [inputStream close];
//            [self viewWillDisappear:YES];
//            for (UIButton *btn in self.view.subviews){
//                [btn removeFromSuperview];
//            }   
             //For Leising Lab:
             [self openConnection];
             [self sendMessage: [NSString stringWithFormat: @"9"]];
			break;
            
	}
    
}

-(void) closeConnection{
    [inputStream close];
    [outputStream close];
    isConnected = NO;
}



- (UIImage *) shape: (int) shapeImage{
    switch (shapeImage) {
        case 1:
            stimulus = [UIImage imageNamed:@"1.bmp"];
            break;
        case 2:
            stimulus = [UIImage imageNamed:@"2.bmp"];
            break;
        case 3:
            stimulus = [UIImage imageNamed:@"3.bmp"];
            break;
        case 4:
            stimulus = [UIImage imageNamed:@"4.bmp"];
            break;
        case 5:
            stimulus = [UIImage imageNamed:@"5.bmp"];
            break;
        case 6:
            stimulus = [UIImage imageNamed:@"6.bmp"];
            break;
        case 7:
            stimulus = [UIImage imageNamed:@"7.bmp"];
            break;
    }
    return stimulus;
}

- (IBAction) onPressButton: (id) sender{ 

    [self sendMessage: [NSString stringWithFormat: @"%i", [sender tag]]];

}


-(void) viewDidDisappear:(BOOL)animated{
        [self closeConnection];
    NSLog(@"Connection closed");
    for (UIButton *btn in self.view.subviews){
        [btn removeFromSuperview];
    }  
}


@end

     