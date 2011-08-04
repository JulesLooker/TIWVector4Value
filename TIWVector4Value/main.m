//
//  main.m
//  TIWVector4Value
//
//  Created by Jules Looker on 22/07/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Type definitiion

#define TIWVector4_basetype float
#define TIWVector4_multiple (4)
typedef TIWVector4_basetype TIWVector4 __attribute__ ((ext_vector_type(TIWVector4_multiple)));

#pragma mark - TIWVector4Extension category

@interface NSValue (TIWVector4Extension)

+ (NSValue *)valueWithTIWVector4:(TIWVector4)v;
- (TIWVector4)TIWVector4Value;

@end

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

#pragma mark - Informal testing

#define LOGVECTOR( V ) NSLog(@"%g %g %g %g" , V.x , V.y , V.z , V.w)

void testFunction( void );

int main (int argc, const char * argv[])
{
	@autoreleasepool
	{
		testFunction();
	}
    return 0;
}

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
	
	// NSCoding
	NSData *coded = [NSArchiver archivedDataWithRootObject:aVectorValue];
	NSValue *uncoded  = [NSUnarchiver unarchiveObjectWithData:coded];
	NSLog(@"uncoded %@" , [uncoded descriptionTIWVector4]);
	
	// NSCoding keyed
	NSData *keyCoded = [NSKeyedArchiver archivedDataWithRootObject:bVectorValue];
	NSValue *unKeyCoded = [NSKeyedUnarchiver unarchiveObjectWithData:keyCoded];
	NSLog(@"unKeyCoded %@" , [unKeyCoded descriptionTIWVector4]);
	
	// NSCopying
	NSValue *copy = [aVectorValue copy];
	NSLog(@"copy %@" , [copy descriptionTIWVector4]);
	
	// Equality confirmation
	NSLog(@"a equal a 1 == %d" , [aVectorValue isEqualToValue:aVectorValue]);
	NSLog(@"a equal b 0 == %d" , [aVectorValue isEqualToValue:bVectorValue]);
	NSLog(@"a equal copy 1 == %d" , [aVectorValue isEqualToValue:copy]);
	NSLog(@"b equal copy 0 == %d" , [bVectorValue isEqualToValue:copy]);
}
