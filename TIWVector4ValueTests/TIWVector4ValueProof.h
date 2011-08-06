//
//  TIWVector4ValueProof.h
//  TIWVector4Value
//
//  Created by Jules Looker on 06/08/2011.
//  Copyright 2011 The Interface Works. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.

#import <SenTestingKit/SenTestingKit.h>

#import "NSValue+TIWVector4Extension.h"

@interface TIWVector4ValueProof : SenTestCase
{
	TIWVector4 _testVectorA;
	NSValue *_testVectorValueA;
	
	NSValue *_vectorValueToObserve;
	BOOL _observationnTestPass;
	
	NSValue *_vectorValueToSetByKVC;
}

@property (readwrite , retain) NSValue *vectorValueToObserve;
@property (readwrite , retain) NSValue *vectorValueToSetByKVC;

@end
