//
//  ClassMateData.m
//  MyClassMate
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import "ClassMateData.h"

@implementation ClassMate

-(instancetype)init
{
    self = [super init];
    if(self){
        _uuid = [[NSUUID UUID] UUIDString];
    }
    return self;
}

-(instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    if(self) {
        _uuid = data[@"uuid"];
        _name = data[@"name"];
        _photo = data[@"photo"];
        _mobile = data[@"mobile"];
        _profile = data[@"profile"];
        
    }
    return self;
}

-(NSDictionary*)toData{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithCapacity:4];
    data[@"uuid"] = _uuid;
    data[@"name"] = _name;
    data[@"photo"] = _photo;
    data[@"mobile"] = _mobile;
    data[@"profile"] = _profile;
    
    return data;
}

-(UIImage *)photoImage{
    if (self.photo != nil && self.photo.length > 0) {
        NSData* imageData = [NSData dataWithContentsOfFile:[self photoFilePath]];
        return [UIImage imageWithData:imageData];
        
    } else {
        return [UIImage imageNamed:@"no_Image"];
    }
}

-(NSString*)photoFileName{
    return [NSString stringWithFormat:@"%@.jpg", _uuid];
}

-(NSString*)photoFilePath{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return  [[paths firstObject] stringByAppendingPathComponent:[self photoFileName]];
}

@end

@implementation ClassMateData

+(ClassMateData *)sharedClassMateData{
    static ClassMateData* sharedClassMateData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClassMateData = [[self alloc] init];
    });
    return sharedClassMateData;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _classMates = [NSMutableArray arrayWithCapacity:29];
        
        NSString* dataFilePath = [self dataFilePath];
        NSLog(@"Class Mate Data: Loading data from %@", dataFilePath);
        NSArray *classMateArray = [NSArray arrayWithContentsOfFile:dataFilePath];
        
        if (classMateArray == nil || classMateArray.count < 1) {
            NSLog(@"Class Mate Data file in app documents folder doesn't exit or has nothing in it,reloading default plist from bundle.");
            classMateArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ClassMates" ofType:@"plist"]];
            
        }
        
        for (NSDictionary* data in classMateArray) {
            ClassMate* classMate = [[ClassMate alloc] initWithData:data];
            [_classMates addObject:classMate];
        }
    }
    return self;
}

-(ClassMate *)createClassMate{
    NSLog(@"Creation new class mate.");
    ClassMate* classMate = [[ClassMate alloc] init];
    [_classMates addObject:classMate ];
    return classMate;
}

-(void)removeClassMate:(ClassMate *)classMate{
    NSLog(@"Remove class mate for list.");
    [_classMates removeObject:classMate];
    if (classMate.photo != nil && classMate.photo.length > 0) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:[classMate photoFilePath] error:&error];
        NSLog(@"%@",error);
    }
}

-(void)save {
    NSMutableArray* classMatesArray = [[NSMutableArray alloc] initWithCapacity:29];
    for (ClassMate* classMate in _classMates) {
        [classMatesArray addObject:[classMate toData]];
    }
    [classMatesArray writeToFile:[self dataFilePath] atomically:YES];
}

-(NSString*)dataFilePath {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths firstObject] stringByAppendingPathComponent:@"ClassMates.plist"];
}













@end
