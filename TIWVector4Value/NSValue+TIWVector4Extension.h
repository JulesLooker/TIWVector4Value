//
//  NSValue+TIWVector4Extension.h
//  TIWVector4Value
//
//  Created by Jules Looker on 04/08/2011.
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

- (NSString *)descriptionTIWVector4;

@end
