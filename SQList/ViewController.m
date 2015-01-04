//
//  ViewController.m
//  SQList
//
//  Created by keyrun on 14-4-26.
//  Copyright (c) 2014年 keyrun. All rights reserved.
//

#import "ViewController.h"
#define  TABLENAME @"NEWPERSONS"
#define  NAMEONE @"张三"
#define PHONEONE @"123445"

#define   NAMETWO @"李四"
#define PHONETWO @"544321"
#define  NAME @"name"
#define  PHONE @"phone"
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
    
    //SQL语句是不区分大小写的
    NSArray* dirPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docsDir =[dirPaths objectAtIndex:0];
    
    dataBasePath =[[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"person.sqlite"]];
    
    self.phoneText.delegate =self;
    if (sqlite3_open([dataBasePath UTF8String], &contactDB) !=SQLITE_OK) {
        sqlite3_close(contactDB);
        NSLog(@" open fail");
    }else{
        NSLog(@" open OK== %d",sqlite3_open([dataBasePath UTF8String], &contactDB));
    }
    
    NSString* sqlCreateTable =@"CREATE TABLE IF NOT EXISTS PERSON (ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,phone TEXT)";
    [self execSqlite:sqlCreateTable];
    
    /*
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
     
     NSString *sqliteOne =[NSString stringWithFormat:@"INSERT INTO '%@' ('%@','%@') VALUES ('%@' ,'%@')",TABLENAME,NAME,PHONE,NAMEONE,PHONEONE];
     [self execSqlite:sqliteOne];
     
     NSString *sqliteTWO =[NSString stringWithFormat:@"INSERT INTO '%@' ('%@' ,'%@') VALUES ('%@' ,'%@')",TABLENAME ,NAME,PHONE,NAMETWO,PHONETWO];
     [self execSqlite:sqliteTWO];
     */
    
    
    /*
     NSFileManager* fileMgr =[NSFileManager defaultManager];
     
     if ([fileMgr fileExistsAtPath:dataBasePath] ==NO) {
     const char* dbpath =[dataBasePath UTF8String];
     if (sqlite3_open(dbpath, &contactDB) ==SQLITE_OK) {
     char *errMsg;
     const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSON(ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)";
     if (sqlite3_exec(contactDB, sql_stmt, NULL, NULL, &errMsg) !=SQLITE_OK) {
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
    //    NSLog(@" fileExist == %d  %@",[fileMgr fileExistsAtPath:dataBasePath],dataBasePath);
    
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
    
    //     NSString* adress =@"adc";
    sqlite3_stmt *statement;
    
    const char *dbpath = [dataBasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB)==SQLITE_OK) {
        NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO PERSON (name,phone) VALUES(\"%@\",\"%@\")",self.nameText.text,self.phoneText.text];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement)==SQLITE_DONE) {
            //                 status.text = @"已存储到数据库";
            self.nameText.text = @"";
            
            self.phoneText.text = @"";
            NSLog(@"   cg");
        }
        else
        {
            
            NSLog(@" sb  ==%d ",sqlite3_step(statement));
        }
        //        sqlite3_finalize(statement);       //释放sqlite3_stmt，如果使用完sqlite3_stmt不执行释放，就会造成内存泄露。
        //        sqlite3_close(contactDB);          //关闭已经打开了的数据库，也就是有释放内存的功能
    }
    
    
    /*
     NSString* sql1 =[NSString stringWithFormat:@"INSERT INTO PERSON (name ,phone) VALUES ('%@','%@')",self.nameText.text,self.phoneText.text];
     [self dataSqlite:sql1];
     
     self.nameText.text =@"";
     self.phoneText.text =@"";
     
     
     NSString *sql2 =[NSString stringWithFormat:@"INSERT INTO PERSON (name ,phone) VALUES ('%@','%@')",self.nameText.text ,self.phoneText.text];
     [self dataSqlite:sql2];
     self.nameText.text =@"";
     self.phoneText.text =@"";
     */
}
/**
 *  sqlist查询
 *
 *  @param sender
 */
- (IBAction)clickCheck:(id)sender {
    
    
    //    NSString* sqlQuery =[NSString stringWithFormat:@"SELECT phone FROM person WHERE name='%@'",self.nameText.text];
    
    NSString* sqlQuery =[NSString stringWithFormat:@"select phone from person where name=\"%@\"",self.nameText.text];
    
    //以上2种都能查询
    
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










