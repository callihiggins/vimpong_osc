class VimeoGrabber {
  //variables
  String userPhoto = " ";
  String userName = " ";
  String userID = " ";
  String user = " ";
  String url = "xmldocument.xml"; 
  String email = " ";



  //get photo URL

  String getuserPhoto() {
println(userPhoto);
    return userPhoto;
  }
  
  String getuserName() {
println(userName);
    return userName;
  }

  String getUser() {

    return userID;
  }

  VimeoGrabber() {
  }
  /* void requestUser(String email) {
   //Get all the HTML/XML source code into an array of strings
   //EVENTUALLY PUT IN A PROXY!!
   
   String url ="http://vimeo.com/api/rest/v2?method=vimeo.people.findByEmail&email=" + email;
   println(url);
   String[] lines = loadStrings(url);
   
   //turn array into one long string
   String feed = join(lines, " ");
   println(feed);
   // Searching for thumbnail link
   String lookfor =" <username>";
   String end = "</username>";
   userID = giveMeTextBetween(feed, lookfor, end);
   println(userID);
   }*/


  //Make the XML request
  void requestImage(String tempuser) {
    user = tempuser;
    println(user);
//    if (user.equals("3688170632")) {
//      user = "calli";
//    }
//    if (user.equals("3664708744")) {
//      user = "imagima";
//    }

    //Get all the HTML/XML source code into an array of strings
    //EVENTUALLY PUT IN A PROXY!!

    String url ="http://vimeo.com/api/rfid/" + user;
    println(url);
    
    String[] lines = loadStrings(url);

    //turn array into one long string
    String feed = join(lines, " ");

    // Searching for thumbnail link
    String lookfor1 ="<portrait_large>";
    String end1 = "</portrait_large>";
    userPhoto = giveMeTextBetween(feed, lookfor1, end1);
    
    // Searching for thumbnail link
    String lookfor2 ="<display_name>";
    String end2 = "</display_name>";
    userName = giveMeTextBetween(feed, lookfor2, end2);
  }

  // A function that returns a substring between two substrings
  String giveMeTextBetween(String s, String before, String after) {
    String found = "";
    int start = s.indexOf(before);    // Find the index of the beginning tag
    if (start == - 1) return"";       // If we don't find anything, send back a blank String
    start += before.length();         // Move to the end of the beginning tag
    int end = s.indexOf(after, start); // Find the index of the end tag
    if (end == -1) return"";          // If we don't find the end tag, send back a blank String
    return s.substring(start, end);    // Return the text in between
  }
}





