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

$(document).ready(function(){
  $("#SubmitButton").click(function(){
    var email = $("#Email").val();
    var password = $("#Password").val();
    if(email != "" && password != ""){
      firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
        // Handle Errors here.
        // var errorCode = error.code;
        // var errorMessage = error.message;
        // ...
        var errorMessage = "The email or password you entered is incorrect";
        SignInError(errorMessage);
      });//email-password.html

      firebase.auth().onAuthStateChanged(function(user) {
        if (user) {
          // User is signed in.
          // var displayName = user.displayName;
          // var email = user.email;
          // var emailVerified = user.emailVerified;
          // var photoURL = user.photoURL;
          // var isAnonymous = user.isAnonymous;
          var uid = user.uid;
          $('.LoadingSymbol').hide().show();
            setTimeout(function(){
              location.href = "userTags.html"
            }, 1500);
          // var providerData = user.providerData;
          // ...
        } else {
          // User is signed out.
          // ...
          console.log("Not A user")
        }
      });//email-password.html
    }
  });

});


document.addEventListener('keydown', (e) => {
  if(e.code == 'Enter'){
    if($('#Email').val() != "" && $('#Password').val() != ""){
      //If both inputs are filled out
      var email = $("#Email").val();
      var password = $("#Password").val();
      if(email != "" && password != ""){
        firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
          // var errorCode = error.code;
          // var errorMessage = error.message;

          var errorMessage = "The email or password you entered is incorrect";
          SignInError(errorMessage);
        });

        firebase.auth().onAuthStateChanged(function(user) {
          if (user) {
            var uid = user.uid;
            $('.LoadingSymbol').hide().show();
            $('.ErrorLabel').hide();
              setTimeout(function(){
                location.href = "userTags.html"
              }, 1500);
          } else {

          }
        });//email-password.html
      }

    }else if($('#Email').val() != "" && $('#Password').val() == ""){
      // If Password is Empty
      var errorMessage = "You must fill out a Password";
      SignInError(errorMessage);
      $('#Email').focus();
    }else if($('#Email').val() == "" && $('#Password').val() != ""){
      // If Email is Empty
      var errorMessage = "You must fill out a Email";
      SignInError(errorMessage);
      $('#Email').focus();
    }else if($('#Email').val() == "" && $('#Password').val() == ""){
      // if email and password is empty
      var errorMessage = "You must fill out Email And Password";
      SignInError(errorMessage);
      $('#Password').focus();
    }
  }
});

function SignInError(errorMessage){
  $('.ErrorLabel').hide().show();
  $('.ErrorLabel').text(errorMessage);
}

function erroMessages(){
  if($('#Email').val() != "" && $('#Password').val() != ""){
    //If both inputs are filled out
    var email = $("#Email").val();
    var password = $("#Password").val();
    if(email != "" && password != ""){
      firebase.auth().signInWithEmailAndPassword(email, password).catch(function(error) {
        // var errorCode = error.code;
        // var errorMessage = error.message;

        var errorMessage = "The email or password you entered is incorrect";
        SignInError(errorMessage);
      });

      firebase.auth().onAuthStateChanged(function(user) {
        if (user) {
          var uid = user.uid;
          $('.LoadingSymbol').hide().show();
          $('.ErrorLabel').hide();
            setTimeout(function(){
              location.href = "userTags.html"
            }, 1500);
        } else {

        }
      });//email-password.html
    }

  }else if($('#Email').val() != "" && $('#Password').val() == ""){
    // If Password is Empty
    var errorMessage = "You must fill out a Password";
    SignInError(errorMessage);
    $('#Email').focus();
  }else if($('#Email').val() == "" && $('#Password').val() != ""){
    // If Email is Empty
    var errorMessage = "You must fill out a Email";
    SignInError(errorMessage);
    $('#Email').focus();
  }else if($('#Email').val() == "" && $('#Password').val() == ""){
    // if email and password is empty
    var errorMessage = "You must fill out Email And Password";
    SignInError(errorMessage);
    $('#Password').focus();
  }
}








var LoadingSymbolVisibility = false;
function LoadingSymbolVisibilityFunction(){
     if (LoadingSymbolVisibility == true) {
        document.getElementsByClassName("LoadingSymbol")[0].style.display = "block";
        document.getElementsByClassName("LoadingSymbol")[0].style.visibility = "visible";
      }else{
      document.getElementsByClassName("LoadingSymbol")[0].style.visibility = "hidden";
      document.getElementsByClassName("LoadingSymbol")[0].style.display = "none";
      }//else statement end bracket
      LoadingSymbolVisibility = !LoadingSymbolVisibility;
}// function end bracket


$(document).ready(function(){
  $('.ForgotPassword').click(function(){
    // Calls tje forgot password function
    forgotPassword();
  });
});
function forgotPassword(){
    var auth = firebase.auth();
    var emailAddress = $("#Email").val();
    auth.sendPasswordResetEmail(emailAddress).then(function() {
      // Email sent.
      console.log("Email Verification Sent");
    }).catch(function(error) {
      // An error happened.
      console.log("Email Verification Failed");
    });
}
