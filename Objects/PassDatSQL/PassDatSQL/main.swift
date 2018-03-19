//
//  main.swift
//  PassDatSQL
//
//  Created by Bradley Close on 2/12/18.
//  Copyright © 2018 Bradley Close. All rights reserved.
//
/*implemented by Jordan and Brad*/
import Foundation

var connectionString: String
connectionString = "host=" + "localhost"
connectionString += " port=" + "5432"
connectionString += " dbname=" + "postgres"
connectionString += " user=" + "pgexample"
connectionString += " password=" + "example"

var conn: PGSQLConnection
conn = PGSQLConnection();

conn.ConnectionString = connectionString
if (conn.connect())
{
    var rs = conn.open("select 'Hello Detabase!' as hello")
    while (!rs!.IsEOF)
    {
        var hello = rs!.fieldByName("hello").asString()
        println("Database says:  \(hello)")
        rs!.moveNext()
    }
    rs!.close()
        conn.close();
}


