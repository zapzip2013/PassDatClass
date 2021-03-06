//
//  main.swift
//  PassDatSQL
//
//  Created by Bradley Close on 2/12/18.
//  Copyright © 2018 Bradley Close. All rights reserved.
//

import Foundation
import PGSQLKit

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
    ...
        conn.close();
}
