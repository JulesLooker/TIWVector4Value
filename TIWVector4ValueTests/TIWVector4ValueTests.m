//
//  TIWVector4ValueTests.m
//  TIWVector4ValueTests
//
//  Created by Jules Looker on 05/08/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

#import "TIWVector4ValueTests.h"


@implementation TIWVector4ValueTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
	_testVectorA.x = 1.1;
	_testVectorA.y = 2.2;
	_testVectorA.z = 3.3;
	_testVectorA.w = 4.4;
	
	_testVectorValueA = [NSValue valueWithTIWVector4:_testVectorA];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testValueWithTIWVector4
{
	NSValue *testVectorAValue = [NSValue valueWithTIWVector4:_testVectorA];
	
	STAssertTrue([testVectorAValue TIWVector4Value].x == _testVectorA.x , @"Value hasn't received vector component");
	STAssertTrue([testVectorAValue TIWVector4Value].y == _testVectorA.y , @"Value hasn't received vector component");
	STAssertTrue([testVectorAValue TIWVector4Value].z == _testVectorA.z , @"Value hasn't received vector component");
	STAssertTrue([testVectorAValue TIWVector4Value].w == _testVectorA.w , @"Value hasn't received vector component");
}

- (void)testTIWVector4
{	
	TIWVector4 testVectorB = [_testVectorValueA TIWVector4Value];
	
	STAssertTrue(testVectorB.x == _testVectorA.x , @"Vector component not returned from value");
	STAssertTrue(testVectorB.y == _testVectorA.y , @"Vector component not returned from value");
	STAssertTrue(testVectorB.z == _testVectorA.z , @"Vector component not returned from value");
	STAssertTrue(testVectorB.w == _testVectorA.w , @"Vector component not returned from value");
}

- (void)testEquality
{	
	NSValue *vectorAValue = [NSValue valueWithTIWVector4:_testVectorA];
	NSValue *vectorBValue = [NSValue valueWithTIWVector4:_testVectorA];
	
	STAssertFalse(vectorAValue == vectorBValue , @"Objects located at same memory address");
	
	STAssertTrue([vectorAValue isEqualToValue:vectorBValue] , @"Values are not equal");
	
	STAssertTrue([vectorAValue isEqual:vectorBValue], @"Values are not equal");
	
	// Confirm STAssertEqualObjects so we are happy to use it in other tests
	STAssertEqualObjects(vectorAValue, vectorBValue, @"Values are not equal");
}

- (void)testInequality
{	
	NSValue *vectorAValue = [NSValue valueWithTIWVector4:_testVectorA];

	TIWVector4 vectorB = { _testVectorA.x+1.0 , _testVectorA.y+2.0 , _testVectorA.z+3.0 , _testVectorA.w+4.0};
	NSValue *vectorBValue = [NSValue valueWithTIWVector4:vectorB];
	
	STAssertFalse([vectorBValue isEqualToValue:vectorAValue] , @"Values are equal");
	
	STAssertFalse([vectorBValue isEqual:vectorAValue], @"Values are equal");
}

- (void)testNSCoding
{
	NSData *coded = [NSArchiver archivedDataWithRootObject:_testVectorValueA];
	NSValue *uncoded  = [NSUnarchiver unarchiveObjectWithData:coded];
	
	STAssertEqualObjects(_testVectorValueA , uncoded , @"Unarchived objects are not equal");
}

- (void)testNSCodingKeyed
{
	NSData *keyCoded = [NSKeyedArchiver archivedDataWithRootObject:_testVectorValueA];
	NSValue *unKeyCoded = [NSKeyedUnarchiver unarchiveObjectWithData:keyCoded];

	STAssertEqualObjects(_testVectorValueA, unKeyCoded, @"Unarchived objects are not equal");
}

- (void)testNSCopying
{
	NSValue *copy = [_testVectorValueA copy];	// ARC is on, feels strange not having to release
	
	STAssertEqualObjects(copy , _testVectorValueA, @"Value not copied");
	
	// copy returns pointer to original object as proved below
	// This makes sense as NSValue objects are considered immutable however in use it will probably trip me up
	STAssertTrue(copy == _testVectorValueA, @"Newly allocated object returned");
	
	// To make a new physical copy do this
	NSValue *physicalCopy = [NSValue valueWithTIWVector4:[_testVectorValueA TIWVector4Value]];
	STAssertFalse(physicalCopy == _testVectorValueA, @"Copy is the original object");
	STAssertEqualObjects(physicalCopy , _testVectorValueA, @"Copy is not equal to original");
}

@end
