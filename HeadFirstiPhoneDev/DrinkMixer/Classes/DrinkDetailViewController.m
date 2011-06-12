//
//  DrinkDetailViewController.m
//  DrinkMixer
//
//  Created by suguni on 11. 5. 29..
//  Copyright 2011 다음 커뮤니케이션. All rights reserved.
//

#import "DrinkDetailViewController.h"
#import "DrinkConstants.h"


@implementation DrinkDetailViewController

@synthesize nameTextField, ingredientsTextView, directionsTextView;
@synthesize drink;
@synthesize scrollView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	scrollView.contentSize = self.view.frame.size;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[nameTextField setText:[drink objectForKey:NAME_KEY]];
	[ingredientsTextView setText:[drink objectForKey:INGREDIENTS_KEY]];
	[directionsTextView setText:[drink objectForKey:DIRECTIONS_KEY]];
}

- (IBAction)textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameTextField release];
	[ingredientsTextView release];
	[directionsTextView release];
	[drink release];
	[scrollView release];
    [super dealloc];
}


@end
