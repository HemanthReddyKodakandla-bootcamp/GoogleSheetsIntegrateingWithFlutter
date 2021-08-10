# flutter_app_script_example

A Demo application which stores User feedback from Flutter application into Google Sheets using Google AppScript.

## Introduction

- [Google Sheets](https://docs.google.com/spreadsheets/u/0/) is a very powerful tool 🔥 if we look into deep in it.

- It provides us interface using Google AppScript so that we can do various types of operations on Google Spreadsheet.

- We can perform all types of operations like Reading/Inserting/Updating/Deleting using AppScript on Google Sheets. It's so much powerful and capable that we can even use Google Sheets as a backend of our application 📲.

- Here we'll develop a sample flutter application, which simply takes user User Feedback, makes HTTP request to Google AppScript and AppScript then stores that feedback in Google Sheets.

- In other screen, we'll show feedback responses fetched from Google sheets into the List.

##

- A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## ⚡️ Project Files

- [Flutter Application](https://github.com/HemanthReddyKodakandla-bootcamp/GoogleSheetsIntegrateingWithFlutter) - Flutter Application Code.

- [AppScript Code](https://github.com/HemanthReddyKodakandla-bootcamp/GoogleSheetsIntegrateingWithFlutter/blob/master/code.gs) - Google AppScript code to deploy as Web app for interface between Flutter app and Google sheet.

## What's Happening? 🤔

In flutter, when submit button is pressed, HTTP POST request is called on AppScript URL which retireves parameter from request and then appends row data in Google Sheets. Thus, data from flutter in inserted into Google Sheets. When GET request is sent to the same URL, it returns the List of feedback responses.
