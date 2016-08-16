//
//  ClassMateData.h
//  MyClassMate
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ClassMate : NSObject

@property (nonatomic, readonly) NSString* uuid;
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* photo;
@property (nonatomic) NSString* mobile;
@property (nonatomic) NSString* profile;

-(instancetype)initWithData:(NSDictionary*)data;
-(NSDictionary*)toData;

-(UIImage*)photoImage;
-(NSString*)photoFilePath;
-(NSString*)photoFileName;

@end

@interface ClassMateData : NSObject

@property (nonatomic) NSMutableArray<ClassMate*>* classMates;

+(ClassMateData*)sharedClassMateData;

-(void)save;
-(ClassMate*)createClassMate;
-(void)removeClassMate:(ClassMate *)classMate;


@end

