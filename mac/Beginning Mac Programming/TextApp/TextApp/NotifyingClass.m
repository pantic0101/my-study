//
//  NotifyingClass.m
//  TextApp
//
//  Created by suguni on 12. 11. 30..
//  Copyright (c) 2012년 YuiWorld. All rights reserved.
//

#import "NotifyingClass.h"
#import "MathUtilities.h"
#import "WonderfulNumber.h"
#include <math.h>

@implementation NotifyingClass

- (id)init
{
    return self;
}

- (IBAction)displaySomeText:(id)sender
{
    WonderfulNumber *myWonderfulNumber = [[WonderfulNumber alloc] init];
    
    [myWonderfulNumber setStoredNumber:M_PI];
    
    float wonderfulNumber = [myWonderfulNumber storedNumber];
    
    [textView insertText:[NSString
                          stringWithFormat:@"My Wonderful value = %f\n", wonderfulNumber]];
}

- (float)generateValue:(float *)originalValue
{
    float radius = [textField floatValue];
    *originalValue = radius;
    return [MathUtilities circumferenceFromRadius:radius];
}

@end
