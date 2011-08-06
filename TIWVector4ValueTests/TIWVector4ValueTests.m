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

@end
