//
//  ViewController.m
//  SQList
//
//  Created by keyrun on 14-4-26.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString* dataBasePath ;
    NSString *newDataPath;
    
}
@end
static NSString* staticStr =@"sad";
const NSString* externString =@"nmnm";
@implementation ViewController

NSString *const stringOne =@"stringOne";
NSString *const stringTwo =@"stringTwo";


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    static NSString *static2 =@"aaaaaaa";


    NSArray* dirPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsDir =[dirPaths objectAtIndex:0];
    
    dataBasePath =[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"person.sqlite"]];
    
    self.phoneText.delegate =self;
    if (sqlite3_open([dataBasePath UTF8String], &contactDB) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@" open fail");
    }
    
    NSArray* dirPaths2 = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *docsDir2 =[dirPaths2 objectAtIndex:0];
    dataBasePath =[[NSString alloc]initWithString:[docsDir2 stringByAppendingString:@"person.sqlite"]];
    
    if (sqlite3_open([dataBasePath UTF8String], &contactDB) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@"  open sqlite fail");
    }
    
    
    NSArray *directorPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir =[directorPaths objectAtIndex:0];
    newDataPath =[[NSString alloc]initWithString:[documentDir stringByAppendingPathComponent:@"newPersons.sqlite"]];
    if (sqlite3_open([newDataPath UTF8String], &contactDB) != SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@"  打开失败 ");
    }
    
    NSString *sqliteCreateTable =@"CREATE TABLE IF NOT EXISTS NEWPERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT ,phone TEXT )";
    [self execSqlite:sqliteCreateTable];
#define  TABLENAME @"NEWPERSONS"
#define  NAMEONE @"张三"
#define PHONEONE @"123445"
    
#define   NAMETWO @"李四"
#define PHONETWO @"544321"
#define  NAME @"name"
#define  PHONE @"phone"
    NSString *sqliteOne =[NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@') VALUES ('%@' ,'%@')",TABLENAME,NAME,PHONE,NAMEONE,PHONEONE];
    [self execSqlite:sqliteOne];
    
    NSString *sqliteTWO =[NSString stringWithFormat:@"INSERT INTO '%@' ('%@' ,'%@') VALUES ('%@' ,'%@')",TABLENAME ,NAME,PHONE,NAMETWO,PHONETWO];
    [self execSqlite:sqliteTWO];
    
    //    NSString* sqlCreateTable =@"CREATE TABLE IF NOT EXISTS PERSON (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,phone TEXT)";
    /*
     NSFileManager* fileMgr =[NSFileManager defaultManager];
     
     if ([fileMgr fileExistsAtPath:dataBasePath] ==NO) {
     const char* dbpath =[dataBasePath UTF8String];
     if (sqlite3_open(dbpath, &contactDB) ==SQLITE_OK) {
     char *errMsg;
     
     if (sqlite3_exec(contactDB, [sqlCreateTable UTF8String], NULL, NULL, &errMsg) !=SQLITE_OK) {
     NSLog(@" 创建表失败");
     }else {
     NSLog(@"  创建表成功");
     }
     }
     else{
     NSLog(@" 创建数据库失败");
     }
     }
     */
    
}
-(void)execSqlite:(NSString *)sqlStr{
    char *error;
    if (sqlite3_exec(contactDB, [sqlStr UTF8String], NULL, NULL, &error) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@"   数据库操作数据失败   error ==%@",[NSString stringWithUTF8String:error]);
    }
}


-(void)dataSqlite:(NSString*)sqlstring{
    char *err;
    if (sqlite3_exec(contactDB, [sqlstring UTF8String], NULL, NULL, &err) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@" data fail");
    }
    
    char* err2;
    if (sqlite3_exec(contactDB, [sqlstring UTF8String], NULL, NULL, &err2) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@" data save fail");
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.phoneText resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
*  保存数据
*
*  @param sender
*/
- (IBAction)clickSave:(id)sender {
    //    sqlite3_stmt* statement;
    //    const char *dbpath =[dataBasePath UTF8String];
    //    if (sqlite3_open(dbpath, &contactDB) ==SQLITE_OK) {
    //        NSString* insertSQL =[NSString stringWithFormat:@"INSERT INTO CONTACTS (name,phone) VALUES(\"%@\",\"%@\")",self.nameText.text,self.phoneText.text];
    //        const char* insert_stmt =[insertSQL UTF8String];
    //        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
    //        if (sqlite3_step(statement) ==SQLITE_DONE) {
    //            self.nameText.text =@"";
    //            self.phoneText.text =@"";
    //            NSLog(@" success");
    //        }
    //        else{
    //            NSLog(@" shibai");
    //        }
    //        sqlite3_finalize(statement);
    //        sqlite3_close(contactDB);
    //    }
    /*
     NSString* adress =@"adc";
     sqlite3_stmt *statement;
     
     const char *dbpath = [dataBasePath UTF8String];
     
     if (sqlite3_open(dbpath, &contactDB)==SQLITE_OK) {
     NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO CONTENT (name,phone) VALUES(\"%@\",\"%@\")",self.nameText.text,self.phoneText.text];
     const char *insert_stmt = [insertSQL UTF8String];
     sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
     if (sqlite3_step(statement)==SQLITE_DONE) {
     //            status.text = @"已存储到数据库";
     //            name.text = @"";
     //            address.text = @"";
     //            phone.text = @"";
     NSLog(@"   cg");
     }
     else
     {
     //            status.text = @"保存失败";
     NSLog(@" sb");
     }
     sqlite3_finalize(statement);
     sqlite3_close(contactDB);
     }
     */
    NSString* sql1 =[NSString stringWithFormat:@"INSERT INTO PERSON (name ,phone) VALUES ('%@','%@')",self.nameText.text,self.phoneText.text];
    [self dataSqlite:sql1];
    
    self.nameText.text =@"";
    self.phoneText.text =@"";
    
    
    NSString *sql2 =[NSString stringWithFormat:@"INSERT INTO PERSON (name ,phone) VALUES ('%@','%@')",self.nameText.text ,self.phoneText.text];
    [self dataSqlite:sql2];
    self.nameText.text =@"";
    self.phoneText.text =@"";
    
}
/**
*  sqlist查询
*
*  @param sender
*/
- (IBAction)clickCheck:(id)sender {
    
    
    NSString* sqlQuery =[NSString stringWithFormat:@"SELECT phone FROM person WHERE name='%@'",self.nameText.text];
    //    NSString* sqlQuery =@"SELECT * FROM PERSON";
    //    NSString* sqlQuery =[NSString stringWithFormat:@"SELECT phone from person where name=\"%@\"",self.nameText.text];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, nil) ==SQLITE_OK) {
        if (sqlite3_step(statement) ==SQLITE_ROW) {
            
            char* name =(char*) sqlite3_column_text(statement, 0);
            NSLog(@"   %s",name);
            NSString* nameStr =[[NSString alloc]initWithUTF8String:name];
            //        char* phonec =(char*) sqlite3_column_text(statement, 1);
            //        NSString* phone =[[NSString alloc]initWithUTF8String:phonec];
            
            //        self.nameText.text =nameStr;
            self.phoneText.text =nameStr;
        }
    }
    
    
    
}

- (IBAction)checkall:(id)sender {
    /*
     NSString* sqlQuery =@"SELECT * FROM PERSON";
     sqlite3_stmt * statement;
     if (sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL)==SQLITE_OK) {
     while (sqlite3_step(statement) ==SQLITE_ROW) {
     char* name = (char*)sqlite3_column_text(statement, 1);
     NSString* strName =[[NSString alloc]initWithUTF8String:name];
     
     char* phone =(char* )sqlite3_column_text(statement, 2);
     NSString* strPhone =[[NSString alloc]initWithUTF8String:phone];
     NSLog(@"  __person__%@_%@",strName,strPhone);
     
     }
     }
     */
    NSString* sqlQuery =@"SELECT * FROM PERSON";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(contactDB, [sqlQuery UTF8String], -1, &statement, NULL) ==SQLITE_OK) {
        while (sqlite3_step(statement) ==SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            NSString* sreName =[NSString stringWithUTF8String:name];
            
            char *phone =(char*) sqlite3_column_text(statement, 2);
            NSString *strPhone =[NSString stringWithUTF8String:phone];
            
            NSLog(@"  %@   %@ ",sreName,strPhone);
        }
    }
    
    NSString *sqliteQuery =@"SELECT * FROM NEWPERSONS";
    sqlite3_stmt *statementT;
    if (sqlite3_prepare_v2(contactDB, [sqliteQuery UTF8String], -1, &statementT, nil) ==SQLITE_OK) {
        while (sqlite3_step(statementT) ==SQLITE_ROW) {
            char *name =(char *)sqlite3_column_text(statementT, 1);
            NSString *nameStr =[[NSString alloc]initWithUTF8String:name];
            
            NSLog(@" newSqlite Name == %@",nameStr);
            char *phone = (char *)sqlite3_column_text(statementT, 2);
            NSString *phoneStr =[[NSString alloc]initWithUTF8String:phone];
            NSLog(@" newSqlite Phone == %@",phoneStr);
        }
    }
    

}


#pragma mark - Theme Key Extern Keys



@end










