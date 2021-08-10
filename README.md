## 📱 Flutter 💙 to Google Sheets 📊

A Demo application which stores User feedback from **Flutter Application** into **Google Sheets** using **Google AppScript**.

![](https://github.com/PatilShreyas/Flutter2GoogleSheets-Demo/blob/master/images/banner.png)

## 💡 Introduction

- [Google Sheets](https://docs.google.com/spreadsheets/u/0/) is a very powerful tool 🔥 if we look into deep in it.

- It provides us interface using [*Google AppScript*](https://script.google.com) so that we can do various types of operations on Google Spreadsheet.

- We can perform all types of operations like Reading/Inserting/Updating/Deleting using AppScript on Google Sheets. It's so much powerful and capable that we can even use Google Sheets as a backend of our application 📲.

- Here we'll develop a sample flutter application, which simply takes user User Feedback, makes HTTP request to Google AppScript and AppScript then stores that feedback in Google Sheets.

- In other screen, we'll show feedback responses fetched from Google sheets into the List.

## ⚡️ Setting up Google Sheets:

- Sign in with your Google Account.
  
- Go to your [Google Drive](https://drive.google.com/drive/u/0/) and create a new ‘Google Sheets’ document where you want to store your responses and Open that.
  
- Setup **Header Columns** of sheet and you’ll see like this.

![](/2021-08-10%2019_07_16-Flutter%20Demo.png)

As above, I’ve set up header columns of the sheet. You can see I’ve highlighted part of the URL. It is the Sheet ID of our current document. Just copy it, we’ll require it in the next step. Every document has a unique Sheet ID.

- As in below Image, Just go to Tools → Script Editor.

![](https://miro.medium.com/max/806/1*9xO-QU68b9eXuZ5W7erzww.png)

##⚡️ Setting up Google AppScript:

- After the above steps, you’ll see AppScript Editor will be launched in the New Tab of your browser. You’ll see Code window like below.

![](2021-08-10%2019_11_53-Untitled%20project%20-%20Project%20Editor.png)

Here in this editor, we have to write AppScript which will act as a Web API and that will communicate with Google sheets.

We’ll write code in doPost() which will be invoked when HTTP request using method POST is sent.

```
function doPost(request){
  // Open Google Sheet using ID
  var sheet = SpreadsheetApp.openById("1OOArrqjOqmD4GiJOWlluZ4woTMH_qaV6RKv4JXnT3Hk");
  var result = {"status": "SUCCESS"};
  try{
    // Get all Parameters
    var name = request.parameter.name;
    var email = request.parameter.email;
    var mobileNo = request.parameter.mobileNo;
    var feedback = request.parameter.feedback;

    // Append data on Google Sheet
    var rowData = sheet.appendRow([name, email, mobileNo, feedback]);

  }catch(exc){
    // If error occurs, throw exception
    result = {"status": "FAILED", "message": exc};
  }

  // Return result
  return ContentService
  .createTextOutput(JSON.stringify(result))
  .setMimeType(ContentService.MimeType.JSON);
}
```

First of all, we’ll have to Open our spreadsheet, we can open that using `SpreadsheetApp.openById(sheetId)`

**Sheet ID** which we’ve copied in the previous step has to be passed in this method.

Here, we’ll retrieve parameters using `request.parameter` . Finally, by using a method `appendRow([])` , we’ll insert feedback data into Google Sheet. In the end, we’ll return a JSON response with status: `**SUCCESS/FAILED**`.

- Select from Button, **Deploy → New Deployment**

![](2021-08-10%2019_25_03-Settings.png)

It will show a pop-up like below, Click on Select type → Web App

![](2021-08-10%2019_28_18-Untitled%20project.png)

- You’ll see a window like this, Just ensure that select ‘Execute the app’ as ‘Me’.

![](2021-08-10%2019_30_28-Untitled%20project.png)

- Select ‘Who has access to the app’ as ‘Anyone’

![](2021-08-10%2019_33_07-Untitled%20project.png)

- Authorization is required! Just review permissions. Then select your Google Account.

- **Allow** these permissions and then you’re done!

![](2021-08-10%2019_42_23.png)

- Finally, you’ll get a window like this with the **Web app URL**. Copy that **`Web URL`** for a reference. We’ll use this `URL` for making `HTTP` `GET` requests from our flutter app.

![](2021-08-10%2019_33_57-Untitled%20project.png)

😃We’ve done this part. Let’s see Flutter implementation.

##

-  Now we’ll be implementing `doGet()` method which will return the list of feedback responses as JSON array of objects 😃.

Now, Just open your **Google AppScript** code again and just add a new method `doGet()` as below.

```
function doGet(request){
  // Open Google Sheet using ID
  var sheet = SpreadsheetApp.openById("1OOArrqjOqmD4GiJOWlluZ4woTMH_qaV6RKv4JXnT3Hk");

  // Get all values in active sheet
  var values = sheet.getActiveSheet().getDataRange().getValues();
  var data = [];

  // Iterate values in descending order 
  for (var i = values.length - 1; i >= 0; i--) {

    // Get each row
    var row = values[i];

    // Create object
    var feedback = {};

    feedback['name'] = row[0];
    feedback['email'] = row[1];
    feedback['mobile_no'] = row[2];
    feedback['feedback'] = row[3];

    // Push each row object in data
    data.push(feedback);
  }

  // Return result
  return ContentService
  .createTextOutput(JSON.stringify(data))
  .setMimeType(ContentService.MimeType.JSON);
}
```

Here’s a quick ⚡️ explanation for the above script:

- First of all, after opening Google Sheet, we’ve received all values.

- Then iterating data in descending order so that we’ll be able to see recent feedback item first.
  
- Adding each feedback to data.
  
- Finally returning data as a JSON.

## Deploy New version 🚀 :

- Once AppScript is ready, again deploy your AppScript by Selecting a tab: **Publish → Deploy as a web app**.

- Assign a new version to your app and click **‘Deploy’** 🚀.

- After that, you can check if it’s working or not by visiting that URL.

##

## Flutter Project Creation Guide

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

In flutter, when submit button is pressed, `HTTP` `POST` request is called on AppScript `URL` which retireves parameter from request and then appends row data in Google Sheets. Thus, data from flutter in inserted into Google Sheets. When `GET` request is sent to the same URL, it returns the List of feedback responses.

## ⚡️ Results

![](/Screenshot_20210810-185059.jpg)
![](/Screenshot_20210810-185112.jpg)

# Google Sheet Preview::

![](/2021-08-10%2019_02_10-Flutter%20App%20Script%20POC.png)