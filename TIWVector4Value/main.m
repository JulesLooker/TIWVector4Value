//
//  main.m
//  TIWVector4Value
//
//  Created by Jules Looker on 22/07/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSValue+TIWVector4Extension.h"

void testFunction( void );

int main (int argc, const char * argv[])
{
	@autoreleasepool
	{
		testFunction();
	}
    return 0;
}

#pragma mark - Informal testing

#define LOGVECTOR( V ) NSLog(@"%g %g %g %g" , V.x , V.y , V.z , V.w)

void testFunction( void )
{
	// Test data
	TIWVector4 aVector = { 1.1 , 2.3 , 3.5 , 4.8 };
	TIWVector4 bVector = { 9.1 , 6.3 , 7.5 , 8.8 };
	
	NSValue *aVectorValue = [NSValue valueWithTIWVector4:aVector];
	NSValue *bVectorValue = [NSValue valueWithTIWVector4:bVector];

	// Just see where everything is
	NSLog(@"%p %p" , &aVector , &bVector);
	NSLog(@"%p %p" , aVectorValue , bVectorValue);
	
	// Display test values
	LOGVECTOR( aVector );
	NSLog(@"%@" , [aVectorValue descriptionTIWVector4]);
	LOGVECTOR( bVector );
	NSLog(@"%@" , [bVectorValue descriptionTIWVector4]);
	
}
