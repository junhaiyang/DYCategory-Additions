

#import "NSDictionary+Data.h" 

static NSString *const DATA_DICTIONARY_KEY = @"DATA_DICTIONARY_KEY";

@implementation   NSData(Dictionary)

-(NSDictionary *)dictionary{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:self];
    NSDictionary *myDictionary = [unarchiver decodeObjectForKey:DATA_DICTIONARY_KEY];
    [unarchiver finishDecoding];
    return myDictionary;
}

@end

@implementation NSDictionary(Data)

-(NSData *)data{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:(NSMutableData *)data];
    [archiver encodeObject:self forKey:DATA_DICTIONARY_KEY];
    [archiver finishEncoding];
    return data;
}

@end

