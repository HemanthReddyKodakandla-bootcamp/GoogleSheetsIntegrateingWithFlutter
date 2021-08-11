import 'dart:convert';

import 'package:flutter/material.dart';
import '../modals/user_data_modal.dart';
import 'package:gsheets/gsheets.dart';


class GoogleSheetsController{

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "angular-theorem-322610",
  "private_key_id": "f1a9db4ed76572d9fe8006881b898d432ba06b63",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCcivGI366/mH4b\nikXPbrT3qzQdlg0jooc/nQG6PHxLN5DPqM4yRZ9TgCP3JBUe58vYDiI1g/Z6rf2m\njI/CLsSkhJgL7zTWsaey84omRxYpRRG69gkXh6D3JvemSikMod/+20cUXYyoqiSt\np0E8OLnu7+LbZezZjOWtwsiwvNuI5jh2KDjgLm50SzSJe0h4zvv1SArOPW0U6KUa\nwBQfhHR1u715vgGTZUXoByeC3D3QnPA13sP81hAX9FCztUbEIP4mX4PLE/rQDAJa\n2vmCj0thPvPtAH61OT169D9Ln3guvq0EcKLR8BWG9njMojnZtLc/6hemD21iWHBB\nXNjdT7KBAgMBAAECggEAHuigQDJKQrJNVAq9NfPZ73zyUVUrSvnwUnMhwC/pKsDR\n6u6dp/dvOgF3GHkbYnrKGOLRhleD9z0bdCMUz3aEhSdZDiIxAKMbRY4onN40Vfm5\nQn0J1oeFFMew5jiGWmQr4hpRsoe2GideDpuTmdxpefALjt5VIa9cOi7XiW4AusrK\ntgMAu7gQ+EwR69YLB7qb4apqjDrTC9qag07eifIRyzI9QTkJ6KUnA5eSMCYUYH8O\nyQztyMB90dIxT8JFtPsjUA6deHB7ZBqiwMdWCzNJDXLSbRyjRU/pMEHbJRXFROJE\n+XLs8oYWU95nNH62bY9Kne7ffVF1VLKX+0ojSnfSMQKBgQDcmW7q2eikxsu/h0mO\nj+qOYfjTL1jb7qXKpkf+tJ33xNg18m34zP50vufZC3O0IrdQOuSJ9dUMIlLS4T+t\nKVFVVqnlkrX7LT1dipzH3t6sUAjhMlHcmo7W0HK5Vij+8FZI/wWIBM+OZROf1pn/\nAX9b3Q6xwnEhM6abrE9GxxTsTwKBgQC1qfb5sUQxBSiGBjsWJT1NwghO/fw+FZw6\nfINxRs2Qm5nYpuvJwCsoCRnPnpMaDHlN1i+B2SPc5oQSFNyGY8vGqTZCrijnF7pU\nL+AMFFnije378JdcMJohBj3gCOloz3hrEdgvB/FtDvViH3XueXNQ1kjkV5xYkFkb\ncw/5B16wLwKBgChDsSUYpQf+aQ4KaXil+BAI/du+Fp/+DTDR7O4mlXa17SjbmQsC\nj6dLeRH6ryG//GmedjxgLITMdwWaq361veyvps8KWkEAXuUF+dvZaBdXfGduQdbc\nNxoqbeY6Pb1arMUiFyZeimvZMx3Hk9Ahu9dOn/H+JZwDy3M6njWy/LStAoGABmAc\nps6t0fqYXXvCfxh3ek8g84S+YX9oqDTOeB8//582WwAgrkfsO8919G9gQj3F1BF8\nQVZZh9sfL3ND+gNul15A5T4veUy/4Ux81G+yZ90LSRg8d6PNBPOvIDmv11nQpBFQ\nQPZKZsVrnzHzdZcVkPS0Qi9A8Wq/ddMn8Flt3UkCgYEAhzUq1ZnX5GlJc4QM7xfL\nTH5kfG1dc+PY/b8m2NFoRJWtqDmR9VLg7BksGza4YsgbhpLS0pYRVZEdBdzF9BGy\nzXgg4sPyhaumMQyoU33SwlUuXEtOBTDbvIklI4BZzNAnPLHZ98Lu0uVqHwW7sNYA\nHXH0giOjH7goHx3aAYV3cjg=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheetsexample@angular-theorem-322610.iam.gserviceaccount.com",
  "client_id": "108974872998315237087",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheetsexample%40angular-theorem-322610.iam.gserviceaccount.com"
}
''';

  static final _spreadSheetId = "1dftkA4hZaLvXGDMujeN_73mVtvBbKyed3ePeZNGUSTI";

  static final _gSheets = GSheets(_credentials);

  static Worksheet? _userWorkSheet;

  static Future init () async{
    try {
      final spreadSheet = await _gSheets.spreadsheet(_spreadSheetId);

      _userWorkSheet = await getWorkSheet(spreadSheet, title: "Sheet1");
    }catch(e){
      debugPrint("error ${e.toString()}");
    }

  }

  static Future<Worksheet> getWorkSheet(Spreadsheet spreadsheet,{required String title}) async{
    try {
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async{

    if(_userWorkSheet == null) return false;

   return await _userWorkSheet!.values.map.appendRows(rowList);
  }

  static Future<List<UserDataMModal>> getAllUsers() async {

    if(_userWorkSheet == null) return <UserDataMModal> [];
    final userData = await _userWorkSheet!.values.map.allRows(fromRow: 1,fromColumn: 1);
    return userData == null ? <UserDataMModal> [] : userDataMModalFromMap(json.encode(userData));
  }

  static Future<bool> update(String key,Map<String,dynamic> userData) async{

    if(_userWorkSheet == null) return false;

    return _userWorkSheet!.values.map.insertRowByKey(key, userData);
  }

  static Future<bool> delete(String key) async{

    if(_userWorkSheet == null) return false;

    final index = await _userWorkSheet!.values.rowIndexOf(key);

    if(index == -1) return false;

    return await _userWorkSheet!.deleteRow(index);
  }
}