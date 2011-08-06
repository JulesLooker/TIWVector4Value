//
//  TIWVector4ValueProof.m
//  TIWVector4Value
//
//  Created by Jules Looker on 06/08/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

// Proofs are tests which either confirm or explore behaviours inherent in an object,
// not necessarily the functionality you have implemented in a subclass.

// Rather than contaminate your target application, perform experiments in a *Proof test case.

#import "TIWVector4ValueProof.h"

@implementation TIWVector4ValueProof

@synthesize vectorValueToObserve = _vectorValueToObserve;	NSString * const kTIWVector4ValueProofVectorValueToObservePropertyName = @"vectorValueToObserve";
@synthesize vectorValueToSetByKVC = _vectorValueToSetByKVC; NSString * const kTIWVector4ValueProofVectorValueToSetByKVCPropertyName = @"vectorValueToSetByKVC";

- (void)setUp
{
    [super setUp];
    
	_testVectorA.x = 1.1;
	_testVectorA.y = 2.2;
	_testVectorA.z = 3.3;
	_testVectorA.w = 4.4;
	
	_testVectorValueA = [NSValue valueWithTIWVector4:_testVectorA];
	
	_vectorValueToObserve = [NSValue valueWithTIWVector4:_testVectorA];
	_observationnTestPass = NO;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

#pragma mark - Equality

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

#pragma mark - Key Value Observing - NSObject(NSKeyValueObserving)

- (void)testKVO
{
	[self addObserver:self forKeyPath:kTIWVector4ValueProofVectorValueToObservePropertyName options:0 context:&_observationnTestPass];
	
	STAssertFalse(_observationnTestPass, @"Test result should be NO before test");
	self.vectorValueToObserve = [NSValue valueWithTIWVector4:_testVectorA];
	STAssertTrue(_observationnTestPass, @"Test status should be YES after test");
	
	[self removeObserver:self forKeyPath:kTIWVector4ValueProofVectorValueToObservePropertyName];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	// As a general test of observation any call to this method should pass a pointer to a success / fail BOOL via the context parameter

	// This check is made to ensure fail (NO) is the assumed default state in order that the caller can be confident of a pass (YES) result
	STAssertTrue(*(BOOL *)context == NO, @"context initially indicates success. context shoulud be NO initially");
	
	// An observation has occured for a given 'context', set context to pass state
	*(BOOL *)context = YES;
}

#pragma mark - Key Value Coding - NSObject(NSKeyValueCoding)

- (void)testKVC
{
	STAssertNil(self.vectorValueToSetByKVC, @"Value is not nil");
	[self setValue:_testVectorValueA forKey:kTIWVector4ValueProofVectorValueToSetByKVCPropertyName];
	STAssertEqualObjects(self.vectorValueToSetByKVC, _testVectorValueA, @"KVC did not work");	
}

#pragma mark - Archiving <NSCoding>

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

#pragma mark - Copying <NSCopying>

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
