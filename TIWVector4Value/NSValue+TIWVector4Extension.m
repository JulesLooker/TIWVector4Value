//
//  NSValue+TIWVector4Extension.m
//  TIWVector4Value
//
//  Created by Jules Looker on 04/08/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

#import "NSValue+TIWVector4Extension.h"

@implementation NSValue (TIWVector4Extension)

+ (NSValue *)valueWithTIWVector4:(TIWVector4)v
{
	return [NSValue valueWithBytes:&v objCType:@encode(TIWVector4_basetype[TIWVector4_multiple])];
}

- (TIWVector4)TIWVector4Value
{
	TIWVector4 vector;
	
	[self getValue:&vector];
	
	return vector;
}

- (NSString *)descriptionTIWVector4
{
	TIWVector4 vector;
	
	[self getValue:&vector];
	
	NSString *description = [NSString stringWithFormat:@"TIWVector4: {x:%g, y:%g, z:%g, w:%g}" , vector.x , vector.y , vector.z , vector.w];
	
	return description;
}

@end