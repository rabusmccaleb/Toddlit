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
  firebase.storage();

firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
      // User is signed in.
      var displayName = user.displayName;
      if(displayName != null){
        $('#DefaultAuthor').text("By: " + displayName);
      }
      var email = user.email;
      var emailVerified = user.emailVerified;
      var photoURL = user.photoURL;
      var isAnonymous = user.isAnonymous;
      var uid = user.uid;
      getStoryData("fDyR0AzCjg4MlRWFvFIR")
      if(uid != null){
          // $('#UserName').text(uid);
      }
      var providerData = user.providerData;
      // ...
    } else {
    // if the user isn't already Signed in then it takes them back to the authentification page
      location.href="ToddWebSignIn.html";
    }
  });


var BasicDataModel = {
  "RefID" : "noRefID",
  "StoryTitle" : "",
  "coverImageRef" : "",
  "Artists" : [],
  "Summary" : "",
  "Tags" : [],
  "isPublished" : false,
  "uid" : "",
};


var ContentDataModel = {
  "Art" : {},
  "Animation" : {},
  "RecordedAudio" : {},
  "StoryMusic" : {},
  "SFX" : {},
  "StoryText" : {},
};


getTransferStory();

function getTransferStory(){
  firebase.auth().onAuthStateChanged(function(user) {
      if(user){
        var db = firebase.firestore();
        var UserId = ""+ user.uid + "";
        UserID = UserId;
        var userProfileRef = db.collection("CreativeUsers").doc(UserId);

        userProfileRef.get().then(function(doc) {
          if (doc.exists) {
              var data = doc.data();
              if(data.isTransferStory == true){
                getTransferStoryContent(data.transferStory);
              }
          } else {
              console.log("No Transfer Script!");
          }
        }).catch(function(error) {
        console.log("Error getting document:", error);
        });
        // ...
      } else {
      // if the user isn't already Signed in then it takes them back to the authentification page
        location.href="../SignIn/ToddWebSignIn.html";
      }
    });

}

var transferBasicStoryData;
function getTransferStoryContent(refID){
        var db = firebase.firestore();
        var storyRef = db.collection("Stories").doc(refID);
        storyRef.get().then(function(doc) {
          if (doc.exists) {
            var data = doc.data();
            transferBasicStoryData = data;
            getTransferStoryContent(refID);
            console.log("StoryData :" + data);
          } else {
              console.log("No Transfer Story!");
          }
        }).catch(function(error) {
        console.log("Error getting document:", error);
        });
}


var transferStoryDataObjects;
function getTransferStoryContent(refID){
  var db = firebase.firestore();
  var storyRef = db.collection("Stories").doc(refID).collection("StoryContent");
  storyRef.get().then(function(querySnapshot) {
  querySnapshot.forEach(function(doc) {
    var data = doc.data();
    transferStoryDataObjects = data;
    console.log("StoryData :" + data);
  })
  }).catch(function(error) {
  console.log("Error getting document:", error);
  });
}



var UserID;

function UpdateData(){
    var user = firebase.auth().currentUser;
    firebase.auth().onAuthStateChanged(function(user) {
        // Checking if there is a user sign in...
        if(user){
            var db = firebase.firestore();
            var UserId = ""+ user.uid + "";
            UserID = UserId;
            var submittedRef = db.collection("Stories").doc("" + BasicDataModel.RefID + "");

            // Set the "capital" field of the city 'DC'
        submittedRef.get().then(function(doc) {
            if(doc.exists){
            return userProfileRef.update({
                RefID : BasicDataModel.RefID,
                StoryTitle : BasicDataModel.StoryTitle, // defualt to private
                coverImageRef : BasicDataModel.coverImageRef,
                Artists : BasicDataModel.Artists,
                Summary : BasicDataModel.Summary,
                Tags : BasicDataModel.Tags,
                isPublished : BasicDataModel.isPublished,
                UID : UserID,


            })
            .then(function() {
                console.log("Document successfully updated!");
            })
            .catch(function(error) {
            });

            }else{
              // The document probably doesn't exist.
              console.error("Error updating document: ", error);
              // Checking again before updateing document if the user is sign ind
            }

          }).catch(function(error) {
            console.log("Error getting document:", error);

            var user = firebase.auth().currentUser;

            if (user){
                var UserId = ""+ user.uid + "";

                var db = firebase.firestore();
                db.collection("Stories").add({

                  RefID : BasicDataModel.RefID,
                  StoryTitle : BasicDataModel.StoryTitle, // defualt to private
                  Artists : BasicDataModel.Artists,
                  Summary : BasicDataModel.Summary,
                  Tags : BasicDataModel.Tags,
                  isPublished : BasicDataModel.isPublished,
                })

                .then(function(docRef) {
                    console.log("Usere Profile Info has been updated!");
                    // Updating Document reference if the document was added successfully
                    BasicDataModel.RefId = docRef.id;
                    userStoryDataModel.RefId = docRef.id;
                    //// Adding the rest of the script data to the back end :

                    var db = firebase.firestore();
                  db.collection("Stories").doc(docRef.id).collection("StoryContent").add({



                    Art : ContentDataModel.Art,
                    Animation : ContentDataModel.Animation,
                    RecordedAudio : ContentDataModel.RecordedAudio,
                    StoryMusic : ContentDataModel.StoryMusic,
                    SFX : ContentDataModel.SFX,
                    StoryText : ContentDataModel.StoryText,

                    })

                    updateUsersRef();

                    var userRef = db.collection("Stories").doc(BasicDataModel.RefId);

                    return userRef.update({
                        RefId : BasicDataModel.RefId,
                    })
                    .then(function() {
                        console.log("updated Story ref id");
                    })
                    .catch(function(error) {
                      console.log("Error");
                    });


                })




                // if there is an error below now then there was no document to update and the there was an error adding a document
                .catch(function(error) {
                    console.error("Error writing document: ", error);
                });
            }// here is the end


          });

        }
    });

  }




var userStoryDataModel = {
  "RefId" : BasicDataModel.RefId,
  "Collection" : "Stories"
};


function updateUsersRef(){
  var user = firebase.auth().currentUser;
  firebase.auth().onAuthStateChanged(function(user) {
    var db = firebase.firestore();
    var UserId = ""+ user.uid + "";
      // Checking if there is a user sign in...
      if(user){
        var db = firebase.firestore();
        db.collection("CreativeUsers").doc(UserId).collection("Stories").add({
          "RefId" : userStoryDataModel.RefId,
          "Collection" : "Stories"
        });
      }

    });

  }




  var requestedStoryBasicData;
  var requestedStoryContentData;
  function getStoryData( docID ){
      // This function is for grabbing all of the scripts content from the backend so that the user can edit it and make use
      //
      var user = firebase.auth().currentUser;
      firebase.auth().onAuthStateChanged(function(user) {
          // Checking if there is a user sign in...
          if(user){

            var db = firebase.firestore();
            var UserId = ""+ user.uid + "";
            UserID = UserId;
            var storyRef = db.collection("Stories").doc("" + docID + "");

            storyRef.get().then(function(doc){
              if(doc.exists){
                requestedStoryBasicData = doc.data();
                console.log(requestedStoryBasicData);

                // making a request for the script content like dialogue, slugs, etc.
                var scriptContentData = db.collection("Stories").doc(docID).collection('StoryContent');
                scriptContentData.get().then(function(querySnapshot){

                querySnapshot.forEach(function(doc) {
                    requestedStoryContentData = doc.data();
                    console.log(requestedStoryContentData);
                  });
                })

              }else{
                console.log("No Such Document error: Ln222")
              }
            }).catch(function(){

            });

          }else{

          }// end of if(user)else statement

        });// end of AuthClosure
  }// end of function





// $(document).ready(function(){
// // Create a storage reference from our storage service
// var db = firebase.firestore();
// db.collection("Stories").doc('W3H0M76e40U8CFSnFpV8').get().then(function(doc) {
//   if (doc.exists) {
//       console.log("Document data:", doc.data());

//       $('#summary').attr('placeholder', doc.data().Summary);

//       $('#DemoImage').attr('src', doc.data().coverImage);

//   } else {
//       console.log("No such document!");
//   }
// }).catch(function(error) {
//   console.log("Error getting document:", error);
// });
// });





// var Image = storageRef.child('Stories').child().child('coverImage');

// Image.getDownloadURL().then(function(url) {
//   const firebase = require("firebase");
// // Required for side-effects
// require("firebase/firestore");
//   // `url` is the download URL for 'images/stars.jpg'

//   // This can be downloaded directly:
//   var xhr = new XMLHttpRequest();
//   xhr.responseType = 'blob';
//   xhr.onload = function(event) {
//     var blob = xhr.response;
//   };
//   xhr.open('GET', url);
//   xhr.send();

//   // Or inserted into an <img> element:
//   var img = $('#DemoImage');
//   img.src = url;
// }).catch(function(error) {
//   // Handle any errors
// });


// });










///File Upload:
const UploadModalExplainerElement = document.getElementById("ModalExplaination");
const UploadModalExplainer = "Before you can begin to construct your story you need your Art Work, Recording of the story read out loud and the script so that your audience can read along with you.";
var ThisIsANewProject = true;// default to true so the popup to upload files appears. If this is a saved project it will be set to false such that if this is a saved projec no files are needed on upload because they will have been saved on the server.
const BackgroundModalCover = document.getElementById("BackgroundModalCover");
const UploadModal = document.getElementById("UploadModal");
var ImmagineArray = new Array();
var DiscorsoArray = new Array();
var MusicArray = new Array();
var SFXArray = new Array();
var TextArray = new Array();
var SelectionArtWidth = 0 ;
var NewProjectInitalizationFlag = false; /// this is to set up functionality when the project is started. default to false but on load set to true after the confirm art button
var StoryContent = $('.StoryContent');


// var UserAudio = navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
// const AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.oAudioContext || window.msAudioContext;/// looking for the proper audio context
// const context = new AudioContext();
// const AudioNode = context.createAnalyser();
// context.destination;

// navigator.mediaDevices.getUserMedia({ audio: true, video: false })
// .then(handleSuccess);


// var AudioRecorder = new WebAudioRecorder(sourceNode, configs)

function viewDidLoad(){
  $('.MobileError').hide(0);
  //1. Will Check if this is a new project
  CheckIfThisIsANewProject();
  // 2. checking to see if this on mobile to return no mobile error
  LoadingPage();
  // 3. Adding th Animation Objects
  InitializeAnimationObjects();
  InitializeSFXObjects();
}

function DroppableObjectInitialization(){
  // the major problem with droppabel object was the fact that they weren't being initailized.
  // They needed to be called and created after the divs were created on the DOM object
  InitializeAnimationDroppable();
  InitializeAudioDroppable();
  InitializeSFXDroppable();
  InitializeTextDroppable();
  }// Droppable Object Initalization end bracket // Droppable Object Initalization end bracket

  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
  // Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert: Page Leave Alert:
// Asking the user if they want to leave the page before saving it doesn't ask specifically if they want to save before leaving the window but it ideally should make them consider it:
    window.onbeforeunload = function(){return true};
    window.onbeforeunload = function(evt) {
      var message = 'Are you sure you want to leave this page?';
      if (typeof evt == 'undefined') {
          evt = window.event;
      }
      if (evt) {
          evt.returnValue = message;
      }
      return message;
    }

function AlertFunction(text){
  // Make Text equal to the alert label:
  $('.AlertLabel').text(text);
  // Animate Alert label down
  $('.AlertCard').hide().fadeIn(0).animate({top : "5vh"}, 500, function(){
      setTimeout(function(){
        $('.AlertCard').animate({top : "-5vh"}, 500).fadeOut();
      },  2000 );
    });
}


$(document).ready(function(){
  $('.logo').click(function(){
    location.href = "ToddWebDashboard.html";
  });
});



function shuffle(array){
	var currentIndex = array.length;
	var temporaryValue, randomIndex;
	// While there remain elements to shuffle...
	while (0 !== currentIndex) {
		// Pick a remaining element...
		randomIndex = Math.floor(Math.random() * currentIndex);
		currentIndex -= 1;
		// And swap it with the current element.
		temporaryValue = array[currentIndex];
		array[currentIndex] = array[randomIndex];
		array[randomIndex] = temporaryValue;
	}
	return array;
};


function LoadingPage(){
  setTimeout(function(){
  var ArrayOfPercentages = [25, 33 , 8 , 15, 39];
  shuffle(ArrayOfPercentages);
  shuffle(ArrayOfPercentages);
  shuffle(ArrayOfPercentages);
  var percentage = ArrayOfPercentages[0] + "%"
  $('.LoadProgressBar').css({"width" : percentage });
  // 1. Checking if the user is on mobile:
  if(isMobile() == true || isOnMobile() == true || isTablet == true){
    setTimeout(function(){
    $('.LoadProgressBar').css({"width" : "100%"});
    $('.LoadDiv').fadeOut(300,function(){
          $('.MobileError').fadeIn(300);
      });
    }, 300);
   }else{
     LoadSuccess(true);
   }
  }, 500);
}


function LoadSuccess(Checkifsuccess){
  setTimeout(function(){
       // should check if this is a new project vs an old project to load data
       if(Checkifsuccess == true){
         //this is to check if the microphone question has been answerd before loading progress bar acn moove on
        $('.LoadProgressBar').css("width" , "100%");
        setTimeout(function(){
          $('.LoadDiv').fadeOut(1000,function(){
                $('.LoadPage').fadeOut(1100);
            });
          }, 500);
        }
    }, 500);
}



function isOnMobile() {
  var check = false;
  (function(a){
    if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))
      check = true;
  })(navigator.userAgent||navigator.vendor||window.opera);
  return check;
};

function isMobile(){
  var check = false;
  (function(a){
      if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))
          check = true;
  })(navigator.userAgent||navigator.vendor||window.opera);
  return check;
}
// from stack overflow : https://stackoverflow.com/questions/50195475/detect-if-device-is-tablet
const userAgent = navigator.userAgent.toLowerCase();
const isTablet = /(ipad|tablet|(android(?!.*mobile))|(windows(?!.*phone)(.*touch))|kindle|playbook|silk|(puffin(?!.*(IP|AP|WP))))/.test(userAgent);





function CheckIfThisIsANewProject(){
  // if (ThisIsANewProject == true){
  //   UploadModal.style.display = "block";
  //   BackgroundModalCover.style.display = "block";
  //   UploadModalExplainerElement.innerHTML = UploadModalExplainer
  // }else{
  //   UploadModal.style.display = "none";
  //   BackgroundModalCover.style.display = "none";
  // }
}



// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality
// Data Model functionality// Data Model functionality// Data Model functionality// Data Model functionality

var storyData = new Array();

function addCreatedStoryData(){
  storyData.push(createStoryDataObject());
  console.log(storyData);
}

function createStoryDataObject(){
  var StoryDataObject = {
    "index" : "",

    "ArtData" : {
      "url": "",
      "defualtRunTime" : 5000,// default time is 5 sec
      "blendMode" : 0, // default to zero which is just normal which is nothing
      "colorHSVA" : {
        "h" : "0",
        "s" : "0",
        "v" : "0",
        "a" : "0",// default to transparent
      },
      "colorHEXA" :"transparent",// default to transparent

    },

    "AnimationData" : {
      "animationStyle" : "",
      "animationTypeText" : "No Animation",
      "animationFunctionValue" : null,
      "speed" : 0,// default to five such that it only moves from the midway point if the value is changed/ updated
      "displacement" : 0,// default to five such that it only moves from the midway point if the value is changed/ updated
      "attack" : 0,// default to five such that it only moves from the midway point if the value is changed/ updated
      "startTime" : "",
      "vibrationOn" : false,
    },

    "RecordingData" : {
      "url" : "",
      "volume" : 0, // default to five such that it only moves from the midway point if the value is changed/ updated
    },


    "StoryText" : {
      "character" : "",
      "dialogue" : "",
      "font" : "",
    },
  }


  return StoryDataObject;
}


var storyMusicData = new Array();
var storySFXData = new Array();
function createMusicAndSFXDataObject(){
  var MusicAndSFXObject =
  {
    "StoryMusicData" : {
        "ref" : "",// has ref because the audio is stored on the backend
        "posIndex" : "",
        "volume" : "",// this has to deal with regualr volume controls... the peak volume for this object
        "isStarting" : "",
        "isEnding" : "",
        "introTaper" : 0,
        "endTaper" : 0,
        "volumeControls" : "",// default to nothing but can and will be updated for differeing play stylesheet... this has more to do with the intensity graph of the object
        "panning" : "", //for panning styles... for better story telling
        "panningStyle" : "",// for panning timing and attack stuff like that... for better story telling
      },


      "SFXData" : {
        "ref" : "",// has ref because the audio is stored on the backend
        "posIndex" : "",
        "volume" : "",// this has to deal with regualr volume controls... the peak volume for this object
        "isStarting" : "",
        "isEnding" : "",
        "introTaper" : 0,
        "endTaper" : 0,
        "volumeControls" : "",// default to nothing but can and will be updated for differeing play stylesheet... this has more to do with the intensity graph of the object
        "panning" : "", //for panning styles... for better story telling
        "panningStyle" : "",// for panning timing and attack stuff like that... for better story telling
      },
    }

    return MusicAndSFXObject;
}




// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:
// User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid: User Upload Image and add grid:

var ArtArray = new Array();
function ArtUpload(src, ArtSelectionIndex, ArtWorkStationIndex){
    var artData = {
        "ArtSrc" : src,
        "ArtTitolo" : (ArtWorkStationIndex + 1) + ".jpg",
        "ArtSelectionIndex" : ArtSelectionIndex,
        "ArtWorkStationIndex" : ArtWorkStationIndex,
      }
      ArtArray.push(artData);
  }

/// Requesting Immagine files from user here:
    Array.prototype.forEach.call(document.querySelectorAll('.ImmagineUploadButton'), function(button){
      const ImageInput = button.parentElement.querySelector('#ImageFiles');
      // const ImageLabel = button.parentElement.querySelector('#ImageUploadLabel');

      button.addEventListener('click', function(){
        ImageInput.click();
        // ImageLabel.Title = NumberOfFileSelected(0);
      });
      ImageInput.addEventListener('change', function(){
        ImmagineArray = Array.prototype.map.call(ImageInput.files, function(file){
          return URL.createObjectURL(file);

        });

        PlacingArtToBeSortedUntoImmagineUploadStation();
      });
    });



  function PlacingArtToBeSortedUntoImmagineUploadStation(){
      for(x = 0; x < ImmagineArray.length; x++){
              // 1. Getting the uploaded data:
              var ArtUploadStationImages = $(' <li class="UploadArtLi"><img class="UploadArtArt" src="' + ImmagineArray[x] + '"></li>');
              // 2. Appending Art to the appropriate classes and adding a fading animation to them
              ArtUploadStationImages.appendTo(".UlArtSortableList").hide().fadeIn(1500, function(){});
              // 3. Created a StoryDataObject and push it on the StoryData array:
              addCreatedStoryData();
            }
              // 3. Displaying Confirmation Button:
              DisplayArtUploadStationConfrimButton();
              initializeUploadLi();
    }

  var uploadLiClickIndex;
  function initializeUploadLi(){
    $('.UploadArtLi').click(function(){
      $('.UploadArtLi').css({
        'border'  : 'transparent solid 0.3vh',
      })

      $(this).css({
        'border'  : 'white solid 0.3vh'
      })

      uploadLiClickIndex = $(this).index();
    });

    $('.ImmagineRemoveButton').click(function(){
      $('.UploadArtLi').eq(uploadLiClickIndex).remove();
      ImmagineArray.splice(uploadLiClickIndex , 1);
    });
  }


    function DisplayArtUploadStationConfrimButton(){
      // 1. Making the Upload Station Confirmation Button visible:
          // checking if the buttons are visible:
      if($(".ImmagineUploadStationConfirmButton").is(":hidden") && $(".ImmagineRemoveButton").is(":hidden")){
        $(".ImmagineUploadStationConfirmButton").css("display", "block").hide(0).fadeIn(3000);
        $(".ImmagineRemoveButton").css("display", "block").hide(0).fadeIn(3000);

      }
    }

    $(document).ready(function(){
      $(".ImmagineUploadStationConfirmButton").click(function(){
        $(".ArtUploadModal").toggle(300, function(){
          // 3. Placing all the art unto the WorkStation
               // $('#BackgroundModalCover').hide(0);
               pullScriptData();
        });
        PlaceImageInPlace();

      });


      $('.ConfirmScriptTextButton').click(function(){
        $('.UploadTextStation').toggle(300, function(){
          // $('#BackgroundModalCover').fadeOut(300).hide(0);
          // will call the apperearence of the text splicing station
        });
      });


      $('.WriteScriptTextButton').click(function(){
        // eventually an alert confiriming that they would like to go to the script writer
          transferScriptRefUpdate(scriptRef = "" , scriptBool = false);

      });


});


function transferScriptRefUpdate(scriptRef, scriptBool){
  var user = firebase.auth().currentUser;
  firebase.auth().onAuthStateChanged(function(user) {
      // Checking if there is a user sign in...
      if(user){
          var db = firebase.firestore();
          var UserId = ""+ user.uid + "";
          UserID = UserId;
          var userProfileRef = db.collection("CreativeUsers").doc(UserId);


          return userProfileRef.update({
                transferScript: scriptRef,
                isTransferScript: scriptBool
              })
              .then(function() {
                location.href = 'ScriptWriter/ToddScriptWriter.html';
                console.log("Document successfully updated!");
              })
              .catch(function(error) {
                // The document probably doesn't exist.
                console.error("Error updating document: ", error);
              });

        }else{
          console.log('User Not Auth')
        }

      });

}




  var oldScripts = [];
  function pullScriptData(){
      if(oldScripts.length <= 0){
        var user = firebase.auth().currentUser;

        firebase.auth().onAuthStateChanged(function(user){
          var db = firebase.firestore();
          var UserId = "" + user.uid + "";
          var docRef = db.collection("CreativeUsers").doc(UserId).collection("Scripts");

          docRef.get().then(function(querySnapshot) {
          querySnapshot.forEach(function(doc) {
              var createdScriptsData = {
                "id" : doc.id,
                "ScriptData" : doc.data(),
              }
              oldScripts.push(createdScriptsData);
              console.log(oldScripts);
              placingCreatedScripts();
          });
        });
        })
      }
    }



  function placingCreatedScripts(){
      var AppendLoaction  = $('.ScriptsDiv');
      if(oldScripts.length > 0){
        $('.noScipts').hide();
        var objectLoc = oldScripts.length - 1;
        var title = oldScripts[ objectLoc ].ScriptData.Title;
        console.log(title);
        var id = oldScripts[ objectLoc ].id;
        console.log(id);
        console.log(creatExistingScriptObject(Title = title, ProjectId = id))
        AppendLoaction.append( creatExistingScriptObject(Title = title, ProjectId = id) ).toggle().fadeIn(500);
        intializeProjectCard();
      }
  }


  function creatExistingScriptObject(Title, ProjectId){
      var title = Title;
    // the project id is there to be placed on the back end so that when a user re-opens a project or script we can pull the data fromt the object, by simply pushing it to the back end and pulling it on request

      var projectLabel = '<label class="ProjectLabel">'+ title +'</label>';
      var projectLabelDiv = '<div class="ProjectLabelDiv">'+ projectLabel +'</div>';
      var imgProject ='<img src="typewriter.png" class="UIProject" draggable="false">';
      var projectUIDiv = '<div class="UIProjectDiv">' + imgProject + '</div>';
      var projectVStack = '<div class="ProjectVStack">'+ projectUIDiv + projectLabelDiv +'</div>';
      var projectCard =   '<div class="ProjectCard">'+ projectVStack +'</div>';
      var projectDiv = '<div class="Project" id="'+ ProjectId +'">'+ projectCard +'</div>';

      var wholeObject = projectDiv;
      return wholeObject;

    }

  function intializeProjectCard(){
      var projectCard = $('.Project');
      $('.Project').click(function(){
        var index =  $(this).index() - 1 ;
        console.log(index);
        var ref = oldScripts[index].ScriptData.RefId;
        console.log(ref);
        pullScriptContent(ref);
        $('.UploadTextStation').fadeOut(300);

        $('#title').val(oldScripts[index].ScriptData.Title);
        $('#summary').text(oldScripts[index].ScriptData.Summary);
        myRecorder.init();

      });
    }


    var DialgoueData = new Array();
    var requestedScriptContentData;
    function pullScriptContent(refId){
  var user = firebase.auth().currentUser;
  firebase.auth().onAuthStateChanged(function(user) {
    if(user){
        var db = firebase.firestore();
        var UserId = ""+ user.uid + "";
        // making a request for the script content like dialogue, slugs, etc.
        var scriptContentData = db.collection("CreativeUsers").doc(UserId).collection("Scripts").doc("" + refId + "").collection('ScriptContent');
        scriptContentData.get().then(function(querySnapshot){
        querySnapshot.forEach(function(doc) {
          requestedScriptContentData = [];
          RemoveData();
          DialgoueData = [];
          ScriptCurrentDataCounter = 0;
          choosenAudioArray = [];
          requestedScriptContentData = doc.data();
          console.log(ScriptCurrentDataCounter);
            PassScriptDataNextView();
            callScriptCardUpdater();
            resetAllData();

        });
      });
    }else{
      console.log("Didin't find Script");
    }

  });
}

    function RemoveData(){
  $('.RecordedObjectsHstack').children('div').each(function(){
    $(this).remove();
  });
}


    function PlaceImageInPlace(){
       //https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/file
       console.log("Image Array: " + ImmagineArray.length)
       for(x = 0 ; x < ImmagineArray.length; x++){
          // 0 . Getting the src data from the immagine upload objects
          var src = $('.UploadArtLi').eq(x).children().first().attr('src');
          // 1. Creating, Appending, and Intializing InitializeAnimationDroppable Div:
          AppendingStoryContentDiv(ImmagineArray[x]);
          SetArt();
          // 3. Sending, Appending, and Intializing all art to the Selection Board:
          var SelectionArt = $('<input type="image" class="ArtSelectObject" src="' + ImmagineArray[x] + '" alt="ImageTitle" onclick="" draggable="false">');
          SelectionArt.appendTo(".SelectableArt");
          InitializeArtSelection();
          ArtUpload(src = src , ArtSelectionIndex = x , ArtWorkStationIndex = x );
        }
      // 8. Initializing the Droppable Objects:
        DroppableObjectInitialization();
        SetArt();
    }


//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:
//User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso: User Upload Discorso:
// And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station: And Splicing Discorso Station:

  Array.prototype.forEach.call(document.querySelectorAll('#DiscorsoUploadButton'), function(button){
    const DiscorsoInput = button.parentElement.querySelector('#DiscorsoFiles');

    const ImageInput = button.parentElement.querySelector('#ImageFiles');


    button.addEventListener('click', function(){
      DiscorsoInput.click()
    });


    DiscorsoInput.addEventListener('change', function(){
      DiscorsoArray = Array.prototype.map.call(DiscorsoInput.files, function(file){
        return URL.createObjectURL(file);
      });
      // PlaceImageInPlace();
    });
  });




    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
    // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :
  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :  // Assemble StoryContent :

  function AppendingStoryContentDiv(Art){
    var StoryContent = AssembleStoryContent(Art);
    StoryContent.appendTo('.WorkStationDiv').hide().fadeIn(2000, function(){});

    // Also appending the grid music and sfx objects:
    var musicheGrid = '<div class="MusicheGridMusic"></div>';
    var sfxGrid = '<div class="SFXGrid"></div>';



    $('.MusicheStation').append(musicheGrid);
    $('.SfxStation').append(sfxGrid);

    // this if statement and all of it's functionality is for to tigger the first image to appear on load
    if (ArtIndex == null){
      $("#DemoImage").fadeOut(1800, function(){
          $("#DemoImage").hide();
          NewProjectInitalizationFlag = true;
          $('.StoryContent').eq(0).find('.Art').trigger('click');
      });

    }
    // initializing droppables :
    InitializeAnimationDroppable();
    InitializeSFXDroppable();

    $('.WorkStationDiv').sortable({
      axis : "x",
      handle : '.StoryContentHandel',
      stop : function(event , ui) {
            ArtIndex = ui.item.index();
            console.log(ArtIndex);
           // SelectedArtItems();
            $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
        }

    });
  }

  function AssembleStoryContent(Art){
    // 1. Create A New Story Content Div
    var StoryContentDiv = $($.parseHTML('<li class="StoryContent">'+ CreateGridStationDiv() +' '+ CreatStationDiv(Art) +'</li>'));
    // here is how I determined to use ParseHTML to parse a string:
   // https://stackoverflow.com/questions/11047670/creating-a-jquery-object-from-a-big-html-string
    return StoryContentDiv;
  }

  function CreateGridStationDiv(){
    // 1. Creating Grid Staion Children Objects
    const GridArt = '<div class="GridImageWork"><div class="GridArt"></div></div>';
    const GridAnimate = '<div class="GridAnimationWork"><div class="GridAnimate"></div></div>';
    const GridAudio = '<div class="GridRecorededWork"><div class="GridAudio"></div></div>';
    const GridMusic = '<div class="GridGridStoryMusicWork"><div class="GridMusic"></div></div>';
    const GridSoundEffects = '<div class="GridSFXWork"><div class="GridSFX"></div></div>';
    const GridStoryText = '<div class="GridStoryDialougeWork"><div class="GridText"></div></div>';
    // 2. Creating Parent Grid Objec with Children included:
    var GridStationDiv = '<div class="Gridstation">'+ GridArt +' ' + GridAnimate +' '+ GridAudio +' '+ GridMusic +' '+ GridSoundEffects +' '+ GridStoryText +'</div>';
    // 3. Returning the newly Created Grid Object
    return GridStationDiv;
  }

  function CreatStationDiv(Art){
    // 1. Creating Station Children Objects
      const Handel = '<div class="StoryContentHandel"></div>';

      const StationArt = '<div class="ImageWork"><input type="image" class="Art" src="' + Art + '" alt="ImageTitle" draggable="false"></div>';
      const StationAnimate = '<div class="AnimationContentDiv"><div class="AnimationWork"></div></div>';
      const StationAudio = '<div class="RecorededDiv"><div class="RecorededWork"></div></div>';
      const StationMusic = '<div class="StoryMusicContentDiv"><div class="StoryMusicWork"></div></div>';
      const StationSoundEffects = '<div class="SFXWorkContentDiv"><div class="SFXWork"></div></div>';
      const StationStoryText = '<div class="StoryDialougeContentDiv"><div class="StoryDialougeWork"></div></div>';

      var StationWithOutHandel = '<div class="NoHandelStation">'+ StationArt +' '+ StationAnimate +' '+ StationAudio +' '+ StationMusic +' '+ StationSoundEffects +' '+ StationStoryText +'</div>'
    // 2. Creating Parent Station Object with Children included:
      var StationDiv = '<div class="station">'+ Handel +''+ StationWithOutHandel+'</div>';
    // 3. Returning the newly Created Station Object
      return StationDiv;

  }

// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
// User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects: User Upload Testo Objects:
  Array.prototype.forEach.call(document.querySelectorAll('#TestoUploadButton'), function(button){
    const TestoInput = button.parentElement.querySelector('#TestoFiles');

    button.addEventListener('click', function(){
      TestoInput.click()
    });
  });

  var DemoHeight = document.getElementsByClassName("demoScene");
  function GrabTitleAuthorCategoriesSummary(){
    var Title = document.getElementById("title").value;

    var Summary = document.getElementById("summary").value;
    alert(Summary);
  //  document.getElementsByClassName("Animation")[0].style.visibility = "hidden";
};

// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic
// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic// Demo Scene Logic









///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
///JQUERY Functionality for New Project Work Station
$(document).ready(function(){
  const UploadConfirmButton = $("#ConfirmContentUpload");
  const BackgroundModalCover = $("#BackgroundModalCover");
  const UploadModal = $("#UploadModal");
  $(function(){
    // Fading out the upload modal:
    UploadConfirmButton.click(function(){
      BackgroundModalCover.fadeOut(600).delay(1500);
    });
  });
});

var ArtNamme = "No Title Selected";
var AnimationType = 'Default';
var AudioTitle = "Default";
var MusicTitle = "Default";
var SFXType = "Default";
var TextFirstWord = "Default";



$(document).ready(function(){
  $("#publish").click(function(){
    // horizontalShake()
    UpdateData();
  });

  $(".UlArtSortableList").sortable({
    axis: "x",
    stop: function(event, ui) {

    }
  });
});
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
// on clickable Immagines: on clickable Immagines: on clickable Immagines:
var ArtIndex = null;

function SelectedArtItems(){

  // Removing the hover and float on all objects
  $('.StoryContent').find('.Art').css({
    "border" : "none",
    "box-shadow": "none",
    "transition" : "none",
  });

  $('.StoryContent').find('.Animate').css({
    "box-shadow": "none",
    "transition": "none"
  });

  $('.StoryContent').find('.Audio').css({
    "box-shadow": "none",
    "transition": "none"
  });

  $('.StoryContent').find('.Music').css({
    "box-shadow": "none",
    "transition": "none"
  });

  $('.StoryContent').find('.SFX').css({
    "box-shadow": "none",
    "transition": "none"
  });

  $('.StoryContent').find('.Text').css({
    "box-shadow": "none",
    "transition": "none"
  });

  ////// Starting hover on selected objects
  ////// Starting hover on selected objects
  ////// Starting hover on selected objects
  ////// Starting hover on selected objects

  $('.StoryContent').eq(ArtIndex).find('.Art').css({
    "border" : "0.2vh solid #ff4242",
    "box-shadow": "0px 1vh 2.0vh rgba(0, 0, 0, 0.45)",
    "transition" : "all .2s ease-in",
    "width" : "12.5625vh"
  });

  $('.StoryContent').eq(ArtIndex).find('.Animate').css({
    "box-shadow": "0px 0px 1.0vh rgb(142, 241, 192)",
    "width": "12.75625vh",
    "transition": "all 0.13s ease-in"
  });

  $('.StoryContent').eq(ArtIndex).find('.Audio').css({
    "box-shadow": "0px 0px 1.3vh rgb(105, 207, 255)",
    "transition": "all 0.13s ease-out"
  });

  $('.StoryContent').eq(ArtIndex).find('.Music').css({
    "box-shadow": "0px 0px 1.3vh rgb(250, 220, 86)",
    "transition": "all .13s ease-in"
  });

  $('.StoryContent').eq(ArtIndex).find('.SFX').css({
    "box-shadow": "0px 0px 1.3vh rgb(132, 255, 255)",
    "transition" : "all .13s ease-in"
  });

  $('.StoryContent').eq(ArtIndex).find('.Text').css({
    "box-shadow": "0px 0px 1.3vh rgb(231, 130, 123)",
    "transition": "all .13s ease-in"
  });
}

function hideAdvanceControls(){
  $('.AdvanceArtControls').hide();
  $('.AdvanceAnimationControls').hide();
  $('.AdvanceAudioControls').hide();
  $('.AdvanceMusicControls').hide();
  $('.AdvanceSFXControls').hide();
  $('.AdvanceTextControls').hide();
}

const pickr = Pickr.create({
    el: '.colorPicker',
    theme: 'nano', // or 'monolith', or 'nano'

    swatches: [
        'rgba(244, 67, 54, 1)',
        'rgba(233, 30, 99, 0.95)',
        'rgba(156, 39, 176, 0.9)',
        'rgba(103, 58, 183, 0.85)',
        'rgba(63, 81, 181, 0.8)',
        'rgba(33, 150, 243, 0.75)',
        'rgba(3, 169, 244, 0.7)',
        'rgba(0, 188, 212, 0.7)',
        'rgba(0, 150, 136, 0.75)',
        'rgba(76, 175, 80, 0.8)',
        'rgba(139, 195, 74, 0.85)',
        'rgba(205, 220, 57, 0.9)',
        'rgba(255, 235, 59, 0.95)',
        'rgba(255, 193, 7, 1)'
    ],

    components: {

        // Main components
        preview: true,
        opacity: true,
        hue: true,
        default: '#428FFF',
        defaultRepresentation: 'HSVA',

        // Input / output Options
        interaction: {
            rgba: true,
            hex: true,
            // hsla: true,
            hsva: true,
            // cmyk: true,
            input: true,
            clear: true,
            save: true
        }
    }
});


// "ArtData" : {
//   "url": "",
//   "defualtRunTime" : "",
//   "blendMode" : 0, // default to zero which is just normal which is nothing
//   "colorHSVA" : {
//     "h" : "0",
//     "s" : "0",
//     "v" : "0",
//     "a" : "0",// default to transparent
//   },
//   "colorHEXA" :"#FFC10700",// default to transparent
//
// },

pickr.on('init', instance => {
    console.log('init', instance);
}).on('hide', instance => {
    console.log('hide', instance);
}).on('show', (color, instance) => {
    console.log('show', color, instance);
}).on('save', (color, instance) => {
    // var storing hexa value
    var hexa = color.toHEXA().toString();
    // storing the hsva color value
    storyData[ArtIndex].ArtData.colorHSVA.h = color.h;
    storyData[ArtIndex].ArtData.colorHSVA.s = color.s;
    storyData[ArtIndex].ArtData.colorHSVA.v = color.h;
    storyData[ArtIndex].ArtData.colorHSVA.a = color.a;
    //setting the hexa color value
    storyData[ArtIndex].ArtData.colorHEXA = hexa;
    console.log(storyData[ArtIndex].ArtData);
    callUpdateOnColor();
    console.log('save', color, instance);
    console.log('HEXA : ' + color.toHEXA )
    pickr.hide();

}).on('clear', instance => {
    console.log('clear', instance);
}).on('change', (color, instance) => {
    console.log('change', color, instance);
}).on('changestop', instance => {
    console.log('changestop', instance);
}).on('cancel', instance => {
    console.log('cancel', instance);
}).on('swatchselect', (color, instance) => {
    console.log('swatchselect', color, instance);
});

function updateColorPicker(){
  // hsva(216, 74%, 100%, 1)
  // pickr.setColor(h:216,s:74,v:100,a:1, silent:true)

}



function InitializeWorkStationArt(){
  var Art = $('.Art');
  $('.Art').click(function(){
    ArtIndex = $(this).parents('.StoryContent').index();
    AnimationRecentIndex = ArtIndex;
    SelectedArtItems();
    //triggers the selection board as seen below w/t the other selection board triggering objects:
    SelectionOptions(ClickedObject = '.ArtOptions', index = ArtIndex);
    //Demo replacement object
    var ImageSelected = $(this);
    var ImageSrc = ImageSelected.attr('src');
    $("#DemoImage").remove();
    $('.DemoImageObject').append('<img id="DemoImage" src="'+ ImageSrc +'" draggable="false">');
    // updateDefaultTime();
    // updateBlendMode();
    // updateColorPicker();
    callUpdateOnColor();
    //hide all adavance controls except this one
    if($('.AdvanceArtControls').is(":hidden")){
      $('.AdvanceArtControls').fadeIn();
    }


  });// end of the click function
}

function callUpdateOnColor(){
  $('.OverlayColor').css({
    "background-color" : storyData[ArtIndex].ArtData.colorHEXA,
    "mix-blend-mode" : returnBlendMode(storyData[ArtIndex].ArtData.blendMode) ,
  });
  $("select[name='blendMode'] option:selected").index(storyData[ArtIndex].ArtData.blendMode);
  // pickr.setColor(str: storyData[ArtIndex].ArtData.colorHEXA , silent: false);
}


function updateDefaultTime(){
  var blendMode = $('#defaultRuntime')
  // var index = blendMode.selectedIndex//options[blendMode.selectedIndex].index;
  var index = $("select[name='Runtime'] option:selected").index();

  var runtimeArray = [500, 1000, 2000, 3000 , 4000 , 5000 ,6000 ,7000 ,8000 ,9000 ,10000];
  storyData[ArtIndex].ArtData.defualtRunTime = runtimeArray[index];
}


function updateBlendMode(){
  var blendMode = $('#blendMode')
  // var index = blendMode.selectedIndex//options[blendMode.selectedIndex].index;
  var index = $("select[name='blendMode'] option:selected").index();


  storyData[ArtIndex].ArtData.blendMode = index;

  $('.OverlayColor').css({
    "background-color" : storyData[ArtIndex].ArtData.colorHEXA,
    "mix-blend-mode" : returnBlendMode(storyData[ArtIndex].ArtData.blendMode) ,
  });
}

var blendingOptions = [
  {
    "index" : 0,
    "name" : "Normal",
    "cssName" : "normal",
  },
  {
    "index" : 1,
    "name" : "Color",
    "cssName" : "color"
  },
  {
    "index" : 2,
    "name" : "Multiply",
    "cssName" : "multiply",
  },
  {
    "index" : 3,
    "name" : "Darken",
    "cssName" : "darken",
  },
  {
    "index" : 4,
    "name" : "Color Burn",
    "cssName" : "color-burn",
  },
  {
    "index" : 5,
    "name" : "Color Dodge",
    "cssName" : "color-dodge",
  },
  {
    "index" : 6,
    "name" : "Difference",
    "cssName" : "difference",
  },
  {
    "index" : 7,
    "name" : "Hard Light",
    "cssName" : "hard-light",
  },
  {
    "index" : 8,
    "name" : "Normal",
    "cssName" : "hue",
  },
  {
    "index" : 9,
    "name" : "Hue",
    "cssName" : "lighten",
  },
  {
    "index" : 10,
    "name" : "Lighten",
    "cssName" : "overlay",
  },
  {
    "index" : 11,
    "name" : "Soft Ligh",
    "cssName" : "soft-light",
  },
  {
    "index" : 12,
    "name" : "Hard Light",
    "cssName" : "hard-light"
  },
  {
    "index" : 13,
    "name" : "Saturation",
    "cssName" : "saturation",
  },
]

function returnBlendMode(index){
  // storyData[ArtIndex].ArtData.colorHEXA = "transparent";
  console.log(index);

  var blendingMode = blendingOptions[index].cssName;
    return blendingMode;
}



function InitializeArtSelection(){
  $('.ArtSelectObject').click(function(){
      // 1. Storing the src of the selected art object on the selection board:
      var CurrentSelectionSelected = $(this).attr('src');
      // 2. Changing the Image and Src for the workstaion selected art:
      $('.StoryContent').eq(ArtIndex).find('.Art').attr('src', CurrentSelectionSelected);
      // 3. Changing the Image on the demo also now that the selected art has changed also:
      $("#DemoImage").remove();
      $('.DemoImageObject').append('<img id="DemoImage" src="'+ CurrentSelectionSelected +'" draggable="false">');
  });
}


function SetArt(){
  //Purely a duplicate of the data above such that the for loop of art objects are able to be have properly
      $(document).ready(function(){
        var Art = $('.Art');
        $('.Art').click(function(){
          ArtIndex = $(this).parents('.StoryContent').index();
          SelectedArtItems();
          SelectionOptions(ClickedObject = '.ArtOptions', index = ArtIndex);
          InitializeWorkStationArt();
          //Demo replacement object
          var ImageSelected = $(this);
          var ImageSrc = ImageSelected.attr('src');

          if(NewProjectInitalizationFlag == true && ArtIndex == 0){
            //in AppendStoryContentDiv() function I set up the systen to run all art fade content out and hide it, now below it shoes it
                  $("#DemoImage").attr('src' , ImageSrc ).fadeIn(2000);
                  // NewProjectInitalizationFlag set to false so that the animations don't repeat after the first load of the first art
                  NewProjectInitalizationFlag == false;
          }else{
            $("#DemoImage").attr('src' , ImageSrc );
            // $('.DemoImageObject').append('<img id="DemoImage" src="'+ ImageSrc +'">');
          }
        });// end of the click function
    });
}


$(document).ready(function(){
  $('.ArtRemoveButton').click(function(){
    $('.StoryContent').eq(ArtIndex).fadeOut(200, function(){$('.StoryContent').eq(ArtIndex).remove()});
    ImmagineArray.splice(ArtIndex, 1);
    $('.ArtSelectObject').eq(ArtIndex).fadeOut(200, function(){$('.ArtSelectObject').eq(ArtIndex).remove()});
    $('.WorkStationDiv').css({
      'width' : 'auto',
    });
  });



  var NewUploadArrayImages = new Array();
  Array.prototype.forEach.call(document.querySelectorAll('.ArtSelectionButton'), function(button){
    // 1. Finds Image input file uploader button on the dom :
    const ImageInput = button.parentElement.querySelector('#NewSetOfImages');
    // 2. Triggers a click with of the image input file uploader button when the artSelectionButton is clicked... which if it is this far then it has been clicked :
    button.addEventListener('click', function(){
      ImageInput.click();
    });


    // 3. Listens for a change in the data :
    ImageInput.addEventListener('change', function(){
      NewUploadArrayImages = Array.prototype.map.call(ImageInput.files, function(file){
        return URL.createObjectURL(file);
      });
      PlaceNewArt();
    });

    InitializeAnimationDroppable();
    InitializeSFXDroppable();

  });

  function PlaceNewArt(){
    // 1. Placing Art onto seletion boards :
    if($('.StoryContent').length > 0 ){
    for(x = 0 ; x < NewUploadArrayImages.length ; x++){
      var ArtSrc = NewUploadArrayImages[x];
      // Creating new selection board art, appending the art after the selection board  :
      var SelectionArt = $('<input type="image" class="ArtSelectObject" src="' + ArtSrc + '" alt="ImageTitle" onclick="" draggable="false">');
      var objectToInsertAfter = $('.ArtSelectObject').eq(ArtIndex);
      SelectionArt.insertAfter(objectToInsertAfter).hide().fadeIn(2000);
      // Creating a new Story Content object with the proper art that is to be appended after the selected art object:
      AppendingNewArtObjects(ArtSrc);


      var musicheGrid = '<div class="MusicheGridMusic"></div>';
      var sfxGrid = '<div class="SFXGrid"></div>';
      musicheGrid.insertAfter(musicheGrid).eq(ArtIndex);
      musicheGrid.insertAfter(sfxGrid).eq(ArtIndex);
    }

    // Removing these objects fromt he array such that after New Art objects can be subeqently added
    for(i = 0 ; i < NewUploadArrayImages.length; i++){
      NewUploadArrayImages.splice(i , 1);
    }
    // 2. Initializing art selection options :
    InitializeArtSelection()
   }else{
     console.log('running the else statement after all has been removed');
     // this else statement is for the moments that the user removes all objects from the scene
      for(x = 0 ; x < NewUploadArrayImages.length ; x++){
        var ArtSrc = NewUploadArrayImages[x];
        // Creating new selection board art, appending the art after the selection board  :
        var SelectionArt = $('<input type="image" class="ArtSelectObject" src="' + NewUploadArrayImages[x] + '" alt="ImageTitle" onclick="" draggable="false">');
        SelectionArt.appendTo(".SelectableArt").hide().fadeIn(2000);
        InitializeArtSelection();
        // Creating a new Story Content object with the proper art that is to be appended after the selected art object:
        AppendingStoryContentDiv(ArtSrc);
        SetArt();
        ImmagineArray = NewUploadArrayImages;// setting the new uploaded art to the Immagine array because All should have been erased
      }

      // Removing these objects fromt he array such that after New Art objects can be subeqently added
      for(i = 0 ; i < NewUploadArrayImages.length; i++){
        NewUploadArrayImages.splice(i , 1);
      }
      // 2. Initializing art selection options :
      InitializeArtSelection();
    }// end of else statement
  }// end of Place New Art Function

  function AppendingNewArtObjects(Art){
    var StoryContet = AssembleStoryContent(Art);
    var LocationToAppend = $('.StoryContent').eq(ArtIndex);
    StoryContet.insertAfter(LocationToAppend).hide().fadeIn(2000);
  }

});
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:
//Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object: Animation Object:

    // Keeping track of Data to be sent to the backend server:
    var AnimationArray = new Array();

    function InitializeAnimationObjects(){
      // initialize droppable
      InitializeAnimationDroppable();
      // initilize draggable click
      InitalizeAnimationDraggableAndOnClickFunction();
      // Initialize draggabel
      InitializeAnimationDraggable();
      // add animations value to selection board
      AnimationSelectionBoardAnimations();
      // make selection board animation functional
      SetSelectionAnimationObject();
    }

    function InitializeAnimationDroppable(){
      $(function () {
        $( ".GridAnimate" ).droppable({
          accept: '.AnimateDraggableObject',
          drop: function(event, ui){
            var dropped = ui.draggable;
            var indexPrevious = dropped.parents('.StoryContent').index() || BeforeDragPostion;
            var indexCurrent = $(this).parents('.StoryContent').index();
            updateAnimationDragAndDrop(indexWas = indexPrevious, indexNow = indexCurrent);
            dropped.remove();
              // Grabs this droppable story content div:
            ReplacingAnimationDraggable(indexCurrent);
            InitializeAnimationButtonClick();
            ArtIndex = indexCurrent;
            SelectedArtItems();
            $('.StoryContent').eq(indexCurrent).find('.Animate').trigger('click');
              // Meant to update the array but for this scnerio the array will not be updated:
          }
        });
      });
    }

    function updateAnimationDragAndDrop(indexWas, indexNow){
      //storyData[indexNow] is different from storyData[indexWas]... what this does is moves the data at that index to the data of the new index;
      storyData[indexNow].AnimationData.animationStyle = storyData[indexWas].AnimationData.animationStyle;
      storyData[indexNow].AnimationData.animationTypeText = storyData[indexWas].AnimationData.animationTypeText;
      storyData[indexNow].AnimationData.animationFunctionValue = storyData[indexWas].AnimationData.animationFunctionValue;
      storyData[indexNow].AnimationData.speed = storyData[indexWas].AnimationData.speed;
      storyData[indexNow].AnimationData.displacement = storyData[indexWas].AnimationData.displacement;
      storyData[indexNow].AnimationData.attack = storyData[indexWas].AnimationData.attack;
      storyData[indexNow].AnimationData.vibrationOn = storyData[indexWas].AnimationData.vibrationOn;
      storyData[indexNow].AnimationData.startTime = storyData[indexWas].AnimationData.startTime;

      //Reseting all of the index Data For the old Index
        clearAnimationData(indexWas);
    }


    function clearAnimationData(indexInQuestion){
      storyData[indexInQuestion].AnimationData.animationStyle = "";
      storyData[indexInQuestion].AnimationData.animationTypeText = "No Animation";
      storyData[indexInQuestion].AnimationData.animationFunctionValue = "";
      storyData[indexInQuestion].AnimationData.speed = 0;
      storyData[indexInQuestion].AnimationData.displacement = 0;
      storyData[indexInQuestion].AnimationData.attack = 0;
      storyData[indexInQuestion].AnimationData.vibrationOn = false;
      storyData[indexInQuestion].AnimationData.startTime = "";
    }



    var BeforeDragPostion = null;
    var AnimationArrayLocaiton = null;
    function ReplacingAnimationDraggable(droppedIndex){
      // 1. find location in animation array such that data can be changed also:
      // 2. removing animation draggable
        $('.StoryContent').eq(droppedIndex).find('.AnimateDraggableObject').remove();
      // 3. add New animation object : Create and Animation Object & Append it to the proper div ::
        var newDraggableObject = $('<div class="AnimateDraggableObject"><div class="Animate" data=""><label class="AnimateButtonLabel">'+ AnimationArray[AnimationArrayLocaiton].AnimationTypeText +'</label></div></div>');// element created
        var AppendLocation =  $('.StoryContent').eq(droppedIndex).find('.AnimationWork');
        $(newDraggableObject).appendTo(AppendLocation);
      //  4. Updating the AnimationArray Data:
      //  5. Initialize draggable :
          InitializeAnimationDraggable();
    }


    function InitalizeAnimationDraggableAndOnClickFunction(){
      $("#Animation").click(function(){
        //1. Creating an element:
           AddAnimationDraggable();
        });
    }

    function InitializeAnimationDraggable(){
      $(function () {
        $('.AnimateDraggableObject').draggable({
          axis: "x",
          revert : "invalid",
          appendTo: ".GridAnimate" ,
          snap: ".GridAnimate",
          snapMode: "inner",
          snapTolerance: 20,
          start: function(){
             BeforeDragPostion = $(this).parents('.StoryContent').index();
          },
          drag: function( event, ui ) {

          },
        });
      });
    }

    function InitializeAnimationDroppable(){
      $(function () {
        $( ".GridAnimate" ).droppable({
          accept: '.AnimateDraggableObject',
          drop: function(event, ui){
            var dropped = ui.draggable;
            var indexPrevious = dropped.parents('.StoryContent').index() || BeforeDragPostion;
            var indexCurrent = $(this).parents('.StoryContent').index();
            updateAnimationDragAndDrop(indexWas = indexPrevious, indexNow = indexCurrent);
            dropped.remove();
              // Grabs this droppable story content div:
            ReplacingAnimationDraggable(indexCurrent);
            InitializeAnimationButtonClick();
            ArtIndex = indexCurrent;
            SelectedArtItems();
            $('.StoryContent').eq(indexCurrent).find('.Animate').trigger('click');
              // Meant to update the array but for this scnerio the array will not be updated:
          }
        });
      });
    }



    function InitializeAnimationButtonClick(){
      $('.Animate').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        IndexOfAnimationObject = thisIndex;
        SelectionOptions(ClickedObject = '.AnimationOptions', index = thisIndex);
        ArtIndex = $(this).parents('.StoryContent').index();
        SelectedArtItems();
        var NewArtSrc = $('.StoryContent').eq(ArtIndex).find('.Art').attr('src');
        $('#DemoImage').attr('src' , NewArtSrc );


        //Updating The Andvanced Controls :
        //Hide all advanced controls except this one;
        hideAdvanceControls();
        $('.AdvanceAnimationControls').fadeIn();
        // $('.AdvanceAnimationControls').hide().fadeIn();
        getAnimationDataValue();
      });
    }



    function getAnimationDataValue(){
      var rangeSpeed = $('#speed');
      var rangeDisplacement = $('#distanceDiv');
      var rangeAttack = $('#attack');
      var selectableStartTime = $('#timing');
      var selectableVibrate = $('#Vibarate')
      // data
      var ThisSpeed = storyData[ArtIndex].AnimationData.speed;
      var ThisDisplacement = storyData[ArtIndex].AnimationData.displacement;
      var ThisAttack = storyData[ArtIndex].AnimationData.attack;
      var startTime = storyData[ArtIndex].AnimationData.startTime;
      var vibrationOn = storyData[ArtIndex].AnimationData.vibrationOn;
      // set data :
      rangeSpeed.prop('value',('' + ThisSpeed + '')); // = ThisSpeed; //.attr('value', "" + speed + "");
      $('.AnimationSpeedLabel').text(ThisSpeed);
      rangeDisplacement.prop('value',('' + ThisDisplacement + '')); // = ThisDisplacement; //.attr('value', "" + displacement + "");
      $('.AnimationDisplacementLabel').text(ThisDisplacement);
      rangeAttack.prop('value',('' + ThisAttack + '')); //.value = ThisAttack; //.attr('value', "" + attack + "");
      $('.AnimationAttackLabel').text(ThisAttack);
      // selectableStartTime.value = startTime;
      selectableStartTime.selectedIndex = startTime;
      // selectableVibrate.value = vibrationOn;
      selectableVibrate.selectedIndex = vibrationOn;
      //Show me The New Values
      console.log(storyData[ArtIndex].AnimationData)
    }

    const startTimeSelectable = document.querySelector('#timing');
    const vibrateSelectable = document.querySelector('#Vibarate');

      startTimeSelectable.addEventListener('change',(event) => {
        if(  $('.StoryContent').eq(ArtIndex).find('.Animate') > 0 ){
          // var value = $('#timing').selectedIndex;
          var value = event.target.value;
          storyData[ArtIndex].AnimationData.startTime = value;
          console.log(storyData[ArtIndex].AnimationData)
          console.log(value);
        }else{
          // no Animation object exists there
        }
      });


      vibrateSelectable.addEventListener('change',(event) => {
        if(  $('.StoryContent').eq(ArtIndex).find('.Animate') > 0 ){
          // var value = $('#Vibarate').selectedIndex;
          var value = event.target.value;
          storyData[ArtIndex].AnimationData.vibrationOn = value;
          console.log(storyData[ArtIndex].AnimationData);
          console.log(value);

        }else{
          // no Animation object exists there
        }
      });



    function CheckForAnimationObjectHere(Index){
      if($('.StoryContent').eq(Index).find('.AnimateDraggableObject').length){
        return true;
      }else{
        return false;
      }
    }

    function AddAnimationDraggable(){
      if(CheckForAnimationObjectHere(ArtIndex) == false){
      // 1. Create and Animation Object :
        var newDraggableObject = $('<div class="AnimateDraggableObject"><div class="Animate" data="" id=""><label class="AnimateButtonLabel">No Animation</label></div></div>');// element created
      // 2. Append it to the proper div :
        var AppendLocation =  $('.StoryContent').eq(ArtIndex).find('.AnimationWork');
        $(newDraggableObject).appendTo(AppendLocation).hide().fadeIn(400);
        console.log($('.StoryContent').eq(ArtIndex));
      // 3. Initialize Animtion Draggable :
        InitializeAnimationDraggable();
      // 4. Create An Animation Array Object to Store the needed data :
        newDraggableLocation(ArtIndex);
      // 5. Initilizing animation button click :
        InitializeAnimationButtonClick();
      //6. Activate selection board and trigger click on object to make selection board appear  :
        ActivateSelectionBoard();
        $('.StoryContent').eq(ArtIndex).find('.Animate').trigger('click');
    }else{
      AlertFunction('A Animation object already exists here.');
    }
  }

    function newDraggableLocation(Index){
      // 1. Aniamtion Object:
        var AnimationObject = {
          "IndexLocation" : null,
          "AnimationTypeText" : "No Animation",
          "AnimationFunctionValue" : null,
          "VibrationOn" : false
        }
      // 2. Store The Index Location
        AnimationObject.IndexLocation = Index;
      // 3. Pushing object onto the Array:
        AnimationArray.push(AnimationObject);
    }

    function AnimationSelectionBoardAnimations(){
      // major purpose of this function is to add objects to selection board :
      for(x = 0; x < AnimationStylesArray.length; x++ ){
        var AnimationStyleValues = $('<button class="AnimationSelectObject">' + AnimationStylesArray[x].AnimationStyle + '</button>');
        AnimationStyleValues.appendTo('.SelectableAnimations');
        SetSelectionAnimationObject();
      }
    }

  function SetSelectionAnimationObject(){
    $(document).ready(function(){
      $(".AnimationSelectObject").click(function(){
          for(i = 0 ; i < AnimationArray.length ; i++){
            if(ArtIndex == AnimationArray[i].IndexLocation){
                // Changing the data on the array object for for it's text:
                AnimationArray[i].AnimationTypeText = $(this).text() ||  "";
                AnimationArray[i].AnimationFunctionValue = $(this).index();

                // Changing the label on the animation object:
                var SpecificAnimationElement = $('.StoryContent').eq(ArtIndex).find('.AnimateButtonLabel');
                SpecificAnimationElement.text($(this).text()).fadeIn(200);
                $('.StoryContent').eq(ArtIndex).find('.Animate').attr('data', AnimationStylesArray[$(this).index()].AnimationValue);
                $('#explainationBox').text( AnimationStylesArray[$(this).index()].def);
                AnimationCall( $(this).index() );
            }
          }
      });
   });
}

$(document).ready(function(){
  $('.AnimationDeleteSelectionButton').click(function(){
    $('.StoryContent').eq(ArtIndex).find('.AnimateDraggableObject').fadeOut(300, function(){
      $('.StoryContent').eq(ArtIndex).find('.AnimateDraggableObject').remove();
    });
  });
});

    function AnimationCall(AnimationNumber){
      switch (AnimationNumber) {
        case 0:
          horizontalShake();// calls the Horizontal
          break;
        case 1:
          verticalShake();// calls the Horizontal
            break;
        case 2:
          chaoticShake();
          break;
        case 3:
          fadeIn();
          break
        case 4:
          fadeOut();
          break;
        case 5:
          softScreenPulse();
          break;
        case 6:
          violentScreenPulse();
          break;
        case 7:
          horizontalPanAcross();
          break;
        case 8 :
          verticalPanDown();
          break;
        case 9:
          verticalPanUp();
          break;
        case 10:
          ChaoticPulseShake();
          break;

        // case 11:
        //   flickerExplode();
        //   break;

        case 11:
          zoomIn();
          break;

        case 12:
          zoomOut();
          break;

        case 13:
          ZoomInHorizontalShake();
          break;

        case 14:
          ZoomInVerticalShake();
          break;

        case 15:
          ZoomInScreenPulse();
          break;

        case 16:
          DropOutTheView();
          break;

        case 17:
          FlyInTheView();
          break;

        case 18:
          RunOutTheView();
          break;

        case 19:
          RunIntheView();
          break;

        case 20:
          LandInView();
          break;

        case 21:
          LandInViewDiagonal();
          break;


        default:
          Default()
          break;
      }
    }



    var animationSpeed;
    var animationDisplacement;
    var animationAttack;
    var startTimeStatus;

    function speedSliderValue(value){
      // var value = document.getElementById('distanceDiv').value();
      var valueInt = parseInt(value);
      var value = (valueInt);
      $('.AnimationSpeedLabel').text(" " + value);
      // updating the animation speed data on the story data obejct
      storyData[ArtIndex].AnimationData.speed = value;

      console.log("Speed Value : " + storyData[ArtIndex].AnimationData.speed);
    }

    function distanceSliderValue(value){
      // Thanks for the help from this guy here
      // https://stackoverflow.com/questions/10004723/html5-input-type-range-show-range-value
      // var value = document.getElementById('distanceDiv').value();
      var valueInt = parseInt(value);
      var value = (valueInt);
      $('.AnimationDisplacementLabel').text(" " + value);
      // updating the animation displacment data on the story data obejct
      storyData[ArtIndex].AnimationData.displacement = value;
      console.log("Distance Value : " + storyData[ArtIndex].AnimationData.displacement);
    }

    function attackSliderValue(value){
      // var value = document.getElementById('distanceDiv').value();
      var valueInt = parseInt(value);
      var value = (valueInt);
      $('.AnimationAttackLabel').text(" " + value);
      // updating the animation attack data on the story data obejct
      storyData[ArtIndex].AnimationData.attack = value;
      console.log("Speed Value : " + storyData[ArtIndex].AnimationData.attack);
    }

    function startTime(){
      var index = $("select[name='AnimationStartTime'] option:selected").index();
      if (index == 0){
        storyData[indexNow].AnimationData.startTime = "Beginning";
      }else if(index == 2){
        storyData[indexNow].AnimationData.startTime = "End";
      }else{
        storyData[indexNow].AnimationData.startTime = "Default";
      }
    }

    function vibrateStatus(){
      var index = $("select[name='AnimationVibrate'] option:selected").index();
      if(index == 0){
        storyData[ArtIndex].AnimationData.vibrationOn = false ;
      }else{
        storyData[ArtIndex].AnimationData.vibrationOn = true ;
      }

    }

    function Default(){
      // no screen shake... this isn't technically wrong but it is not recommended to call a function that
      // does nothing

      // this also resets the values to their default state
      var Demo = $("#DemoImage");
      Demo.css({
        "width" : "42.5vh",
        "height" : "42.5vh",
      });
      Demo.animate({
          'top' : "0px",
          'left' : "0px",
          'bottom' : "0px",
          'right' : "0px",
      }, 0)
    }



    function horizontalShake() {
            var Demo = $("#DemoImage")
            var numberOfTimes = 10;
            var AnimationSpeed = 10;
            var intervalCall = 50;
            var WasJustTop = false;



            var Distance = 15;
            var DistanceUP = (-1 * (Distance)) + "px";
            var DistanceDown = (Distance * 2) + "px";

            var TransitionSpeed = intervalCall / 1000;
            var TransitionSpeedUp ="all " + TransitionSpeed +"s ease-in-out"
            var TransitionSpeedDown ="all " + (TransitionSpeed * 2) +"s ease-in-out"

            var DialogueDurration = 0;

        var horizontalShakeVar = setInterval(function(){
          console.log("running");
              if(DialogueDurration < 25){
                if( WasJustTop == false){
                  Demo.css({
                    "left" : DistanceUP,
                    "transition": TransitionSpeedUp
                  })
                    WasJustTop = true;
                    DialogueDurration = DialogueDurration + 1 ;
                }else{
                  Demo.css({
                    "left" : DistanceDown,
                    "transition": TransitionSpeedDown
                  })
                    WasJustTop = false;
                    DialogueDurration = DialogueDurration + 1 ;
                }
              }else{
                // ending the animation
                clearInterval(horizontalShakeVar);
                // Placing object back to it's proper place
                // Demo.css({"top" : "0px"});

                if( WasJustTop == false){
                  Demo.css({
                    "left" : DistanceUP,
                    "transition": TransitionSpeedUp
                  })
                }else{
                  Demo.css({
                    "left" : (DistanceUP * -1),
                    "transition": TransitionSpeedUp
                  })
                }

              }
            }, intervalCall);

            horizontalShakeVar;

     }



     $(document).ready(function(){
       $('#save').click(function(){
        zoomOut();
       });
     });

    function verticalShake(){


      var Demo = $("#DemoImage")
      var numberOfTimes = 10;
      var AnimationSpeed = 10;
      var intervalCall = 50;
      var WasJustTop = false;



      var Distance = 15;
      var DistanceUP = (-1 * (Distance)) + "px";
      var DistanceDown = Distance + "px";

      var TransitionSpeed = intervalCall / 500;
      var TransitionSpeedUp ="all " + TransitionSpeed +"s ease-in-out"
      var TransitionSpeedDown ="all " + (TransitionSpeed * 2) +"s ease-in-out"

      var DialogueDurration = 0;

  var VerticalShakeVar = setInterval(function(){
    console.log("running");
        if(DialogueDurration < 25){
          if( WasJustTop == false){
            Demo.css({
              "top" : DistanceUP,
              "transition": TransitionSpeedUp
            })
              WasJustTop = true;
              DialogueDurration = DialogueDurration + 1 ;
          }else{
            Demo.css({
              "top" : DistanceDown,
              "transition": TransitionSpeedDown
            })
              WasJustTop = false;
              DialogueDurration = DialogueDurration + 1 ;
          }
        }else{
          // ending the animation
          clearInterval(VerticalShakeVar);
          // Placing object back to it's proper place
          Demo.css({"top" : "0px"});
        }
      }, intervalCall);

      VerticalShakeVar;



    }

    function chaoticShake(){

      var Demo = $("#DemoImage")
      var numberOfTimes = 10;
      var AnimationSpeed = 10
      var TimerSpeed = 50;
      var WasJustTop = false;
      var wasJustLeft = false;

      var Distance = 8;
      var DistanceUP = (-1 * (Distance)) + "px";
      var DistanceDown = Distance + "px";

      // In chaotic shake function The Distance Traveled up and down is going to be the same distance traveled left and right
      var DistanceLeft = DistanceUP;
      var DistanceRight = DistanceDown;

      var TransitionSpeed = TimerSpeed / 1000;
      var TransitionSpeedUp ="all " + TransitionSpeed +"s ease-in-out"
      var TransitionSpeedDown ="all " + (TransitionSpeed * 2) +"s ease-in-out"

      var DialogueDurration = 0;

  var chaoticlShakeVar = setInterval(function(){
    console.log("running");
        if(DialogueDurration < 25){
          if( WasJustTop == false){
            Demo.css({
              "top" : DistanceUP,
              "transition": TransitionSpeedUp
            })
              WasJustTop = true;
              DialogueDurration = DialogueDurration + 1 ;
              if(wasJustLeft == false){
                Demo.css({
                  "left" : DistanceLeft,
                  "transition" : TransitionSpeed,
                });
                wasJustLeft = true;
              }
          }else{
            Demo.css({
              "top" : DistanceDown,
              "transition": TransitionSpeedDown
            })
              WasJustTop = false;
              DialogueDurration = DialogueDurration + 1 ;

              if(wasJustLeft == true){
                Demo.css({
                  "left" : DistanceRight,
                  "transition" : TransitionSpeed,
                });
                wasJustLeft = false;
              }
          }
        }else{
          // ending the animation
          clearInterval(chaoticlShakeVar);
          // Placing object back to it's proper place
          Demo.css({"top" : "0px"});
        }
      }, TimerSpeed);

      chaoticlShakeVar;
    }

    function fadeIn(AnimationSpeed){
      var speed = AnimationSpeed;
      var Demo = $("#DemoImage");

      Demo.fadeIn((AnimationSpeed || 500));

    }

    function fadeOut(AnimationSpeed){
      var speed = AnimationSpeed;
      var Demo = $("#DemoImage");
      Demo.fadeOut((AnimationSpeed || 500));
    }

    function softScreenPulse(AnimationSpeed, interval){
      var Demo = $("#DemoImage");
      var intervalCall = interval || 50;
      var wasJustOnFadeOut = false;
      var AnimationDurration = 0;

      var SPulsate = setInterval(() => {

          if(AnimationDurration < 200){
            if (wasJustOnFadeOut == false){
                    Demo.fadeOut((AnimationSpeed || 700));
                    wasJustOnFadeOut = true;
                  }else{
                    Demo.fadeIn((AnimationSpeed || 700));
                    wasJustOnFadeOut = false;
                  }
              AnimationDurration = AnimationDurration + 1
            }else{
              clearInterval(SPulsate);
            }

          }, intervalCall);

          SPulsate;/// Calling the closure

    }

    function violentScreenPulse(AnimationSpeed, interval){
      var Demo = $("#DemoImage");
      var intervalCall = interval || 25;
      var wasJustOnFadeOut = false;
      var AnimationDurration = 0;

      var VPulsate = setInterval(() => {

          if(AnimationDurration < 100){
            if (wasJustOnFadeOut == false){
                    Demo.fadeOut((AnimationSpeed || 350));
                    wasJustOnFadeOut = true;
                  }else{
                    Demo.fadeIn((AnimationSpeed || 350));
                    wasJustOnFadeOut = false;
                  }
              AnimationDurration = AnimationDurration + 1
            }else{
              clearInterval(VPulsate);
            }

          }, intervalCall);

          VPulsate;/// Calling the closure
    }

    function horizontalPanAcross(){
      var Demo = $('#DemoImage');
      //Setting CSS On Property to allow for the animation:
      Demo.css({
        "width" : "auto",
        "height" : "42.5vh",
      }, function(){
        Default();
      });
    }

    function verticalPanDown(){
      var Demo = $('#DemoImage');
      //Setting CSS On Property to allow for the animation:
      Demo.css({
        "width" : "42.5vh",
        "height" : "auto",
      });
      var DemoTop = Demo.offset().top;
      var Container = $('.DemoImageObject');
      var ContainerTop = Container.offset().top;
      var DisplacementTop = ContainerTop - DemoTop;

      var demoHeight = Demo.height();
      var containerHeight = Container.height();

      var panSpeed = 2000;

      Demo.animate({
        'top' : DisplacementTop
      }, 0, function(){
        Demo.animate({
          'top' : ((demoHeight - containerHeight) * 1)

        }, panSpeed, function(){

          /// This resets all of the values to their original state
          // Default();

        });
      });
    }

    function verticalPanUp(){
      var Demo = $('#DemoImage');
      //Setting CSS On Property to allow for the animation:
      Demo.css({
        "width" : "42.5vh",
        "height" : "auto",
      });
      var DemoTop = Demo.offset().top;
      var Container = $('.DemoImageObject');
      var ContainerTop = Container.offset().top;
      var DisplacementTop = ContainerTop - DemoTop;

      var demoHeight = Demo.height();
      var containerHeight = Container.height();
      var heightDisplacement = demoHeight - containerHeight;

      var topOfImage = DemoTop

      var panSpeed = 2000;

      Demo.animate({
        'top' : (DisplacementTop * 1)
      }, 0, function(){
        Demo.animate({
          'top' : ((demoHeight - containerHeight) * -1)

        }, panSpeed, function(){

          /// This resets all of the values to their original state
          // Default();

        });
      });
    }

    function ChaoticPulseShake(){
      // this is just a chaotic shake with a violent pulse
    }

    function flickerExplode(){
    // flicker on the screen twice then with a pause explode on screen
    }

    function zoomIn(speed, Proportion){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 500;
      Demo.animate({
        'width' : (DemoWidth * ZoomProportion),
        'height' : (DemoHeight * ZoomProportion),
      }, zoomSpeed, function(){
        Default();
      })
    }

    function zoomOut(){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 2000;
      var leftPos = ((DemoWidth / ZoomProportion) * -1);
      Demo.animate({
        'width' : (DemoWidth * ZoomProportion),
        'height' : (DemoHeight * ZoomProportion),
        'left' : leftPos,
      }, 0, function(){
        Demo.animate({
          'width' : '42.5vh',
          'height' : '42.5vh',
          'left' : 0,
        }, zoomSpeed, function(){
          Default();
        });
      })
    }

    function ScaleDisappear(){
      /// this scales and disappears : This is the only one borrowed from the jquery documentation:
      $("#DemoImage").effect("puff",300);
    }

    function explode(){
      // selef explainitry this one was also barrowed fromt the jquery Documentation
      $("#DemoImage").effect("explode",400);
    }

    function ZoomInHorizontalShake(){}

    function ZoomInVerticalShake(){}

    function ZoomInScreenPulse(){}

    function DropOutTheView(){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 500;
      Demo.animate({
        'top' : (DemoWidth * ZoomProportion),
        // 'height' : (DemoHeight * ZoomProportion),
      }, zoomSpeed, function(){
        Default();
      })
    }

    function FlyInTheView(){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 500;
      Demo.animate({
        'top' : (DemoWidth * ZoomProportion * -1),
        // 'height' : (DemoHeight * ZoomProportion),
      }, zoomSpeed, function(){
        Default();
      })
    }

    function RunIntheView(){
        var Demo = $("#DemoImage");
        var DemoWidth = Demo.width();
        var DemoHeight = Demo.height();
        var ZoomProportion =  2;
        var zoomSpeed = 500;
        Demo.animate({
          'left' : (DemoWidth * ZoomProportion),
          // 'height' : (DemoHeight * ZoomProportion),
        }, zoomSpeed, function(){
          Default();
        })

    }

    function RunOutTheView(){
        var Demo = $("#DemoImage");
        var DemoWidth = Demo.width();
        var DemoHeight = Demo.height();
        var ZoomProportion =  2;
        var zoomSpeed = 500;
        Demo.animate({
          'left' : (DemoWidth * ZoomProportion * -1),
          // 'height' : (DemoHeight * ZoomProportion),
        }, zoomSpeed, function(){
          Default();
        })

    }

    function LandInView(){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 800;
        Demo.animate({
          'top' : (DemoWidth * ZoomProportion * -1),
        }, 0, function(){

        Demo.animate({
          'top' : (DemoWidth * ZoomProportion * 0),
        }, zoomSpeed, function(){
          Default();
        })
      });
    }

    function LandInViewDiagonal(){
      var Demo = $("#DemoImage");
      var DemoWidth = Demo.width();
      var DemoHeight = Demo.height();
      var ZoomProportion =  2;
      var zoomSpeed = 500;
      Demo.animate({
        'top' : (DemoWidth * ZoomProportion * -1),
        'left': (DemoWidth * ZoomProportion * -1),
      }, 0, function(){

      Demo.animate({
        'top' : (DemoWidth * ZoomProportion * 0),
        'left': (DemoWidth * ZoomProportion * 0),
      }, zoomSpeed, function(){
        Default();
      })
    });
    }


        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
        //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue
    //Recorded Dialogue Recorded Dialogue Recorded Dialogue Recorded Dialogue






//https://p5js.org/reference/#/libraries/p5.sound
//https://www.youtube.com/watch?v=YcezEwOXun4&list=PLRqwX-V7Uu6aFcVjlDAkkGIixw70s7jpW&index=2

    $(document).ready(function(){
          // creating html elements and appending them to the html objects
      $("#RecorededDialogue").click(function(){
        if( $('.StoryContent').eq(ArtIndex).find('.AudioDraggableObject').length ){
            AlertFunction('A Recored and Audio Object already exists here.');
        }else{
            AddedRecordedDialouge();
            $('.StoryContent').eq(ArtIndex).find('.Audio').trigger('click');
          }
        });
      });

      function AddedRecordedDialouge(){
          var textObject = $('<div class="DialogueDraggableObject"><div class="Text" id=""><label class="TextButtonLabel">No Text</label></div></div>');// element created
          var textLocation = $('.StoryContent').eq(ArtIndex).find(".StoryDialougeWork");
          textObject.appendTo(textLocation);
          initializeTextDraggable();
          initializeText();




          var AudioObject = $('<div class="AudioDraggableObject"><div class="Audio" id="" data="" ><label class="AudioButtonLabel">No Audio</label></div></div>');// element created
          //Appending the Text Dialogue to the same index as the Recorded Audio
          var appendLocation = $(".StoryContent").eq(ArtIndex).find(".RecorededWork");
          var TextObject = $('<div class="DialogueDraggableObject" id="FirstDialogue"><div class="Text"><label class="TextButtonLabel">No Text</label></div></div>');
          AudioObject.appendTo(appendLocation);
          InitializeAudioDraggable();
      }


      function InitializeAudioDraggable(){
        console.log('InitializeAudioDraggable() function called!')

        $('.Audio').click(function(){
          var index = $(this).index();
          SelectionOptions(ClickedObject = '.AudioOptions', indexOfObject = index);
          ArtIndex = $(this).parents('.StoryContent').index();
          SelectedArtItems();
          playAudio();
          //hide all adavance controls except this one
          hideAdvanceControls();
          $('.AdvanceTextControls').fadeIn();

          if( $(this).attr('data') != ""){
            var index = parseInt( $(this).attr('data') );
            var text = "" + choosenAudioArray[index].scriptCharacter + " : " + choosenAudioArray[index].scriptText + "";
            $('#explainationBox').text(text);
            $('.DemoStoryText').text(text);
          }
        });


          $('.AudioDraggableObject').draggable({
            axis: "x",
            revert : "invalid",
            appendTo: ".GridAudio" ,
            snap: ".GridAudio",
            snapMode: "inner",
            snapTolerance: 20,
            start: function(){
               BeforeDragPostion = $(this).parents('.StoryContent').index();
               console.log("BeforeDragPostion: " + BeforeDragPostion)
               dataIndex = parseInt($(this).parents('.StoryContent').find('.Audio').attr('data') );
               console.log("Data Index: " + dataIndex);
            },
            drag: function( event, ui ) {

            },
          });


        hideAdvanceControls();
        $('.AdvanceAudioControls').fadeIn();
      }



      function InitializeAudioDroppable(){
        $(function () {
          $( ".GridAudio" ).droppable({
            accept: '.AudioDraggableObject',
            drop: function(event, ui){
              var dropped = ui.draggable;
              var indexPrevious = BeforeDragPostion;
              var indexCurrent = $(this).parents('.StoryContent').index();
              $('.StoryContent').eq(BeforeDragPostion).find('.DialogueDraggableObject').remove();
              dropped.remove();
              ArtIndex = indexCurrent;
              AudioText(objectype = 0 , beforDrop = indexPrevious , afterDrop = indexCurrent)
              SelectedArtItems();
              $('.StoryContent').eq(indexCurrent).find('.Audio').trigger('click');
                // Meant to update the array but for this scnerio the array will not be updated:
            }
          });
        });
      }


      function AudioText(objectype , beforeDrop , afterDrop){
        switch (objectype) {

          case 0:
          AddedRecordedDialouge(); // Adds both a Audio and Text object to the index
          UpdateTextAndAudioObjects(dataIndex); // Updates the Text and Audio Objects with the appropriate data
          break;

          case 1:
          AddedRecordedDialouge();
          UpdateTextAndAudioObjects(dataIndex);
          break;

          default:

        }
      }

    function playAudio(){
      if( $(this).attr('id') != null && $(this).attr('id') != '' ){
        var ThisURL = $(this).attr('id');
        var thisAudio = new Audio(ThisURL);
        thisAudio.play();
      }
    }




// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:
// Story Music object: Story Music object: Story Music object: Story Music object: Story Music object:

// var storyMusicData = new Array();
// function createMusicAndSFXDataObject(){
//   var MusicAndSFXObject =
//   {
    // "StoryMusicData" : {
    //     "ref" : "",// has ref because the audio is stored on the backend
    //     "Index" : "",
    //     "volume" : 5 ,// this has to deal with regualr volume controls... the peak volume for this object
    //     "isStarting" : "",
    //     "isEnding" : "",
    //     "introTaper" : 0,
    //     "endTaper" : 0,
    //     "volumeControls" : "",// default to nothing but can and will be updated for differeing play stylesheet... this has more to do with the intensity graph of the object
    //     "panning" : "", //for panning styles... for better story telling
    //     "panningStyle" : "",// for panning timing and attack stuff like that... for better story telling
    //   },
//
//     return MusicAndSFXObject;
// }


function Grid(){
  // creates a grid object that essentiall
  var StoryContent = $('.StoryContent');
  var WidthOfStoryContentDiv = StoryContent.innerWidth();
  var WidthOfStoryContentDivWithMargin = StoryContent.outerWidth(true);
  var MarginSize = WidthOfStoryContentDivWithMargin - WidthOfStoryContentDiv;
  var GridBoxesLength = WidthOfStoryContentDivWithMargin / MarginSize ;

  return GridBoxesLength;
}


var MusicArray = new Array();

function CreatingArrayObjects( IndexOfResizable, StartingIndex , EndingIndex, StartTime, EndTime, Tapering, VolumeMetrics, ArrayForData){
  var Data = {
    "IndexOfResizeable" : IndexOfResizable,
    "StartingIndex" : StartingIndex,
    "EndingIndex": EndingIndex ,
    "StartTime" : StartTime,
    "EndTime" : EndTime,
    "Tapering" : Tapering,
    "VolumeMetrics" : VolumeMetrics,
  }

  MusicArray.push(Data);
  console.log(MusicArray)
}


var indexCounter = 0;
$("#MusicScore").click(function(){
  var MusicObject = $('<div class="StoryMusicDraggableObject" style:"z-index: '+ indexCounter +'"><div class="MusicGrid"><div class="Music"><label class="MusicButtonLabel">Chaotic Tumbl</label></div></div></div>');// element created
  // var musicPlacementLocation = $('.MusicheStation');
  var musicPlacementLocation = $('.MusicheGridMusic').eq(ArtIndex);
  musicPlacementLocation.append(MusicObject);
  indexCounter = indexCounter + 1;

  InitializeMusicObject();
  // creating a way to store data in an array object
  CreatingArrayObjects( IndexOfResizable = ArtIndex, StartingIndex = ArtIndex, EndingIndex = ArtIndex, EndingIndex = null, StartTime = null, Tapering = null , VolumeMetrics = null , ArrayForData = null)
});



function InitializeMusicObject(){
  // resizable:
    $(".MusicGrid").resizable({
      handles: 'e, w' ,
      grid : [Grid(), 0],
      start: function( event, ui ){
      },
      stop: function( event, ui ){
        var Index = $(this).parents('.StoryContent').index();
        var Postion = $(this).offset().left;
        var width = $(this).innerWidth();
        ResizableGridRelation(ResizablePostion = Postion , ResizeableWidth = width, IndexOfResizable = Index);
      }
    });
  //Draggable:
  $('.StoryMusicDraggableObject').draggable({
    axis : "x",
    grid : [Grid(), 0],
    stop: function( event, ui){
      var Index = $(this).parents('.StoryContent').index();
      var Postion = $(this).offset().left;
      var width = $(this).innerWidth();
      ResizableGridRelation(ResizablePostion = Postion , ResizeableWidth = width, IndexOfResizable = Index);
    }
});
//Clickable :
  $('.Music').click(function(){
    var index = $(this).index();
    SelectionOptions(ClickedObject = '.MusicOptions', indexOfObject = index);
    //hide all adavance controls except this one
    hideAdvanceControls();
    $('.AdvanceMusicControls').fadeIn();
  });
}



function ResizableGridRelation(ResizablePostion , ResizeableWidth, IndexOfResizable){
    CheckingLeftGrid(leftEdge = ResizablePostion , ResizeableWidth = ResizeableWidth, IndexOfResizable);
}

var ResizableStartIndex = null;
var ResizableEndIndex = null ;

function CheckingLeftGrid(leftEdge, ResizeableWidth, IndexOfResizeable){
    var gridWidth = $('.StoryContent').innerWidth();
    var GridWithMargin = $('.StoryContent').outerWidth(true);
    var MarginSize = Grid();
    var foundflag = false;

    // Basically if we have StoryContent divs then run this function because this requires StoryContent
    for(x = 0 ; x < $('.StoryContent').length ; x++){
      //Grid in question postion
      var CurrentGridPostion = $('.StoryContent').eq(x).offset().left;
      //Grid range : because it is the postion plus it's width
      var ExactGridRange = CurrentGridPostion + gridWidth;
      // Rounded Value of left edge to get closer to actuall value to deal with less errors for both the grid and musuche left edge
      var ResizableLeftEdge = Math.round(leftEdge);
      var GridLeftEdge = Math.round(CurrentGridPostion);
      var GridRange = Math.round(ExactGridRange);
      var StartTime = null;
      // If statement withthin the actuall rounded value or +- 2 pixels
      if( (ResizableLeftEdge >= (GridLeftEdge - MarginSize - 1)) && (ResizableLeftEdge < (GridRange + 1)) ){
        // Resizable Checking to see if the value is in the range of the
        if( (ResizableLeftEdge >= (GridLeftEdge - MarginSize - 1)) && (ResizableLeftEdge <= (GridLeftEdge + 1)) ){
          /// this is to insure that the start time value equals zero if it is within the margin or equal to the left edge of the grid
          StartTime = 0.0;
          ResizableStartIndex = x; // stores the start postion of this grid object
          foundflag == true;
          CheckingRightGrid(RightEdge = (CurrentGridPostion + ResizeableWidth ), IndexOfLeftEdge = x, IndexOfResizeable = IndexOfResizeable, StartTime = StartTime)
        }else{
          var LeftEdgeDisplacement = (ResizableLeftEdge - GridLeftEdge);// distance from the left edge
          var GridSize = (GridRange - GridLeftEdge);
          StartTime = Math.abs(LeftEdgeDisplacement / GridSize);
          ResizableStartIndex = x; // stores the start postion of this grid object
          foundflag == true;
          CheckingRightGrid(RightEdge = (CurrentGridPostion + ResizeableWidth ), IndexOfLeftEdge = x, IndexOfResizeable = IndexOfResizeable, StartTime = StartTime)
        }

        break;
      }else{
        if(foundflag == false){
         ResizableStartIndex = null; // stores the start postion of this grid object
        }
      }
    }
}


// Should make this a function nested in CheckingLeftGrid() so that the IndexOfLeftEdge parameter makes sense
function CheckingRightGrid(RightEdge, IndexOfLeftEdge, IndexOfResizeable, StartTime){
  var gridWidth = $('.StoryContent').innerWidth();
  var GridWithMargin = $('.StoryContent').outerWidth(true);
  var MarginSize = Grid();
  var foundflag = false;
  for(i = IndexOfLeftEdge || 0 ; i < $('.StoryContent').length ; i ++){// right edge starts at the the left edges index this becase the left edeg index is the minimum location
    var CurrentGridPostion = $('.StoryContent').eq(i).offset().left;
    var ExactRightEdge = (CurrentGridPostion + gridWidth);

    var GridRightEdge = Math.round(ExactRightEdge);
    var GridLeftEdge = Math.round(CurrentGridPostion);
    var ResizableRightEdge = Math.round(RightEdge);
    var EndTime = null;

    if( (ResizableRightEdge >= (GridLeftEdge - MarginSize - 1)) && (ResizableRightEdge < (GridRightEdge + 1)) ){
      if( (ResizableRightEdge >= (GridLeftEdge - MarginSize - 1)) && (ResizableRightEdge <= (GridLeftEdge + 1)) ){
        /// this is to insure that the start time value equals zero if it is within the margin or equal to the left edge of the grid
        console.log("it started")
        console.log("Start : " + ResizableStartIndex)
        console.log("Stop : " + ResizableEndIndex)

        ResizableEndIndex = i;
        foundflag = true;
        EndTime = 0.0;
        UpdatingResizedObject(IndexOfResizeable = IndexOfResizeable, Start = ResizableStartIndex , End = ResizableEndIndex, StarTime=  StartTime, EndTime = EndTime)
      }else{
              /// this is to insure that the start time value equals zero if it is within the margin or equal to the left edge of the grid
              ResizableEndIndex = i;
              foundflag = true;
              var RightEdgeDisplacement = (ResizableRightEdge - GridLeftEdge);// distance from the left edge
              var GridSize = (GridLeftEdge - GridRightEdge);
              EndTime = Math.abs(RightEdgeDisplacement / GridSize);
              UpdatingResizedObject(IndexOfResizeable = IndexOfResizeable, Start = ResizableStartIndex , End = ResizableEndIndex, StarTime =  StartTime, EndTime = EndTime)

              console.log("it started")
              console.log("Start : " + ResizableStartIndex)
              console.log("Stop : " + ResizableEndIndex)
              console.log("Start Time : " + StartTime)
              console.log("End Time : " + EndTime)
            }

            break;
    }else{
      if(foundflag == false){
        ResizableEndIndex = null;
      }
    }
  }
}

function UpdatingResizedObject(IndexOfResizeable, Start, End, StarTime, EndTime){
  for(x = 0 ; x < MusicArray.length ; x++){
    if( IndexOfResizeable == MusicArray[x].IndexOfResizeable){
      MusicArray[x].volume = Start;
      MusicArray[x].isStarting = End;
      MusicArray[x].isEnding = StarTime;
      MusicArray[x].StarTime = EndTime;

      // // storyMusicData[x].ref = ;// has ref because the audio is stored on the backend
      // "volume" : "",// this has to deal with regualr volume controls... the peak volume for this object
      // "isStarting" : "",
      // "isEnding" : "",
      // "intro" : "",
      // "end" : "",
      // "volumeControls" : "",// default to nothing but can and will be updated for differeing play stylesheet... this has more to do with the intensity graph of the object
      // "panning" : "", //for panning styles... for better story telling
      // "panningStyle" : "",// for panning timing and attack stuff like that... for better story telling

      break;
    }
  }
  console.log(MusicArray);
}



function MusicVolumeSliderValue(value){
  // var value = document.getElementById('distanceDiv').value();
  var valueInt = parseInt(value);
  var value = (valueInt);
  $('.AnimationSpeedLabel').text(" " + value);
  // updating the animation speed data on the story data obejct
  storyData[ArtIndex].AnimationData.speed = value;

  console.log("Speed Value : " + storyData[ArtIndex].AnimationData.speed);
}


function updateIntroTaper(){
  var index = $("select[name='introTaper'] option:selected").index();
}

function updateOutroTaper(){
  var index = $("select[name='outroTaper'] option:selected").index();
}



//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:
//SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX: SFX:

// var storySFXData = new Array();
// function createMusicAndSFXDataObject(){
//   var MusicAndSFXObject =
//   {
//       "SFXData" : {
//         "ref" : "",// has ref because the audio is stored on the backend
//         "volume" : "",// this has to deal with regualr volume controls... the peak volume for this object
//         "isStarting" : "",
//         "isEnding" : "",
//         "intro" : "",
//         "end" : "",
//         "volumeControls" : "",// default to nothing but can and will be updated for differeing play stylesheet... this has more to do with the intensity graph of the object
//         "panning" : "", //for panning styles... for better story telling
//         "panningStyle" : "",// for panning timing and attack stuff like that... for better story telling
//       },
//     }
//     return MusicAndSFXObject;
// }

  // Keeping track of Data to be sent to the backend server:
  var SFXArray = new Array();

  function InitializeSFXObjects(){
    // initialize droppable
    InitializeSFXDroppable();
    // initilize draggable click
    InitalizeSFXDraggableAndOnClickFunction();
    // Initialize draggabel
    InitializeSFXDraggable();
    // add sfx value to selection board

    // make selection board SFX functional
    SetSelectionSFXObject();
  }

  // Check/



// Check/
  var SFXBeforeDrag = null;
  var SFXArrayLocaiton = null;
  function ReplacingSFXDraggable(droppedIndex){


  }

// not/
  function InitalizeSFXDraggableAndOnClickFunction(){
    $("#StorySFX").click(function(){
      var sfxObject = $('<div class="SFXDraggableObject"><div class="SFX" id=""><label class="SFXButtonLabel">No SFX</label></div></div>');// element created
      var sfxLocation = $('.StoryContent').eq(ArtIndex).find(".SFXWork");
      sfxObject.appendTo(sfxLocation);
      InitializeSFXDraggable();
      InitializeSFXButtonClick();
      InitializeSFXDroppable();
      });
  }


// Check/
var sfxPreviousPos;
var sfxNewPos;
  function InitializeSFXDraggable(){
    $(function () {
      $('.SFXDraggableObject').draggable({
        axis: "x",
        revert : "invalid",
        appendTo: ".GridSFX" ,
        snap: ".GridSFX",
        snapMode: "inner",
        snapTolerance: 20,
        start: function(){
           sfxPreviousPos = $(this).parents('.StoryContent').index();
           console.log("BeforeDragPostion: " + sfxPreviousPos)
           // dataIndex = parseInt($(this).parents('.StoryContent').find('.SFX').attr('data') );
           // console.log("Data Index: " + dataIndex);
        },
        drag: function( event, ui ) {

        },
      });
    });
  }

  function InitializeSFXDroppable(){
    $(function () {
      $( ".GridSFX" ).droppable({
        accept: '.SFXDraggableObject',
        drop: function(event, ui){
          var dropped = ui.draggable;
          var indexPrevious = sfxPreviousPos;
          var indexCurrent = $(this).parents('.StoryContent').index();
          dropped.remove();
          ArtIndex = indexCurrent;
          replaceDraggedObject(beforDrop = indexPrevious , afterDrop = indexCurrent);
          SelectedArtItems();
          $('.StoryContent').eq(indexCurrent).find('.SFX').trigger('click');
            // Meant to update the array but for this scnerio the array will not be updated:
        }
      });
    });
  }

  function replaceDraggedObject(beforeDrop , afterDrop){

      AddSFXDraggable(); // Adds both a Audio and Text object to the index
  }

// check/
function CheckForSFXObjectHere(Index){
  if($('.StoryContent').eq(Index).find('.SFXDraggableObject').length){
    return true;
  }else{
    return false;
  }
}

  // check/
function AddSFXDraggable(){
    if(CheckForSFXObjectHere(ArtIndex) == false){
    // 1. Create and SFX Object :
      var newDraggableObject = $('<div class="SFXDraggableObject" id="FirstSFX"><div class="SFX"><label class="SFXButtonLabel">Rubble</label></div></div>');// element created
    // 2. Append it to the proper div :
      var AppendLocation =  $('.StoryContent').eq(ArtIndex).find('.SFXWork');
      $(newDraggableObject).appendTo(AppendLocation).hide().fadeIn(400);
      InitializeSFXButtonClick();
    }else{
      AlertFunction('A Sound Effect object already exists here.');
    }
}


function InitializeSFXButtonClick(){
  $('.SFX').click(function(){
    var thisIndex = $(this).parentsUntil('.StoryContent').index();
    SelectionOptions(ClickedObject = '.SFXOptions', index = thisIndex);
    ArtIndex = $(this).parents('.StoryContent').index();
    SelectedArtItems();
    var NewArtSrc = $('.StoryContent').eq(ArtIndex).find('.Art').attr('src');
    $('#DemoImage').attr('src' , NewArtSrc );
    //hide all adavance controls except this one
    hideAdvanceControls();
    $('.AdvanceSFXControls').fadeIn();
  });
}





// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
// Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text : Story Text :
$(document).ready(function(){

    // creating html elements and appending them to the html objects
    $("#StoryText").click(function(){
      if($('.StoryContent').eq(ArtIndex).find('.DialogueDraggableObject').length){
          AlertFunction('A Recored and Audio Object already exists here.');
      }else{
          AddedRecordedDialouge();
          $('.StoryContent').eq(ArtIndex).find('.Text').trigger('click');
        }
  });

});


function initializeTextDraggable(){

    $('.DialogueDraggableObject').draggable({
      revert : "invalid",
      axis : "x",
      connectToSortable: ".GridStoryDialougeWork",
      appendTo: ".GridText" ,
      snap: ".GridText",
      snapMode: "inner",
      snapTolerance: 40,
      start: function(){
        BeforeDragPostion = $(this).parents('.StoryContent').index();
        console.log("BeforeDragPostion: " + BeforeDragPostion)
        dataIndex = parseInt($(this).parents('.StoryContent').find('.Text').attr('id') );
        console.log("Data Index: " + dataIndex);
      },

    });

  initializeText();
}


function initializeText(){
  $('.Text').click(function(){
    var thisIndex = $(this).parentsUntil('.StoryContent').index();
    SelectionOptions(ClickedObject = '.TextOptions', index = thisIndex);
    ArtIndex = $(this).parents('.StoryContent').index();
    SelectedArtItems();
    var NewArtSrc = $('.StoryContent').eq(ArtIndex).find('.Art').attr('src');
    $('#DemoImage').attr('src' , NewArtSrc );
    //hide all adavance controls except this one
    hideAdvanceControls();
    $('.AdvanceTextControls').fadeIn();

    if( $(this).attr('id') != ""){
      var index = parseInt( $(this).attr('id') );
      var text = "" + choosenAudioArray[index].scriptCharacter + " : " + choosenAudioArray[index].scriptText + "";
      $('#explainationBox').text(text);
      $('.DemoStoryText').text(text);
    }

  })
}


function InitializeTextDroppable(){
  $(function () {
    $( ".GridText" ).droppable({
      accept: '.DialogueDraggableObject',

      drop: function(event, ui){
        var dropped = ui.draggable;
        var indexPrevious = BeforeDragPostion;
        var indexCurrent = $(this).parents('.StoryContent').index();
        $('.StoryContent').eq(BeforeDragPostion).find('.AudioDraggableObject').remove();
        dropped.remove();
        ArtIndex = indexCurrent;
        AudioText(objectype = 1 , beforDrop = indexPrevious , afterDrop = indexCurrent)
        SelectedArtItems();
        $('.StoryContent').eq(indexCurrent).find('.Text').trigger('click');
          // Meant to update the array but for this scnerio the array will not be updated:
      }

    });
  });
}




function showScriptMoadl(){

}


var transferScriptBasicData;
var transferScriptContentData;
function getTransferScript(){
  var docRef = db.collection("CreativeUsers").doc(UserId);
  var scriptRefID = "";
  // Gets the user id document to get the transfer script
  docRef.get().then(function(doc) {
    if (doc.exists) {
      // sets the doc ref to the reference of the transfer script
        docRefID = doc.data().transferScript;
      // then goes to retrieve the script using it's transfer ref
        var srciptRef = db.collection("CreativeUsers").doc(UserId).collection("Scripts").doc(scriptRefID);
      // calls a get request on the transfer script
        srciptRef.get().then(function(doc) {
            if (doc.exists) {
                transferScriptBasicData = doc.data();

                // Script getting that script reference it should only have one object to query but it's not worth the code to attempt to get the doc ref:
                var srciptContentRef = db.collection("CreativeUsers").doc(UserId).collection("Scripts").doc(scriptRefID).collection("ScriptContent");
                srciptContentRef.get().then(function(querySnapshot) {
                querySnapshot.forEach(function(doc) {
                  // Places the Transfer Script content in the transferScriptContentData var :
                  transferScriptContentData = doc.data();

                });
              });

            } else {
                console.log("Could not find that script data:");
            }
            }).catch(function(error) {
                console.log("Error getting document:", error);
            });

        /// end of if statement for first look

    } else {
        console.log("No Trnasfer feild in Doc!");
    }
    }).catch(function(error) {
      console.log("Error getting document:", error);
    });

}



var oldScripts = [];
function getScripts(){
    var user = firebase.auth().currentUser;

    firebase.auth().onAuthStateChanged(function(user){
      var db = firebase.firestore();
      var UserId = "" + user.uid + "";
      var docRef = db.collection("CreativeUsers").doc(UserId).collection("Scripts");

      docRef.get().then(function(querySnapshot) {
      querySnapshot.forEach(function(doc) {
          var createdScriptsData = {
            "id" : doc.id,
            "ScriptData" : doc.data(),
          }
          oldScripts.push(createdScriptsData);
          // console.log(oldScripts);
          // placingCreatedScripts();
      });
    });


    })
}




// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
// Add Author : Add Author : Add Author : Add Author : Add Author : Add Author
var DefaultArtist = ' "Rosso Leo" '
var HoldAllArtistArray = [];/// Array after the user presses confirm that holds all the
$(document).ready(function () {

  $("#DefaultAuthor").val(DefaultArtist);

  //Dismiss Addd Artists Button :
  $('.DismissButton').click(function(){
    $('#AddAnotherArtistModal').fadeOut(500);
  });

  // Fade Add Artists:
  $('#AddAuthor').click(function(){
    $('#AddAnotherArtistModal').fadeIn(400);
  })

  // Add Artist :
  $('.AddArtistButton').click(function(){
    AddArtists();
    $('.AddingArtistInput').focus();
  })

  // Confirm Function :
  $('.AddArtistConfirmationButton').click(function(){
     ConfirmAddArtists();
  });

    $('.LocationOfToBeAddedArtists').click(function(){
      $(".RemoveArtistButton").fadeIn(100);
  });

  $(".RemoveArtistButton").click(function(){
    Remove();
    $(".RemoveArtistButton").fadeOut(100);
    $(".RemoveArtistButton").hide(0);
  });

});

var ArrayOfArtists = []
function AddArtists(){
  var NewArtists = $('.AddingArtistInput').val();
  if (NewArtists == '' || NewArtists == null ){
    $('.AddArtistErrorMessage').fadeIn(10, function(){
      $('.AddArtistErrorMessage').fadeOut(2000);
    });
  }else{
      if (ArrayOfArtists.length <= 0){
        var NewArtistsLabel = $( '<label class="LocationOfToBeAddedArtists">'+ NewArtists +'</label>');
        NewArtistsLabel.appendTo('.ArtistsLabelsAddDiv');
        ArrayOfArtists.push(NewArtists);
        $('.AddingArtistInput').val('')
        SetAddedArtist();
      }else{
        // This "else" statement is to deal with the comma needing to be added after appending an object to a "ArtistsLabelsAddDiv"
        var NewArtistsLabel = $( '<label class="LocationOfToBeAddedArtists">, '+ NewArtists +'</label>');
        NewArtistsLabel.appendTo('.ArtistsLabelsAddDiv');
        ArrayOfArtists.push(NewArtists);
        $('.AddingArtistInput').val('')
        SetAddedArtist();
      }// this is to propperly space objects such that there is one smoothe clean design
    }
}

function ConfirmAddArtists(){
  // empties the array such when you press confirm
  if (ArrayOfArtists.length <= 0){
    $('.AddArtistErrorMessage').fadeIn(10, function(){
      $('.AddArtistErrorMessage').fadeOut(2000);
      //for the edge cases where a user doesn't add any data
    });
  }else{
    // ArrayOfArtists.splice(0, ArrayOfArtists.length);
        // normal functionality
      $(".AddedAuthor").remove()
      for(x = 0; x < ArrayOfArtists.length; x++){
        if(x == 0){
          var AritstsNames = $('<label class="AddedAuthor" id="'+ "Artist" + $(".AddedAuthor").index() + '">, '+ ArrayOfArtists[x] +'</label> ');
          AritstsNames.appendTo(".AddAuthorTextDiv");

        }else{
        var AritstsNames = $('<label class="AddedAuthor" id="'+ "Artist" + $(".AddedAuthor").index() + '">, '+ ArrayOfArtists[x] +'</label> ');
        AritstsNames.appendTo(".AddAuthorTextDiv");
        }
      }
      var FinalName = $(".AddedAuthor").last()
      $("#AddAuthor").insertAfter(FinalName);

      $('#AddAnotherArtistModal').fadeOut(500);
    }
    // if($(".AddedAuthor").length ==  ArrayOfArtists.length){
    //   $("#AddAuthor").insertAfter(".AddedAuthor");
    // }

}


function ReplaceArtistName(){
  // robots
}

var indexOfArtistAddedSelected = null;
function SetAddedArtist(){
  $('.LocationOfToBeAddedArtists').click(function(){
    $(".RemoveArtistButton").fadeIn(100);
    indexOfArtistAddedSelected = $(this).index();
  });
}

function Remove(){
  //Remove From Array :
  ArrayOfArtists.splice(indexOfArtistAddedSelected,1);
  //Remove It from modal:
    $(".LocationOfToBeAddedArtists").eq(indexOfArtistAddedSelected).remove();
  //Remove It from Add authot basic data:
    $('.AddedAuthor').eq(indexOfArtistAddedSelected).remove();
}
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
// Selection Board Functionality Selection Bourd Functionality Selection Board Functionality:
$(document).ready(function(){

      $('#AddTags').click(function(){
        var thisIndex = $(this).index();
        SelectionOptions(ClickedObject = '.TagOptions', index = thisIndex)
      });
      $('.Audio').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.AudioOptions', index = thisIndex)
      });
      $('.Music').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.MusicOptions', index = thisIndex)
      });
      $('.SFX').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.SFXOptions', index = thisIndex)
      });
      $('.Text').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.TextOptions', index = thisIndex)
      });
});
///Add Tags Selction Board Object:
var SelectionBoardOptionsBool = true;
var indexOfObject = null;/// stores index of object to compare
var indexOfObjectFlag = false;
function SelectionOptions(ClickedObject , index){
  SelectionBoardOptionsBool = !SelectionBoardOptionsBool;
  const ObjectInUse = ClickedObject;
  var IndexOfClickedObject = index;
          VisibleSelectionObjects(); // checks to see if any other object is visible before execution
          if(ObjectsAreVisible == true && VisibleObject != null){
            if(VisibleObject != ObjectInUse){
              $(VisibleObject).fadeOut(500).slideUp(250, function(){
                $(ObjectInUse).fadeIn(500).slideDown(250);
              });
            }else{
              $(ObjectInUse).fadeIn(500).slideDown(250);
            }
                if(VisibleObject.trim() ===  ObjectInUse.trim()){
                  // if( ClickedObject != '.ArtOptions'){
                  //     if(index == IndexOfClickedObject){
                  //       // checking if the index in the same object type are the same... if they are the same then remove the object type from selection board
                  //         $(ObjectInUse).fadeOut(500).slideUp(250);
                  //     }else{
                  //       // if they aren't the same... then do some computation... it leaves space open such that if I need it I can use it
                  //     }
                  //   }
                }else{
                    // $(VisibleObject).fadeOut(500).slideUp(250, function(){
                    //   $(ObjectInUse).fadeIn(500).slideDown(250);
                    // });
                  }
          }else{
                $(ObjectInUse).fadeIn(500).slideDown(250);
          }/// if objects aren't visible then
          indexOfObject = IndexOfClickedObject;
}//AnimationOptions

var ObjectsAreVisible = false; // default to false
var VisibleObject = null;
function VisibleSelectionObjects(){
  if(  ($('.TagOptions').is(':visible')) ||  ($('.ArtOptions').is(':visible')) || ($('.AudioOptions').is(':visible'))  || ($('.MusicOptions').is(':visible')) ||  ($('.SFXOptions').is(':visible'))  || ($('.TextOptions').is(':visible')) || ($('.AnimationOptions').is(':visible')) ){
          ObjectsAreVisible = true;
          if ($('.TagOptions').is(':visible')){
            VisibleObject = ".TagOptions";
          }
          if($('.ArtOptions').is(':visible')){
            VisibleObject = ".ArtOptions";
          }
          if($('.AudioOptions').is(':visible')) {
            VisibleObject = ".AudioOptions";
          }
          if($('.MusicOptions').is(':visible')){
            VisibleObject = ".MusicOptions";
          }
          if($('.SFXOptions').is(':visible')){
            VisibleObject = ".SFXOptions";
          }
          if($('.TextOptions').is(':visible')){
            VisibleObject = ".TextOptions";
          }
          if($('.AnimationOptions').is(':visible')){
            VisibleObject = ".AnimationOptions";
          }
  }else{
    ObjectsAreVisible = false;
    VisibleObject = null;
  }
}


function ActivateSelectionBoard(){
    $(document).ready(function(){

      $('#AddTags').click(function(){
        var thisIndex = $(this).index();
        SelectionOptions(ClickedObject = '.TagOptions', index = thisIndex)
      });
      $('.Animate').click(function(){
        console.log("Im working fine.");
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        AnimationRecentIndex = index;
        SelectionOptions(ClickedObject = '.AnimationOptions', index = thisIndex)
      });
      $('.Audio').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.AudioOptions', index = thisIndex)
      });
      $('.Music').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.MusicOptions', index = thisIndex)
      });
      $('.SFX').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.SFXOptions', index = thisIndex)
      });
      $('.Text').click(function(){
        var thisIndex = $(this).parentsUntil('.StoryContent').index();
        SelectionOptions(ClickedObject = '.TextOptions', index = thisIndex)
      });
  });
}



//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box
//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box//Explaination Box //Explaination Box

$(document).ready(function(){
  $('.AdvancedButton').click(function(){
    $('.ExplainationObject').fadeOut(250).hide();
    $('.AdvancedControls').fadeIn(250);
    $('.AdvancedButton').css({'color' : '#FFC842'});
    $('.ExplainationButton').css({'color' : 'gray'});
  });

  $('.ExplainationButton').click(function(){
    $('.AdvancedControls').fadeOut(250).hide();
    $('.ExplainationObject').fadeIn(250);
    $('.ExplainationButton').css({'color' : '#FFC842'});
    $('.AdvancedButton').css({'color' : 'gray'});

  });
});





// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station
// Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station // Audio Station

//https://developers.google.com/web/fundamentals/media/recording-audio <----- deep help to understanding this functionality
//https://github.com/higuma/web-audio-recorder-js <------ Library being used to simplify the proccess
const microphone = $('.Recorder');


const microphoneSuccess = function(stream){
  console.log("Being Called")
//const UserAudio = navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
const AudioContext = window.AudioContext || window.webkitAudioContext || window.mozAudioContext || window.oAudioContext || window.msAudioContext;/// looking for the proper audio context


  //1. create Audio context: https://developer.mozilla.org/en-US/docs/Web/API/AudioContext
  const context = new AudioContext();

  //2. create creatMediaStreamSource: https://developer.mozilla.org/en-US/docs/Web/API/AudioContext/createMediaStreamSource
  const source = context.createMediaStreamSource(stream);
  //3. creater crerateScriptProcessor : https://developers.google.com/web/fundamentals/media/recording-audio
  const processor = context.createScriptProcessor(1024, 1, 1);
  //4. connect audio input to to context streaming function for manipulation and use:
  source.connect(processor);
  processor.connect(context.destination);



  processor.onaudioprocess = function(e) {
    // Do something with the data, e.g. convert it to WAV
    // var recorder = new WebAudioRecorder(sourceNode);
    //console.log(recorder.isRecording());

    // var recorder = new WebAudioRecorder(sourceNode = source);
    // recorder.startRecording();
    // console.log(recorder.isRecording());



    console.log(e.inputBuffer);
  };
  //5.
  //var recorder = new WebAudioRecorder(AudioNode);
  //6. recordingstarted:
  //recorder.startRecording();
  console.log("is starting somewhere here");
  //console.log(recorder.isRecording());
    if (window.URL) {
      microphone.srcObject = stream;
    } else {
      microphone.src = stream;
    }
}








// var mic;
// function setup() {
//   mic = new p5.AudioIn();
//   mic.start();
// }

// function draw(){

// }

var RecordingData = [];
var RecordingSrcArray = new Array();

//LoadSuccess(true);
$('.RecordButton').click(function(){

navigator.mediaDevices.getUserMedia({ audio: true, video: false }).then(function(stream){
 let mediaRecorder = new MediaRecorder(stream);
 mediaRecorder.start();
 console.log(mediaRecorder.state);
 LoadSuccess(true);
 $('.StopButton').click(function(){
  mediaRecorder.stop();
 });

 // $('.PlayButton').click(function(){
 //  mediaRecorder.stop();
 // });

 mediaRecorder.ondataavailable = function(currentlyData){
   RecordingData.push(currentlyData.data)
 };


    mediaRecorder.onstop = function(recordedData){
      var BlobObject = new Blob(RecordingData , {'type' : 'audio/mp3'});
      RecordingData = [];
      var AudioUrl = window.URL.createObjectURL(BlobObject);
      RecordingSrcArray.push(AudioUrl);
      $('.Microphone').attr('src' , RecordingSrcArray[ RecordingSrcArray.length - 1 ]);
    };
 //LoadSuccess(true);
}).catch(function(err){
  // this catch function is to deal with any error that comes from not having access to the users media... this in the future will prompt a box
  // that tells the user why we need access to their microphone and tells them how to turn it on. if the user has selected never to allow access to
  // micrphone then we should disply instruction depending on their browser on how to make it accessable to this website again... there should be a button in that pop ups that allows the user to opt out of allowing us to use the microphone because they plan to upload a file
  console.log('Could not gain access to media object from the user' +", Error Name: " + err.name + ", Error Message: " + err.message);
  LoadSuccess(true);
});

});


  // allows to load screen after asking for the mic has been successful
//   LoadSuccess(true);
// })
//.catch(function(err){
  // this catch function is to deal with any error that comes from not having access to the users media... this in the future will prompt a box
  // that tells the user why we need access to their microphone and tells them how to turn it on. if the user has selected never to allow access to
  // micrphone then we should disply instruction depending on their browser on how to make it accessable to this website again... there should be a button in that pop ups that allows the user to opt out of allowing us to use the microphone because they plan to upload a file
  //console.log('Could not gain access to media object from the user' +", Error Name: " + err.name + ", Error Message: " + err.message)
   // allows to load screen after asking for the mic has failed
  //LoadSuccess(true);
//});/// promise made under the condition the request the users microphone

//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
//thanks to Alexander Polomoshnov for this extension to aid this building process: https://github.com/polomoshnov/jQuery-UI-Resizable-Snap-extension
(function(a){function f(b,c,d){var e=a.ui.resizable.prototype[b];a.ui.resizable.prototype[b]=function(){if(d)d.apply(this,arguments);e.apply(this,arguments);if(c)c.apply(this,arguments)}}function e(a){return parseInt(a.css("margin-top"),10)||0}function d(a){return parseInt(a.css("margin-left"),10)||0}function c(a){return a.sort(function(a,b){return!a?1:!b?-1:Math.abs(a)-Math.abs(b)})[0]}function b(a,b,c){return Math.abs(a)<c?-a:Math.abs(b)<c?-b:0}a.extend(a.ui.resizable.prototype.options,{snapTolerance:20,snapMode:"both"});a.ui.plugin.add("resizable","snap",{start:function(){var b=a(this),c=b.data("ui-resizable"),f=c.options.snap;c.ow=c.helper.outerWidth()-c.size.width;c.oh=c.helper.outerHeight()-c.size.height;c.lm=d(b);c.tm=e(b);c.coords=[];a(typeof f=="string"?f:":data(ui-resizable)").each(function(){if(this==c.element[0]||this==c.helper[0])return;var b=a(this),f=b.position(),g=f.left+d(b),h=f.top+e(b);c.coords.push({l:g,t:h,r:g+b.outerWidth(),b:h+b.outerHeight()})})},resize:function(){var d=[],e=[],f=[],g=[],h=a(this).data("ui-resizable"),i=h.axis.split(""),j=h.options.snapTolerance,k=h.options.snapMode,l=h.position.left+h.lm,m=l-j,n=h.position.top+h.tm,o=n-j,p=l+h.size.width+h.ow,q=p+j,r=n+h.size.height+h.oh,s=r+j;a.each(h.coords,function(){var c=this,h=Math.min(q,c.r)-Math.max(m,c.l),t=Math.min(s,c.b)-Math.max(o,c.t);if(h<0||t<0)return;a.each(i,function(a,i){if(k=="outer"){switch(i){case"w":case"e":if(h>j*2)return;break;case"n":case"s":if(t>j*2)return}}else if(k=="inner"){switch(i){case"w":case"e":if(h<j*2)return;break;case"n":case"s":if(t<j*2)return}}switch(i){case"w":d.push(b(l-c.l,l-c.r,j));break;case"n":e.push(b(n-c.t,n-c.b,j));break;case"e":f.push(b(p-c.l,p-c.r,j));break;case"s":g.push(b(r-c.t,r-c.b,j))}})});if(g.length)h.size.height+=c(g);if(f.length)h.size.width+=c(f);if(d.length){var t=c(d);h.position.left+=t;h.size.width-=t}if(e.length){var t=c(e);h.position.top+=t;h.size.height-=t}}});f("_mouseStop",null,function(){if(this._helper){this.position={left:parseInt(this.helper.css("left"),10)||.1,top:parseInt(this.helper.css("top"),10)||.1};this.size={width:this.helper.outerWidth(),height:this.helper.outerHeight()}}});f("_mouseStart",function(){if(this._helper){this.size={width:this.size.width-(this.helper.outerWidth()-this.helper.width()),height:this.size.height-(this.helper.outerHeight()-this.helper.height())};this.originalSize={width:this.size.width,height:this.size.height}}});f("_renderProxy",function(){if(this._helper){this.helper.css({left:this.elementOffset.left,top:this.elementOffset.top,width:this.element.outerWidth(),height:this.element.outerHeight()})}});var g=a.ui.resizable.prototype.plugins.resize;a.each(g,function(a,b){if(b[0]=="ghost"){g.splice(a,1);return false}});a.each(a.ui.resizable.prototype.plugins.start,function(b,c){if(c[0]=="ghost"){var d=c[1];c[1]=function(){d.apply(this,arguments);a(this).data("ui-resizable").ghost.css({width:"100%",height:"100%"})};return false}})})(jQuery)





// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker
// Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker // Color Picker Color Picker

// Thanks for the amazing color picker!
///https://github.com/Simonwep/pickr
// Simple example, see optional options for more configuration.



// pickr.setHSVA(h:Number,s:Number,v:Number,a:Float, silent:Boolean)




// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:
// Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content: // Play Content:

// Auto Play functionality:
/*
The Auto Play functionality built around Discorso Audio Object, but keep in mind that there will and should
be Art that is displayed without an associated discorso object

*/
function PlayBlackBox(){

}

function ArtCall(){
  // Calls the change

}

function AudioCall(NextAudioObject){
  // call for change in audio
  var Audio = NextAudioObject;

}

function MusicCall(){
  // calls for music change... it checks when the next music is to called over and over again after every AudioCall changes
}

function SFXCall(){
  // will be resizable... so opperates just like the Music call function
}

function TextCall(){
  //called when the Audio call is available
}





//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
//Tags Functionality//Tags Functionality//Tags Functionality//Tags Functionality
// var TagData = [
//   {"name" : "Altruism",
//   "value" : 0},
//   {"name" : "Egoism",
//   "value" : 1},
//   {"name" : "Utilitarianism",
//   "value" : 2},
//   {"name" : "Stocism",
//   "value" : 3},
//   {"name":"Expressionism",
//   "value" : 4},
//   {"name" : "Normal Behavior Ethics",
//   "value" : 5},
//   {"name" : "Individuality",
//   "value" : 6},
//   {"name" : "Collectivism",
//   "value" : 7},
//   {"name" : "Essentialism",
//   "value" : 8},
//   {"name" : "Existentialism",
//   "value" : 9},
//   {"name" : "Love",
//   "value" : 10},
//   {"name" : "Humor",
//   "value" : 11},
//   {"name" : "Freedom",
//   "value" : 12},
//   {"name" : "Artificial Intelegence",
//   "value" : 13},
//   {"name" : "Thought",
//   "value" : 14},
//   {"name" : "Challenge",
//   "value" : 15},
//   {"name" : "Bravery",
//   "value" : 16},
//   {"name" : "Family",
//   "value" : 17},
//   {"name" : "Exploration",
//   "value" : 18},
//   {"name" : "Meaning",
//   "value" : 19},
//   {"name" : "Rationalism",
//   "value" : 20},
//   {"name" : "Theory of Mind",
//   "value" : 21},
//   {"name" : "Creativity",
//   "value" : 22},
//   {"name" : "Time",
//   "value" : 23},
//   {"name" : "Chaos Theory",
//   "value" : 24},
//   {"name" : "World Models",
//   "value" : 25},
//   {"name" : "Humanism",
//   "value" : 26},
//   {"name" : "Realism",
//   "value" : 27},
// ];

var SelectedTags = new Array();

$(document).ready(function(){

function addTagObjects(){
    if( $('.TagObject').length <= 0){
      for(x = 0 ; x < TagData.length ; x++){
        var TagObject = '<button class="TagObject">'+ TagData[x].name +'</button>';
        $('.SelectedStatusLabel').append(TagObject);
    }
  }
}


addTagObjects();


$('.TagObject').click(function(){
    turnOffSelectedTags();
    $(this).css({
      "background" : "#3f6fb8"
    });

    var index = $(this).index();
    $('#explainationBox').text(TagData[index].def);
  })


  $('.TagObject').dblclick(function(){
    if($(this).parents('.nonSelectedTags').length){
      var TagDataObject = TagData[$(this).index()];
      SelectedTags.push(TagDataObject);
      console.log(SelectedTags)
      turnOffSelectedTags();
      $('.selectedTags').append(this);
      $('#explainationBox').text(TagData[index].def);
    }else{
      var TagDataObject = TagData[$(this).index()];
      SelectedTags.push(TagDataObject);
      console.log(SelectedTags)
      turnOffSelectedTags();
      $('.nonSelectedTags').append(this);
      $('#explainationBox').text(TagData[index].def);
    }
  });

})

function turnOffSelectedTags(){
  $('.TagObject').css({
    "background" : "#428FFF"
  });
}






// var loadingTask = pdfjsLib.getDocument('Problem of the Puer Aeternus.pdf');
// loadingTask.promise.then(function(pdf) {
//   // you can now use *pdf* here
// });




// var sawtoothWave = new Pizzicato.Sound({
//   source: 'wave',
//   options: {
//       type: 'sawtooth'
//   }
// });

























// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls
// Audio Controls Audio Controls  Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls Audio Controls

//   https://github.com/goldfire/howler.js/

// var device = navigator.mediaDevices.getUserMedia({audio : true});
// var audioItems = [];
// device.then(stream =>{
//   //https://medium.com/@bryanjenningz/how-to-record-and-play-audio-in-javascript-faa1b2b3e49b
//   //https://www.youtube.com/watch?v=vqnSjuiAdK4&list=TLPQMDYwOTIwMjATMylX_GwTuw&index=3
//   var recorder = new MediaRecorder(stream);
//   recorder.ondataavailable = e =>{
//     audioItems.push(e.data);
//
//     if (recorder.state == 'inactive'){
//        var blob = new Blob(audioItems , {type: 'audio/webm'})
//        var AudioURl = Url.createObjectURL(blob);
//        const audio = new Audio(audioUrl);
//        audio.play();
//
//
//        // var audio = $('.RecordedAudio');
//        // var audioElementId = "AudioId";
//        // var create = document.createElement('Audio');
//        // var audioElement = '<audio class="RecordedObject" id="'+ audioElementId +'" src="'+ Url.createObjectURL(blob) +'"  type="video/"></audio>'
//        // audio.append(audioElement);
//
//     }
//   }
//   recorder.start(1000)
//
//   $('.ConfirmScriptTextButton').click(function(){
//     recorder.stop();
//     // var newAudio = getElementById('AudioId');
//     // newAudio.play();
//     // $('#0').play();
//     console.log($('#AudioId').eq());
//   });
// })




//
// let stream = await navigator.mediaDevices.getUserMedia({video: true, audio: true});
// let recorder = new RecordRTCPromisesHandler(stream, {
//     type: 'audio'
// });
// recorder.startRecording();
//
// const sleep = m => new Promise(r => setTimeout(r, m));
// await sleep(3000);
//
// await recorder.stopRecording();
// let blob = await recorder.getBlob
// const audioUrl = URL.createObjectURL(blob);


// let recorder = RecordRTC(MediaStream || HTMLCanvasElement || HTMLVideoElement || HTMLElement, {});

















//   //https://medium.com/@bryanjenningz/how-to-record-and-play-audio-in-javascript-faa1b2b3e49b
//   //https://www.youtube.com/watch?v=vqnSjuiAdK4&list=TLPQMDYwOTIwMjATMylX_GwTuw&index=3
// var recordedAudio = [];
//
// function recordAudio(){
//   var audioCounter = 0;
//   navigator.mediaDevices.getUserMedia({ audio: true })
//     .then(stream => {
//       var mediaRecorder = new MediaRecorder(stream);
//       mediaRecorder.start();
//
//       const audioChunks = [];
//       mediaRecorder.addEventListener("dataavailable", event => {
//         audioChunks.push(event.data);
//       });
//
//       mediaRecorder.addEventListener("stop", () => {
//         const audioBlob = new Blob(audioChunks);
//         const audioUrl = URL.createObjectURL(audioBlob);
//         const audio = new Audio(audioUrl);
//         recordedAudio.push(audio);
//         // const audio = document.createElement('audio');
//         // audio.src = audioUrl;
//         // audio.id = audioCounter;
//
//         // $('.SelectableAudio').append(audio);
//
//         // audioCounter = audioCounter + 1 ;
//         // var audioElement = '<audio class="RecordedObject" id="0" type="video/"><source src="'+ audioUrl +'" type="video/"></audio>'
//         // $('.SelectableAudio').append(audioElement);
//         // audio.play();
//         // ArrayOfVerbalCom[0].play();
//         // $('.SelectableAudio').find('#0').play();
//       });
//    $('.AdvancedButton').click(function(){
//      mediaRecorder.stop();
//      console.log(recordedAudio.length);
//      console.log(recordedAudio);
//    });
//       // setTimeout(() => {
//       //   mediaRecorder.stop();
//       // }, 3000);
//     });
// }
//
//
//
// $(document).ready(function(){
//   $('.SkipBackButton').click(function(){
//     recordAudio();
//   });
//
//
//   $('.PlayButton').click(function(){
//     var mostRecentlyAdded = recordedAudio.length - 1;
//     recordedAudio[recordedAudio.length - 1].play();
//
//   });
//
//   //
//   // $('.SkipForwardButton').click(function(){
//   //
//   // });
// });



















///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :
///Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :Recording functionality :


// philosophical Lesson The hardest thing I could do today is make recording audio work.
//  for the next few days I'm going to ask myself what is the hardest thing I capable of
// and attack it.
//
// So here goes recording...


// All buttons :
$(document).ready(function(){

  $('#PreviousRecord').click(function(){
    if( ScriptCurrentDataCounter > 0){
      ScriptCurrentDataCounter = ScriptCurrentDataCounter - 1;
      callScriptCardUpdater();
    }

    if( ScriptCurrentDataCounter == 0 ){
      $('.PreviousAudioTextLabel').text("");
    }
  });

  $('#NextRecord').click(function(){
    if( ScriptCurrentDataCounter <  DialgoueData.length - 1){
      ScriptCurrentDataCounter = ScriptCurrentDataCounter + 1;
      callScriptCardUpdater();
    }

    if( ScriptCurrentDataCounter == (DialgoueData.length - 1) ){
      $('.NextAudioTextLabel').text("");
    }
  });

  $('.confirmRecordingButton').click(function(){
    // if( allTextHasBeenRecorded() == true){
    if(true == true){
      $('#BackgroundModalCover').fadeOut(800).hide(0);
      placeAudioObjectsOnSelectionBoard();
    }else{
      AlertFunction('You must record all script text.');
    }
  });

  $('#AudioStationBackArrow').click(function(){
    $('.UploadTextStation').fadeIn(300);
  });

  $('#TextStationBackArrow').click(function(){
    $('.ArtUploadModal').toggle(300);
  });

  $('.AudioRemoveButton').click(function(){
    $('.AudioDraggableObject').eq(ArtIndex).remove();
    $('.DialogueDraggableObject').eq(ArtIndex).remove();
  });

  $('.TextSelectionButton').click(function(){
    $('.DialogueDraggableObject').eq(ArtIndex).remove();
    $('.AudioDraggableObject').eq(ArtIndex).remove();
  });


});


$(document).ready(function(){

  $('.RecordButton').click(function(){
      myRecorder.init();
      myRecorder.start();
      recorderGrabbed = true;
      $('.RecordButton').css({
        'opacity' : '0.5',
      });

      $('.StopRecordingButton').css({
        'opacity' : '1',
      });
      recordNotify(true);

  });


  $('.StopRecordingButton').click(function(){
    myRecorder.stop();
    // isRecording = false;
    // disabling
    $('.StopRecordingButton').css({
      'opacity' : '0.5',
    });
    $('.RecordButton').css({
      'opacity' : '1',
    });
    recordNotify(false);

    });

});

function recordNotify(recording){
  if(recording == true){
    $('.RecordIndicator').css({
      'background' : '#ff4242',
    });
  }else{
    $('.RecordIndicator').css({
      'background' : '#ff42426c',
    });
  }
}



function allTextHasBeenRecorded(){
  var allHasBeenRecorded = false;
  for(x = 0 ; x < choosenAudioArray.length ; x++){
    if(choosenAudioArray[x].AudioUrl != ""){
      allHasBeenRecorded = true;
    }
  }
  return allHasBeenRecorded;
}

function InitializeAudioSelectionBoardObjects(){
  $('.AudioSelectObject').click(function(){
    var index = $(this).index();
    UpdateTextAndAudioObjects(index);
  });

  $('.TextSelectObject').click(function(){
    var index = parseInt( $(this).attr('id') );
    UpdateTextAndAudioObjects(index);
  });

}


function UpdateTextAndAudioObjects(index){
  if(index >= 0){
    $('.DemoStoryText').show();
    // text changes :
    var text = "" + choosenAudioArray[index].scriptCharacter + " : " + choosenAudioArray[index].scriptText + "";
    $('#explainationBox').text(text);
    $('.DemoStoryText').text(text);


    $('.StoryContent').eq(ArtIndex).find('.Text').attr('id', index);
    var newText = "Text " + ( index + 1) + "";
    $('.StoryContent').eq(ArtIndex).find('.TextButtonLabel').text(newText);


      // Audio changes :

    var text = "" + choosenAudioArray[index].scriptCharacter + " : " + choosenAudioArray[index].scriptText + "";
    $('#explainationBox').text(text);
    $('.DemoStoryText').text(text);


    var thisAudioURl = $(this).attr('id');
    // var audioThis = new Audio(thisAudioURl);
    // audioThis.play();

    $('.StoryContent').eq(ArtIndex).find('.Audio').attr('id', thisAudioURl);
    $('.StoryContent').eq(ArtIndex).find('.Audio').attr('data', index);
    var newText = "Recording " + ( index + 1) + "";
    $('.StoryContent').eq(ArtIndex).find('.AudioButtonLabel').text(newText);
  }
}



var currentAudioIndex;
function initializeAudioObject(){
  $('.RecordedObjectButton').click(function(){
    var index = $(this).index();
    var urlThis = $(this).attr('id');// the '.RecordedObjectButton' has the blob url in it's id check function : createdARecordedObject();
    //Grab Url To Play:
    var Url = choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio[index];
    // Make this the Selected Audion Object:

    for( x = 0 ; x < $('.RecordedObjectButton').length; x++ ){
      $('.RecordedObjectButton').eq(x).css({
        'border' : '0.2vh solid transparent',
        'transition' : 'all 0.3s ease-in-out',
      });
    }

    $('.RecordedObjectButton').eq(index).css({
      'border' : '0.2vh solid white',
      'transition' : 'all 0.3s ease-in-out',
    });

    choosenAudioArray[ScriptCurrentDataCounter].AudioUrl = urlThis;
    var recordedAudio = new Audio(urlThis);
    UrlNeeded = urlThis;

    var className = "'.Audio" + urlThis + "'";
    var currentAudioObject = $('.RecordedObjectsHstack').find('.RecordedAudioObject').eq(recroredObjectContainerPos).trigger('play');
    // currentAudioIndex = currentAudioObject.index();
    // currentAudioObject.play();

  });
  // $('.playPauseRecordingPng').click(function(){
  //   recordedAudio.pause();
  // })
}

var recordedObjectCounter;
var recroredObjectContainerPos = 0;
function createdARecordedObject(audioUrl, index){
  // Creates the text to be placed in the audio object
  var recordedObjectLabel = "Take " + recordedObjectCounter + "";
  // Placing the audio url in the place of the id for later ussage if nessasry
  var recordedObject = '<div class="RecordedObjectButton" id ='+ audioUrl +' data="'+ +'"><label class="RecordedObjectLabel">'+ recordedObjectLabel +'</label></div>';
  //
  var AudioObject = $( '<audio controls class="RecordedAudioObject" id="' + recroredObjectContainerPos + '"></audio>' ).attr( 'src' , audioUrl );
  // AudioObject.appendTo('.AudioObjectContainer');
  recroredObjectContainerPos = recroredObjectContainerPos + 1 ;
  // var Rabus McCaleb, Elizabeth McCaleb, May McCaleb, Jacob McCaleb, ;
  // recordedObjectCounter = recordedObjectCounter + 1;
  return recordedObject;
}







// Basic Audio Functionality:

function placeAudioObjectsOnSelectionBoard(){
  for(x = 0 ; x < choosenAudioArray.length ; x++ ){
    var recordingObject = "Recording " + (x + 1) + "";
    var textObject = "Caption " + (x + 1) + "";
    var ThisRecordedURL = choosenAudioArray[x].AudioUrl;
    var SelectionAudioObjects = '<button class="AudioSelectObject"  data="'+ x +'"  id='+ ThisRecordedURL +'>'+ recordingObject +'</button>';
    var SelectionTextObjects = '<button class="TextSelectObject" id='+ x +' data="'+ x +'">'+ textObject +'</button>';
    $('.SelectableAudio').append(SelectionAudioObjects);
    $('.SelectableText').append(SelectionTextObjects);
    InitializeAudioSelectionBoardObjects();
  }
}


var ScriptCurrentDataCounter = 0; // initialized at zero... so
function callScriptCardUpdater(){

  ScriptPreviousCardsFunctionality();
  ScriptCurrentCardsFunctionality();
  ScriptNextCardsFunctionality();

  if(ScriptCurrentDataCounter == 0 ){
    $('.PreviousAudioTextLabel').text('')
  }

}

function ScriptCurrentCardsFunctionality(){
  if( ScriptCurrentDataCounter < DialgoueData.length ){
    var data = DialgoueData;
    var dataCount = DialgoueData.length;
    var currentlabelObject = $('.CurrentAudioTextLabel');
    var currentCharacter = "" + data[ScriptCurrentDataCounter].Character + " : ";
    var currentDialogue = "" + data[ScriptCurrentDataCounter].dialogue + "";
    var fullText = "" + currentCharacter + "" + currentDialogue + "";
    // set Current Label :
    $('.CurrentAudioTextLabel').text(fullText).fadeIn();

  }
}


function ScriptPreviousCardsFunctionality(){
  if( ScriptCurrentDataCounter > 0){
    var data = DialgoueData;
    var dataCount = ScriptCurrentDataCounter - 1;
    var previouslabelObject = $('.PreviousAudioTextLabel');
    var previousCharacter = "" + data[ dataCount ].Character + " : ";
    var previousDialogue = "" + data[ dataCount ].dialogue + "";
    var fullText = "" + previousCharacter + "" + previousDialogue + "";
    // set Current Label :
    $('.PreviousAudioTextLabel').text(fullText).fadeIn();

    resetAllData();
  }
}

function ScriptNextCardsFunctionality(){
  var maxNextCounter = DialgoueData.length - 1;
  if( ScriptCurrentDataCounter < maxNextCounter){
    var data = DialgoueData;
    var dataCount = ScriptCurrentDataCounter + 1;
    var nextlabelObject = $('.NextAudioTextLabel');
    var nextCharacter = "" + data[ dataCount ].Character + " : ";
    var nextDialogue = "" + data[ dataCount ].dialogue + "";
    var fullText = "" + nextCharacter + "" + nextDialogue + "";
    // set Current Label :
    $('.NextAudioTextLabel').text(fullText).fadeIn();
    //resets all data then adds the appropriate data to the veiw
    resetAllData();
  }
}


function resetAllData(){
  // this reset data object is used for each script object t to reset the station after each time the user has choosen the demo audio they like...

  // 1. clears this array:
  recordedAudioList = [];
  // 2. creates the object that has to be deleted
  var audioObjectsToDelete = $('.RecordedObjectButton');
  // 3. deletes each object by running through a for loop
  for(x = 0 ; x < audioObjectsToDelete.length ; x ++ ){
    audioObjectsToDelete.eq(x).remove();
  }

  // 4. add the proper objects by running it through a for loop
  for(x = 0 ; x < choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio.length ; x ++){
    // Updating the counter so that new recordings have the appropriate "take" value
    recordedObjectCounter = (choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio.length + 1);
    // 4.1) gets the audio in the blob url from the array at the script postion
    if( choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio.length > 0){
      var urlThis = choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio[x];
      // 4.2) Places the audio blob url on the object as the ID
      placeRecordedObject(urlThis , ScriptCurrentDataCounter);
      // 4.3) initilizes the added recorded audio
      initializeAudioObject()
    }
  }

}


var isRecording = false;
var recordingRed = true; // default to true so that the view can turn red on first call
var RecordingIndicator = setInterval( function(){
console.log("working kind of");
      if(recordingRed == true && isRecording == true){
        $('.RecordIndicator').css({
          'background' : '#ff4242',
        });

        console.log("working kind of here 2");

        recordingRed = false;

      }else{
        $('.RecordIndicator').css({
          'background' : '#ff42426c',
        });

        console.log("working kind of here 3");


        recordingRed = true;
      }
} , 1000 );

$(document).ready(function(){
  clearInterval(RecordingIndicator);
});




var DialgoueDataCounter = 0;
var recordedAudioList = [];
var choosenAudioArray = [];
function PassScriptDataNextView(){
    Object.keys(requestedScriptContentData.Dialouge).forEach(function(key) {
      var map = requestedScriptContentData.Dialouge;
      var values = map[key];
      console.log(values);
      DialgoueData.push(values);
      var AudioObjectData = {
        // Each Script Text Should have a one-to-one relationship between audio objects
        "scriptCharacter" : DialgoueData[key].Character,
        "scriptText" : DialgoueData[key].dialogue,
        "scriptTextIndex" : key,
        "AudioScriptIndex" : DialgoueDataCounter,
        "RecordedAudioIndex" : "", // location for specific audio object
        "AudioUrl" : "", //Blob Url of audio Object
        "ArrayOfAudio" : [], // array with all the audio 'takes' recorded
      }
      choosenAudioArray.push( AudioObjectData );
      // console.log( "This is THE! Choosen Audio Array " + choosenAudioArray[DialgoueDataCounter].AudioScriptIndex );
      DialgoueDataCounter = DialgoueDataCounter + 1;
  });
}


function placeRecordedObject(audioUrl, indexOfAudio){
  // Gets the append location
  var appendLocation = $('.RecordedObjectsHstack');
  // gets the audio object and appends it to the HStack
  appendLocation.append(createdARecordedObject(audioUrl , indexOfAudio)).fadeIn(400);
  //initilizes the added recorded audio
  initializeAudioObject()

  // triggers a click on the first audio object
  if(choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio.length <= 1){
    // basically if the number of recorded objects for that script is only one than trigger a click to make this the selectable and give the proper styling
    $('.RecordedObjectButton').eq(0).trigger('click');
  }
}




var recorderHasbeenInit = false;
var recorderGrabbed = false;
//https://github.com/mattdiamond/Recorderjs
var myRecorder = {

  object : {
    context : null,
    stream : null,
    recorder : null,
  },

  init: function(){
    if(recorderHasbeenInit == false){
      if(null === myRecorder.object.context){
        myRecorder.object.context = new ( window.AudioContext || window.webkitAudioContext );
      }
      recorderHasbeenInit = true
    }


  },

  start : function(){

      var options = {audio : true, video : false};
      navigator.mediaDevices.getUserMedia(options)
      .then(function (stream){
        myRecorder.object.stream = stream;
        myRecorder.object.recorder = new Recorder(
          myRecorder.object.context.createMediaStreamSource(stream),
          {numChannels : 1}
        )
        isRecording = true;
        myRecorder.object.recorder.record();

      })
      .catch(function(error){ console.log(error)});
    },

  stop : function(){
    if(null !== myRecorder.object.stream){
      myRecorder.object.stream.getAudioTracks()[0].stop(); // stopping the recorder from streaming
    }
    if(null !== myRecorder.object.recorder){
      myRecorder.object.recorder.stop();
      myRecorder.object.recorder.record();

      myRecorder.object.recorder.exportWAV(function(blob){
        var url = (window.URL || window.webkitURL ).createObjectURL(blob);
        var audioObject = $('<audio class="AudioObject"></audio>').attr('src', url);
        console.log(audioObject);
        $('.RecordedAudio').append(audioObject);
        recordedAudioList.push(url);

        // Adds all the audio object data to the appropriate location
        for(x = 0 ; x < choosenAudioArray.length ; x++){
          if(choosenAudioArray[ScriptCurrentDataCounter].scriptTextIndex == x){
            choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio.push(url);
            var ArrayOfAudio = choosenAudioArray[ScriptCurrentDataCounter].ArrayOfAudio;
            initializeAudioObject();
            console.log(ArrayOfAudio);
            isRecording = false;
            // var audioObject = new Audio()
          }
        }
        // Appendoing the Audio url to the RecordedObjectsHstack after the recorded audio is created
        recordedObjectCounter = recordedAudioList.length;

        placeRecordedObject(url, ScriptCurrentDataCounter);
        console.log("Recoreded audio length :" + recordedAudioList.length );
      });
    }
    // stopping recording
  }

}


function playRecordedAudio(loc){
  var url = recordedAudioList[loc];
  var audio = new Audio(url);
  audio.play();

  audio.play = function(){
    console.log("is playing");
  };

}



























// Explainations Data Bank :
var AnimationStylesArray = [
{"AnimationStyle" : "horizontal shake",
"AnimationValue" : 0, "def" : '"Horizontal Shake" is an adjustable animation that shakes the image from left to right.'},

{"AnimationStyle" : "Vertical shake",
"AnimationValue" : 1, "def" : '"Vertical Shake" is an adjustable animation that shakes the image up and down.'},

{"AnimationStyle" : "Chaotic shake",
"AnimationValue" : 2, "def" : '"Chaotic Shake" is an adjustable animation that shakes the image from left to right, up to down, and everywhere in between.'},

{"AnimationStyle" : "fade in",
"AnimationValue" : 3, "def" : '"Fade In" is an adjustable animation that fades in an image when it is time for that image to appear on the view.'},

{"AnimationStyle" : "fade out",
"AnimationValue" : 4, "def" : '"Fade Out" is an adjustable animation that fades out an image when it is time for that image to leave the view.'},

{"AnimationStyle" : "soft screen pulse",
"AnimationValue" : 5, "def" : '"Soft Screen Pulse" is an adjustable animation that flashes the image moderately in and out of the view for the entire duration of that image on the view.'},

{"AnimationStyle" : "violent screen pulse",
"AnimationValue" : 6, "def" : '"Violent Screen Pulse" is an adjustable animation that flashes the image quickly in and out of the view for the entire duration of that image on the view.'},

{"AnimationStyle" : "horizontal pan accross",
"AnimationValue" : 7, "def" : '"Horizontal Pan Across" is for an image with a width longer than its height. This animation pans across the entire image, starting from its left leading edge. We don’t want users to produce art that isn’t a perfect square, but we do understand that it can be useful for story telling if it used scarcely.'},

{"AnimationStyle" : "vertical pan down",
"AnimationValue" : 8 , "def" : '"Vertical Pan Down"  is for an image with a height longer than its width. This animation pans down the entire image, starting from its top edge. We don’t want users to produce art that isn’t a perfect square, but we do understand that it can be useful for story telling if it used scarcely.'},

{"AnimationStyle" : "vertical pan up",
"AnimationValue" : 9, "def" : '"Vertical Pan Up is for an image with a height larger than its width. This animation pams up the entire image starting from its bottom edge. We do not want useres to produce art that is not a perfect square, but we do understand that it can be useful for story telling if it is used scarecely."'},

{"AnimationStyle" : "Chaotic pulse shake",
"AnimationValue": 10 , "def" : '"Chaotic Pulse Shake is an animation where the art flickers on and off of the screen while shaking randomly in all directions."'},// this chaotic pulse shake is just a shake that a chaotic shake with a violent screen pulse

{"AnimationStyle" : "zoom in",
"AnimationValue" : 11, "def" : '"Zoom In" is an animation where the art is zoomed into the center of the image.'},

{"AnimationStyle" : "zoom out",
"AnimationValue" : 12, "def" : '"Zoom Out" is an animation where the art starts from a zoomed position and is zoomed out from the center of the image.'},

{"AnimationStyle" : "Zoom In Horizontal Shake",
"AnimationValue" : 13, "def" : '"Zoom In Horizontal Shake" is a chain animation combinding a zoom in animation with a horizontal shake animation.'},

{"AnimationStyle" : "Zoom In Vertical Shake",
"AnimationValue" : 14, "def" : '"Zoom In Horizontal Shake" is a chain animation combinding a zoom in animation with a vertical shake animation.'},

{"AnimationStyle" : "Zoom In Screen Pulse",
"AnimationValue" : 15, "def" : '"Zoom In Screen Pulse" is a chain animation combining a zoom in animation with a screen pulse animation.'},

{ "AnimationStyle" :"Drop Out The View",
"AnimationValue" : 16, "def" : '"Drop Out The View" is an animation where the art drops out of the view.'},

{ "AnimationStyle" :"Fly In The View",
"AnimationValue" : 17, "def" : '"Fly In The View" is an animation where the art flies into the view vertically upward.'},

{ "AnimationStyle" :"Run Out The View",
"AnimationValue" : 18, "def" : '"Run Out The View" is an animation where the art horizontally leaves the view.'},

{ "AnimationStyle" :"Run In The View",
"AnimationValue" : 19, "def" : '"Run In The View" is an animation where the art horizontally runs into the view.'},

{ "AnimationStyle" :"Land In The View",
"AnimationValue" : 20, "def" : '"Land In The View" is an animation where the art flies downward in the view.'},

{ "AnimationStyle" :"Land In The View Diagonal",
"AnimationValue" : 21, "def" : '"Land In The View Diagonal" is an animation where the art flies downward in the view diagonally.'},
];









var TagData = [
  {"name" : "Altruism",
  "value" : 0, "def" : "Altruism is the belief in or practice of disinterested and selfless concern for the well-being of others."},


  {"name" : "Egoism",
  "value" : 1, "def" : "Egosim is the belief that moral people should to act in their own self-interest."},


  {"name" : "Utilitarianism",
  "value" : 2, "def" : "Utilitarianism is the belief that moral actions are right if they are useful or for the benefit of a majority."},


  {"name" : "Stocism",
  "value" : 3, "def" : "Stocism is the endurance of pain or hardship without the display of feelings and without complaint."},


  {"name":"Expressionistic Behavior",
  "value" : 4, "def" : "Expressionistic Behavior is a form of expression where pain, endurance, and hardship take a backseat to exposing one's self emotionally and focusing more importantly on living in the moment."},


  {"name" : "Individuality",
  "value" : 5, "def" : "Individuality is the quality or character of a particular person or thing that distinguishes them from others of the same kind. An individuality philosophical postion would place individual differences as being more important then collective identity such as nationalism."},


  {"name" : "Collectivism",
  "value" : 6, "def" : "Collectivism is the practice or principle of giving a group priority over each individual in it."},


  {"name" : "Essentialism",
  "value" : 7, "def" : "Essentialism is the philosophical conviction that an object or individueal have an inate meaning or essense."},


  {"name" : "Existentialism",
  "value" : 8, "def" : "Existentialism is a form of philosophical enquiry that explores the nature of existence by emphasizing the meaning and essense human experiences and objects to be subjective. It is to say meaning is not found in the object or human, instead meaning is synshtized by the human onto the object and the experience."},


  {"name" : "Love",
  "value" : 9, "def" : "No definition will suit love. It is left to you and us all to make arguements for it's definition."},


  {"name" : "Humor",
  "value" : 10, "def" : "Humor is the quality of being amusing or comic, especially as expressed in literature or speech."},


  {"name" : "Freedom",
  "value" : 11, "def" : "Freedom is the power or right to act, speak, or think as one wants without hindrance or restraint."},


  {"name" : "Artificial Intelligence",
  "value" : 12, "def" : "Artificial Intelligence is intelligence demonstrated by machines, unlike the natural intelligence displayed by humans and animals"},


  {"name" : "Thought",
  "value" : 13, "def" : "Thought is an idea or opinion produced by thinking, or occurring suddenly in the mind."},


  {"name" : "Challenge",
  "value" : 14, "def" : "Challenge is a call to adventure that ask an individual or group of individuals to take on a task that has obstacles."},


  {"name" : "Bravery",
  "value" : 15, "def" : "Bravery is courageous behavior or character where an individual or group of individuals take on a task that is undesired or hard out moral responsibility."},


  {"name" : "Family",
  "value" : 16, "def" : "Family is a group of individuals bound together by companionship, care, and the desire to endure through life."},


  {"name" : "Exploration",
  "value" : 17, "def" : "Exploration is the action of traveling in or through an unfamiliar area in order to learn about it."},


  {"name" : "Meaning",
  "value" : 18, "def" : "Meaning doesn't have a good definition. It is one of those tricky conceptual words that are consitently defined by us."},


  {"name" : "Rationalism",
  "value" : 19, "def" : "Rationalism is a belief or theory that opinions and actions should be based on reason and knowledge rather than on religious belief or emotional response."},


  {"name" : "Creativity",
  "value" : 20, "def" : "Creativity is a phenomenon whereby something new and somehow valuable is formed. The created item may be intangible or a physical object."},


  {"name" : "Time",
  "value" : 21, "def" : "the indefinite continued progress of existence and events in the past, present, and future regarded as a whole."},


  {"name" : "Chaos Theory",
  "value" : 22, "def" : "Chaos theory is an interdisciplinary theory stating that, within the apparent randomness of chaotic complex systems, there are underlying patterns, interconnectedness, constant feedback loops, repetition, self-similarity, fractals, and self-organization."},

  {"name" : "Determinism",
  "value" : 23, "def" : "Determinism is the philosophical view that all events are determined completely by previously existing causes."},

  {"name" : "Compatibilism",
  "value" : 24, "def" : "Compatibilism is the belief that free will and determinism are mutually compatible and that it is possible to believe in both without being logically inconsistent."},

  {"name" : "Free Will",
  "value" : 25, "def" : "Free will is the ability to choose between different possible courses of action unimpeded and with out causal connections."},

  {"name" : "Models",
  "value" : 26, "def" : "Models, most commonly associated in artificial intelegence but useful in many other contexts, is the idea of a small closed system that is representational of a larger complex system. The idea has utility because the small model of the larger system helps us to make predictions about the large dynamic complex system."},

  {"name" : "Humanism",
  "value" : 27,
  "def" : "Humanism is an outlook or system of thought attaching prime importance to human rather than divine or supernatural matters."},

  {"name" : "Subconscious",
  "value" : 28,
  "def" : "Subconscious is the concerning the part of the mind of which one is not fully aware but which influences one's actions and feelings.",
  },

  {"name" : "Conscious",
  "value" : 29,
  "def" : "the fact of awareness by the mind of itself and the world.",
  },

  {"name" : "Economics",
  "value" : 30,
  "def" : "Economics is the branch of knowledge concerned with the production, consumption, and transfer of wealth.",
  },

  {"name" : "History",
  "value" : 31,
  "def" : "History is the study of actions, ideas, objects that happened in the past.",
  },

  {"name" : "Culture",
  "value" : 32,
  "def" : "Culture is the arts and other manifestations of human intellectual achievement regarded collectively.",
  },

  {"name" : "Philosophy of mind",
  "value" : 33,
  "def" : "Philosophy of mind is a branch of philosophy that studies the ontology and nature of the mind and its relationship with the body."},

  {"name" : "Hope",
  "value" : 34,
  "def" : "Hope is a mode of attachment leaning on faith that things that have true meaning to you and or others is not to far out of reach."
}


];






//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :
//Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :Play Content :

var playTriggered = false;
$(document).ready(function(){
  $('.PlayButton').click(function(){
      PlayStory();
      playTriggered = !playTriggered;
      updatePlayUI();
  });

  $('.SkipBackButton').click(function(){
    if(ArtIndex >= 1){
      ArtIndex = ArtIndex - 1;
      $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
      PlayStory();
      playTriggered = true;
      if(playTriggered == true){
        $('.PlayButton').find('.PlayButtonUI').attr('src' , 'NewProjectsUI/BlackPauseUIImage.png');
      }
    }
  });

  $('.SkipForwardButton').click(function(){
    if(ArtIndex < $('.StoryContent').length){
      ArtIndex = ArtIndex + 1;
      $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
      PlayStory();
      playTriggered = true;
      if(playTriggered == true){
        $('.PlayButton').find('.PlayButtonUI').attr('src' , 'NewProjectsUI/BlackPauseUIImage.png');
      }
    }
  });


});

function updatePlayUI(){
  if(playTriggered == true){
    $('.PlayButton').find('.PlayButtonUI').attr('src' , 'NewProjectsUI/BlackPauseUIImage.png');
  }else{
    $('.PlayButton').find('.PlayButtonUI').attr('src' , 'NewProjectsUI/BlackPauseUIImage.png');
  }
}
var frameCounter = 0;// defaul to zero so that it starts from the first index


var defaultTime = 3000;



var StoryPlayAudio = new Audio();
var StoryMusicAudio = new Audio();
var StorySFXAudio = new Audio();
var musicIsPlaying = false;
// var playSpeed = 1000;
function PlayStory(){
  if(ArtIndex < $('.StoryContent').length){
    var audioDataArrayIndex = parseInt( $('.StoryContent').eq(ArtIndex).find('.Audio').attr('data') );
    var urlBlob = $('.StoryContent').eq(ArtIndex).find('.Audio').attr('id');
    // if there exist a audio object in this position and if that audio object has a blob url that comes from the choosenAudioArray.. the blob is checked by checking the audio object for it's data attribute which should store an a instance of the index in there from being triggered from the selection board and blob is not undefined
    if($('.StoryContent').eq(ArtIndex).find('.Audio').length &&  audioDataArrayIndex >= 0 && urlBlob !== undefined && urlBlob != ""){
      // gets the data src object stored in the audio object's id
      // StoryPlayAudio.src = $('.StoryContent').eq(ArtIndex).find('.Audio').attr('id');
      // console.log("URL This :" + $('.StoryContent').eq(ArtIndex).find('.Audio').attr('id'))
      // StoryPlayAudio.load();
      // StoryPlayAudio.play();

      checkForText();
      checkForAnimation();
      checkStoryMusic();
      // StoryPlayAudio.onended = function(){
      //   console.log("It's working yay!");
      //   ArtIndex = ArtIndex + 1;
      //   $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
      //   PlayStory();
      // };

    }else{
      checkForText();
      checkForAnimation();
      checkStoryMusic();
      // playSpeed = storyData[ArtIndex].ArtData.defualtRunTime ;
      // StoryMusicAudio.src = rocketManUrl;
      // if(musicIsPlaying == false){
      //   StoryMusicAudio.src = rocketManUrl;
      //   StoryMusicAudio.play();
      //   StoryMusicAudio.volume = 0.25;
      // }
      musicIsPlaying = true;
      clearInterval(playContentTimer);
      var playContentTimer = setTimeout(function(){
          console.log('running play timer')
          ArtIndex = ArtIndex + 1;
          $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
          PlayStory();
      }, storyData[ArtIndex].ArtData.defualtRunTime );

      playContentTimer;

    }
  }else{
    $('.StoryContent').eq(0).find('.Art').trigger('click');
    $('.WorkStationHStack').offset().left = $('.workStation').offset().left;
  }
}

// clearInterval(playContentTimer);



function checkForAnimation(){
  var animationDataFunction = parseInt($('.StoryContent').eq(ArtIndex).find('.Animate').attr('data'));
  console.log(animationDataFunction);
  if(animationDataFunction >= 0){
    var animationValue = storyData[ArtIndex].AnimationData.animationFunctionValue;
    AnimationCall(animationDataFunction);
  }
}

function checkForText(){
  if($('.StoryContent').eq(ArtIndex).find('.Text').length){
    var textFunction = parseInt($('.StoryContent').eq(ArtIndex).find('.Text').attr('id'));
    if(textFunction >= 0){
      UpdateTextAndAudioObjects(textFunction);
    }else{
      $('.DemoStoryText').hide();
    }
  }
}

function checkSoundEffects(){
  // function will opperate the same as the text functions
}

function requestSoundEffectArray(){
  var db = firebase.firestore();
  var ref = db.collection('ToddTools').doc('StoryMusicRefDoc');
  ref.get().then(function(doc) {
    if (doc.exists) {


      PulledMusicArray = doc.data().musicRef;
      console.log("Music Array : " + PulledMusicArray);

      for( x = 0 ; x < PulledMusicArray.length ; x++ ){
        console.log("Music Array : " + PulledMusicArray);
        placeSelectionObject(index = x , musicRef = PulledMusicArray[x]);
      }


    } else {
        console.log("No Transfer Script!");
    }
  }).catch(function(error){
  });
}

function pullSoundEffectAudio(){
  var storage = firebase.storage();
  // console.log("this url ref " + thisurl)
  var ref = storage.ref().child('StorySFX/' + PulledMusicArray[index]);
  ref.getDownloadURL().then(function(url) {
  // `url` is the download URL for 'images/stars.jpg'
  // This can be downloaded directly:
  var xhr = new XMLHttpRequest();
  xhr.responseType = 'blob';
  xhr.onload = function(event) {
    var blob = xhr.response;
  };

  xhr.open('GET', url);
  newAudioURL = url;

}).catch(function(error) {
  // Handle any errors
  console.log("Did Not return url");
});
}







function checkStoryMusic(){

}

var PulledMusicArray = [];
pullMusicArrayRef();
function pullMusicArrayRef(){
  var db = firebase.firestore();
  var ref = db.collection('ToddTools').doc('StoryMusicRefDoc');
  ref.get().then(function(doc) {
    if (doc.exists) {


      PulledMusicArray = doc.data().musicRef;
      console.log("Music Array : " + PulledMusicArray);

      for( x = 0 ; x < PulledMusicArray.length ; x++ ){
        console.log("Music Array : " + PulledMusicArray);
        placeSelectionObject(index = x , musicRef = PulledMusicArray[x]);
      }


    } else {
        console.log("No Transfer Script!");
    }
  }).catch(function(error){
  });
}
// pullMusicArrayRef();

function placeSelectionObject(index, musicRef){
  var selectionObject = $('<button class="MusicSelectObject" id="'+ musicRef +'" data="'+ index +'">'+ PulledMusicArray[index] +'</button>');
  selectionObject.appendTo('.SelectableMusic');
  InitializeMusicSelectionObject();
}

function InitializeMusicSelectionObject(){
  $('.MusicSelectObject').click(function(){
    var musicIndexLocation = $(this).index();//$('.MusicSelectObject').text() ;
    console.log(musicIndexLocation);
    pullPlayStoryMusic(musicIndexLocation);
  });
}

var thisMusicUrl;
var downloadedBackEndUrlArray = [];
function pullPlayStoryMusic(index){
  var storage = firebase.storage();
  // console.log("this url ref " + thisurl)
  var ref = storage.ref().child('StoryMusic/' + PulledMusicArray[index]);
  ref.getDownloadURL().then(function(url) {
  // `url` is the download URL for 'images/stars.jpg'
  // This can be downloaded directly:
  var xhr = new XMLHttpRequest();
  xhr.responseType = 'blob';
  xhr.onload = function(event) {
    var blob = xhr.response;
  };

  xhr.open('GET', url);
  newAudioURL = url;

}).catch(function(error) {
  // Handle any errors
  console.log("Did Not return url");
});

playRequestedAudio("Url For Now");

}
var newAudioURL;
function playRequestedAudio(url){
  // xhr.send();
  console.log(url);
  rocketManUrl = url;
  downloadedBackEndUrlArray.push(url);
  console.log(downloadedBackEndUrlArray);
  thisMusicUrl = url;
  console.log("This URL Plays Music :" + thisMusicUrl);

  StoryMusicAudio.src = newAudioURL;
  StoryMusicAudio.load();

// attempting to call the play function after the audio has loaded into the audio object
    StoryMusicAudio.addEventListener('loadeddata', function() {

      if(StoryMusicAudio.readyState >= 2) {
        StoryMusicAudio.play();
      }

    });

}
















function checkAudioAtArtIndex(){
  var storyObject = $('.StoryContent').eq(ArtIndex).find('.Audio') ;

  if($('.StoryContent').eq(ArtIndex).find('.Audio').length > 0){
     var thisUrl = $('.StoryContent').eq(ArtIndex).find('.Audio').attr('id');
     play_audio(task = 'play' , urlThis = thisUrl);
   }else{
      playContent()
   }
}



function nextAudio(){
      if(ArtIndex < $('.StoryContent').length){
        ArtIndex = ArtIndex + 1;
        $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
        checkAudioAtArtIndex();
      }
}


// $(".my_audio").trigger('load');

function play_audio(task , urlThis ) {
      if(task == 'play'){
           $(".my_audio").trigger('play');
      }
      if(task == 'stop'){
           $(".my_audio").trigger('pause');
           $(".my_audio").prop("currentTime",0);
      }

      $('#sound_src').remove();
      $('.my_audio').append("<source id='sound_src' src=" + urlThis + " type='audio/mpeg'>");

      $('.my_audio').on('ended', function() {
        $("#sound_src").attr("src" , urlThis)
          nextAudio();
      });
}







function playContent(){


  var playContentTimer = setInterval(function(){

    // if(frameCounter < $('.StoryContent').length){
      $('.StoryContent').eq(ArtIndex).find('.Art').trigger('click');
      // frameCounter = frameCounter + 1;
      // console.log('running story play');
      // playContentTimer;
    // }else{

      clearInterval(playContentTimer);
      frameCounter = 0;
      checkAudioAtArtIndex
      // $('.StoryContent').eq(frameCounter).find('.Art').trigger('click');
      //
      // $('.WorkStationHStack').animate({
      //     scrollLeft : ($('.WorkStationHStack').offset().left * -1),
      // })
    // }
    console.log('running story play');

  }, playSpeed);

  playContentTimer;
}
