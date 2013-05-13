//
//  SetCard.m
//  Matchismo
//
//  Created by Lexor on 12.05.13.
//  Copyright (c) 2013 Lexor. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(id)initWithDefault
{
    self = [super init];
    if (self)
    {
        self.shape = 0;
        self.amount = 3;
        self.shade = 0;
        self.color = 2;
    }
    return self;
}

+(int) maxAmount
{
    return 3;
}

+(int) maxShade
{
    return 3;
}

+(int) maxColor
{
    return 3;
}

+(int) maxShape
{
    return 3;
}


-(NSString *)description
{
    NSMutableString *str = [NSMutableString stringWithString:@[@"☐", @"△", @"○"][self.shape]];
    for (int i = 0; i < self.amount-1; i++)
    {
        str = [[str stringByAppendingString:@[@"☐", @"△", @"○"][self.shape]]mutableCopy];
    }
    if (self.color == 0) [str appendString:@" Color: GREEN "];
    if (self.color == 1) [str appendString:@" Color: RED "];
    if (self.color == 2) [str appendString:@" Color: BLUE "];
    
    [str appendString:[NSString stringWithFormat:@"Shade = %d",self.shade]];

    
    return str;
    
}
@end
