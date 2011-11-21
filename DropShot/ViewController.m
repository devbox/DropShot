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
@synthesize tropfenAnzahlEingabe;
@synthesize tropfenZeitEingabe;
@synthesize tropfenGroesseEingabe;
@synthesize blitzVerzoegerungEingabe;
@synthesize tropfenAnzahlAusgabe;
@synthesize tropfenZeitAusgabe;
@synthesize tropfenGroesseAusgabe;
@synthesize blitzZeitAusgabe;


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tropfenAnzahlEingabe resignFirstResponder];
    [self.tropfenZeitEingabe resignFirstResponder];
    [self.tropfenGroesseEingabe resignFirstResponder];
    [self.blitzVerzoegerungEingabe resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // wenn hier  zb eine Aktion aus dem buttonPressed steht würde die aktion sofort nach "RETURN" durchgeführt werden
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
    [self setTropfenAnzahlEingabe:nil];
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
    
    self.tropfenAnzahlAusgabe.text = self.tropfenAnzahlEingabe.text;
    self.tropfenZeitAusgabe.text = self.tropfenZeitEingabe.text;
    self.tropfenGroesseAusgabe.text = self.tropfenGroesseEingabe.text;
    self.blitzZeitAusgabe.text = self.blitzVerzoegerungEingabe.text;
    
    
    char buff[BUFSIZ];
    char msg[BUFSIZ];
    int s;
    struct sockaddr_in cli;
    struct hostent *server;
    //  char str [100];
    server = gethostbyname("192.168.0.101");
    bzero(&cli, sizeof(cli));
    cli.sin_family = AF_INET;
    cli.sin_addr.s_addr = htonl(INADDR_ANY);
    cli.sin_addr.s_addr = ((struct in_addr *) \
                           (server->h_addr))->s_addr;
    cli.sin_port = htons(PORT);
    s = socket(AF_INET, SOCK_STREAM, 0);
    connect(s, (void *)&cli, sizeof(cli));
    printf("Nachricht eingeben\n");
    
    NSString *wert = self.tropfenAnzahlEingabe.text;
    char *str = [wert UTF8String];
    
    strcat(str, "\n");
    write(s, str, strlen(str));
    close(s);  
    
    
}
@end
