//
//  ViewController.m
//  DropShot
//
//  Created by David Rentsch on 21.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#define PORT 1234


@implementation ViewController
@synthesize tropfenAnzahlEingabe;    //wird momentan verwendet für die Loop Anzahl!
@synthesize tropfenZeitEingabe;
@synthesize tropfenGroesseEingabe;
@synthesize blitzVerzoegerungEingabe;
@synthesize tropfenAnzahlAusgabe;
@synthesize tropfenZeitAusgabe;
@synthesize tropfenGroesseAusgabe;
@synthesize blitzZeitAusgabe;


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tropfenAnzahlEingabe resignFirstResponder]; //wird momentan verwendet für die Loop Anzahl!
    [self.tropfenZeitEingabe resignFirstResponder];
    [self.tropfenGroesseEingabe resignFirstResponder];
    [self.blitzVerzoegerungEingabe resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // wenn hier  zb eine Aktion aus dem buttonPressed steht würde die aktion sofort nach "RETURN" durchgeführt werden
    //test commit fürs hub
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTropfenAnzahlEingabe:nil]; //wird momentan verwendet für die Loop Anzahl!
    [self setTropfenZeitEingabe:nil];
    [self setTropfenGroesseEingabe:nil];
    [self setBlitzVerzoegerungEingabe:nil];
    [self setTropfenAnzahlAusgabe:nil];
    [self setTropfenZeitAusgabe:nil];
    [self setTropfenGroesseAusgabe:nil];
    [self setBlitzZeitAusgabe:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonPressed:(id)sender {
    
    int sendVar1 = [self.tropfenAnzahlEingabe.text intValue];    //wird momentan verwendet für die Loop Anzahl!
    int sendVar2 = [self.tropfenZeitEingabe.text intValue];
    int sendVar3 = [self.tropfenGroesseEingabe.text intValue];
    int sendVar4 = [self.blitzVerzoegerungEingabe.text intValue];
    int sendVar5 = 1;
    
    NSString *transmit = [NSString stringWithFormat:@"%i %i %i %i %i",sendVar1, sendVar2, sendVar3, sendVar4, sendVar5];


// ------------- Daten Senden durch Socket "s" ----------    
    
    int s;
    struct sockaddr_in cli;
    struct hostent *server;
    char str [2048];    // puffer probleme durch gesamtsring?
    server = gethostbyname("192.168.0.30");
    bzero(&cli, sizeof(cli));
    cli.sin_family = AF_INET;
    cli.sin_addr.s_addr = htonl(INADDR_ANY);
    cli.sin_addr.s_addr = ((struct in_addr *) \
                           (server->h_addr))->s_addr;
    cli.sin_port = htons(PORT);
    s = socket(AF_INET, SOCK_STREAM, 0);
    connect(s, (void *)&cli, sizeof(cli));
    strcpy(str, [transmit UTF8String]);
    strcat(str, "\n");
    NSLog (@"%@",transmit);
    write(s, str, strlen(str));

    
//--------------- Daten empfangen durch Socket "s" -------------    
   
    char buff[2048];   // puffer probleme durch gesamtsring?
    unsigned int count; 
    int recvVar1, recvVar2, recvVar3, recvVar4, recvVar5;  //recvVar5 wird von iPhone immer 1 sein, da es auf Arduino Seite als Start der Anlage dient, und danach auf Arduinoseite wieder auf 0 gesetzt wird.
    listen(s, 5);
    count = recv(s, buff, sizeof(buff)-1, 0);   
    NSLog (@"%i",count);
    NSString *stringEmpfangen = [NSString stringWithUTF8String:buff];
    NSLog (@"%@",stringEmpfangen);
    sscanf(buff, "%d %d %d %d %d", &recvVar1, &recvVar2, &recvVar3, &recvVar4, &recvVar5);
    NSLog (@"gesetzter Wert 1: %i", recvVar1);
    NSLog (@"gesetzter Wert 2: %i", recvVar2);
    NSLog (@"gesetzter Wert 3: %i", recvVar3);
    NSLog (@"gesetzter Wert 4: %i", recvVar4);
    NSLog (@"gesetzter Wert 5: %i", recvVar5);
    
    self.tropfenAnzahlAusgabe.text = [NSString stringWithFormat:@"arVar 1: %i", recvVar1];
    self.tropfenZeitAusgabe.text = [NSString stringWithFormat:@"arVar 2: %i", recvVar2];
    self.tropfenGroesseAusgabe.text = [NSString stringWithFormat:@"arVar 3: %i", recvVar3];
    self.blitzZeitAusgabe.text = [NSString stringWithFormat:@"arVar 4: %i", recvVar4];
    
    close(s);  

    
}
@end
