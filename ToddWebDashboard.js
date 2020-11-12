  // Your web app's Firebase configuration
  var firebaseConfig = {
    apiKey: "AIzaSyDJnxq7zqipMs8oVl8DpK0URsK0QlLb32Y",
    authDomain: "todd-1point0.firebaseapp.com",
    databaseURL: "https://todd-1point0.firebaseio.com",
    projectId: "todd-1point0",
    storageBucket: "todd-1point0.appspot.com",
    messagingSenderId: "1020057772233",
    appId: "1:1020057772233:web:664c29aa9d2c4a74e6ad18",
    measurementId: "G-0K75HV3D2G"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();

firebase.auth().onAuthStateChanged(function(user) {
    if(user){
      // User is signed in.
      var displayName = user.displayName;
        if(displayName != null){
            $('#UserName').text(displayName);
        }


      var email = user.email;
      if(email != null){
          $('.Email').attr('placeholder', email)
      }



      var emailVerified = user.emailVerified;
      var photoURL = user.photoURL;
      var isAnonymous = user.isAnonymous;
      var uid = user.uid;
      if(uid != null){
        $('#UserName').text(uid);
        // firebase.initializeApp()
        const db = firebase.firestore();
        var docRef = db.collection("User").doc(uid);
        docRef.get().then(function(doc) {
            if (doc.exists) {
                console.log("Document data:", doc.data());
            } else {
                // doc.data() will be undefined in this case
                console.log("No such document!");
            }
        }).catch(function(error) {
            console.log("Error getting document:", error);
        });


        var docRef = db.collection("User").doc(uid);

    }
      var providerData = user.providerData;
      // ...
    } else {
    // if the user isn't already Signed in then it takes them back to the authentification page
      location.href="ToddWebSignIn.html";
    }
  });


$(document).ready(function(){
    $('#SignOut').click(function(){
    firebase.auth().signOut().then(function() {
        // Sign-out successful.
        location.href="ToddWebSignIn.html";
      }).catch(function(error) {
        // An error happened.
      });
    });
});

$(document).ready(function(){
    $('.AddButton').click(function(){
        location.href = "ToddNewProject.html"
    });

    $('.AddNewProjectAcrossTabsButton').click(function(){
        location.href = "ToddNewProject.html"
    });

});



$(document).ready(function(){
    $('.Main').click(function(){
        $('.ToolsBoard').hide();
        $('.AnalyticsBoard').hide();
        $('.UserBoard').hide();
        $('.PayBoard').hide();
        $('.UpdatesNewProjectsDiv').show();

        $('#Main').attr("src", "DashBoardUI/blueHome.png");
        $('#Analytics').attr("src", "DashBoardUI/GrayAnalytics.png");
        $('#Pay').attr("src", "DashBoardUI/GrayCard.png");
        $('#Tools').attr("src", "DashBoardUI/GrayTools.png");
        $('#User').attr("src", "DashBoardUI/GrayUser.png");

        $('.MenuLabels').css({
            "color":"rgb(95, 95, 95)"
        });

        $('.MenuLabels').eq(0).css({
            "color":"#428FFF"
        });

    });


    $('.Analytics').click(function(){
        $('.ToolsBoard').hide();
        $('.UpdatesNewProjectsDiv').hide();
        $('.UserBoard').hide();
        $('.PayBoard').hide();
        $('.AnalyticsBoard').show();


        $('#Main').attr("src", "GrayHome.png");
        $('#Analytics').attr("src", "BlueAnalytics.png");
        $('#Pay').attr("src", "GrayCard.png");
        $('#Tools').attr("src", "GrayTools.png");
        $('#User').attr("src", "GrayUser.png");

        $('.MenuLabels').css({
            "color":"rgb(95, 95, 95)"
        });

        $('.MenuLabels').eq(1).css({
            "color":"#428FFF"
        });

    });



    $('.Tools').click(function(){
        $('.AnalyticsBoard').hide();
        $('.UpdatesNewProjectsDiv').hide();
        $('.UserBoard').hide();
        $('.PayBoard').hide();
        $('.ToolsBoard').show();


        $('#Main').attr("src", "DashBoardUI/GrayHome.png");
        $('#Analytics').attr("src", "DashBoardUI/GrayAnalytics.png");
        $('#Pay').attr("src", "DashBoardUI/GrayCard.png");
        $('#Tools').attr("src", "DashBoardUI/BlueTools.png");
        $('#User').attr("src", "DashBoardUI/GrayUser.png");

        $('.MenuLabels').css({
            "color":"rgb(95, 95, 95)"
        });

        $('.MenuLabels').eq(2).css({
            "color":"#428FFF"
        });

    });


    $('.User').click(function(){
        $('.AnalyticsBoard').hide();
        $('.UpdatesNewProjectsDiv').hide();
        $('.ToolsBoard').hide();
        $('.PayBoard').hide();
        $('.UserBoard').show();


        $('#Main').attr("src", "DashBoardUI/GrayHome.png");
        $('#Analytics').attr("src", "DashBoardUI/GrayAnalytics.png");
        $('#Pay').attr("src", "DashBoardUI/GrayCard.png");
        $('#Tools').attr("src", "DashBoardUI/GrayTools.png");
        $('#User').attr("src", "DashBoardUI/BlueUser.png");

        $('.MenuLabels').css({
            "color":"rgb(95, 95, 95)"
        });

        $('.MenuLabels').eq(3).css({
            "color":"#428FFF"
        });

    });



    $('.Pay').click(function(){
        $('.AnalyticsBoard').hide();
        $('.UpdatesNewProjectsDiv').hide();
        $('.ToolsBoard').hide();
        $('.UserBoard').hide();
        $('.PayBoard').show();


        $('#Main').attr("src", "DashBoardUI/GrayHome.png");
        $('#Analytics').attr("src", "DashBoardUI/GrayAnalytics.png");
        $('#Pay').attr("src", "DashBoardUI/BlueCard.png");
        $('#Tools').attr("src", "DashBoardUI/GrayTools.png");
        $('#User').attr("src", "DashBoardUI/GrayUser.png");


        $('.MenuLabels').css({
            "color":"rgb(95, 95, 95)"
        });

        $('.MenuLabels').eq(4).css({
            "color":"#428FFF"
        });

    });
    
});



$(document).ready(function(){
    $('.ProfileImage').click(function(){

    })
});

var UserProfilePic = new Array();
/// Requesting Immagine files from user here:
Array.prototype.forEach.call(document.querySelectorAll('.ProfileImage'), function(button){
    const ImageInput = button.parentElement.querySelector('#ImageFiles');
    // const ImageLabel = button.parentElement.querySelector('#ImageUploadLabel');

    button.addEventListener('click', function(){
      ImageInput.click();
      // ImageLabel.Title = NumberOfFileSelected(0);
    });
    ImageInput.addEventListener('change', function(){
        UserProfilePic = Array.prototype.map.call(ImageInput.files, function(file){
        return URL.createObjectURL(file);
      });
      $('.ProfileImage').attr('src' , UserProfilePic[0])
      $('#UserIdImage').attr('src' , UserProfilePic[0])
    });
  });