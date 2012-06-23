//
//  OCSSineTable.m
//
//  Created by Aurelius Prochazka on 6/6/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "OCSSineTable.h"

@implementation OCSSineTable

//TODO: Should make the partial sizes an array of floats
-(id) initWithSize:(int)size PartialStrengths:(OCSParamArray *)partials
{
    return [self initWithSize:size 
                   GenRoutine:kGenSines 
                   Parameters:[partials parameterString]];
}

-(id) init;
{
    return [self initWithSize:4096 GenRoutine:kGenSines Parameters:@"1"];
}


@end
