//Loading the landing page:
  // Your web app's Firebase configuration
  var firebaseConfig = {
    authDomain: "todd-1point0.firebaseapp.com",
    databaseURL: "https://todd-1point0.firebaseio.com",
    projectId: "todd-1point0",
    storageBucket: "todd-1point0.appspot.com",
    messagingSenderId: "1020057772233",
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();

$(document).ready(function(){
    firebase.auth().onAuthStateChanged(function(user) {
        if (user) {
          // User is signed in.
          var displayName = user.displayName;
          var email = user.email;
          var emailVerified = user.emailVerified;
          var photoURL = user.photoURL;
          var isAnonymous = user.isAnonymous;
          var uid = user.uid;
          var providerData = user.providerData;
          // ...
            SignInflag = true;
        } else {
            SignInflag = false;
          // User is signed out.
          // ...
        }
      });
})

function LanderImageSlider(){
    console.log("timer called")
    var counter = 0;
    var ArrayOfImages = ['4.JPG' , '5.JPG' ,'6.jpeg'];
    setInterval(function(){
        $('.LanderImage').fadeOut( 700, function(){
            $('.LanderImage').attr('src', ArrayOfImages[counter]);
            $('.LanderImage').fadeIn();
        });

        if( counter < (ArrayOfImages.length - 1 ) ){
            counter = counter + 1;
        }else{
            counter = 0;
        }
        console.log("timer called")
    }, 5000);
}

// LanderImageSlider();

$(document).ready(function(){
  runDemo();


function runDemo(){
  var Demo = $('.demoImages');
  setInterval(function(){
    if(demoCounter < 6){
      //Demo.hide(0);
      verticalShake();
      funDemo();
      demoCounter = demoCounter + 1;
    }else{
      // Demo.fadeOut(0);
      demoCounter = 0;
      funDemo();
    }
  }, 1500)
}

var DemoImageArray = ['black.jpg','e1.png', 'e2.png', 'e3.png', 'e4.png', 'e5.png']
// DemoImageArray = ['1.jpeg', '2.jpeg' , '3.JPG', '4.JPG', '5.JPG' , '6.jpeg'];
function funDemo(){
  var Demo = $('.demoImages');
  switch (demoCounter) {
    case 0:
           $('.demoImages').attr('src' , DemoImageArray[0]);
           break;

    case 1:
           $('.demoImages').attr('src' , DemoImageArray[1])//.fadeIn(0);
           break;

    case 2:
          $('.demoImages').attr('src' , DemoImageArray[2])//.fadeIn(400);
          break;

    case 3:
          $('.demoImages').attr('src' , DemoImageArray[3])//.fadeIn(400);
          break;

    case 4:
          $('.demoImages').attr('src' , DemoImageArray[4])//.fadeIn(400);
          break;

    case 5:
          verticalShake();
          $('.demoImages').attr('src' , DemoImageArray[5])//.fadeIn(10);
    break;

    default:

  }

}

});

var demoCounter = 1;
function verticalShake(){


  var Demo = $('.demoImages');
  var numberOfTimes = 10;
  var AnimationSpeed = 10
  var intervalCall = 50;
  var WasJustTop = false;
  var TimerSpeed = 50;


  var Distance = 10;
  var DistanceUP = (-1 * (Distance)) + "px";
  var DistanceDown = Distance + "px";

  var TransitionSpeed = TimerSpeed / 1000;
  var TransitionSpeedUp ="all " + TransitionSpeed +"s ease-in-out"
  var TransitionSpeedDown ="all " + (TransitionSpeed * 2) +"s ease-in-out"

  var DialogueDurration = 0;

var VerticalShake = setInterval(function(){
console.log("running");
    if(demoCounter == 6){
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
      clearInterval(VerticalShake);
      WasJustTop = false;
      // Placing object back to it's proper place
      Demo.css({"top" : "0px"});
    }
  }, intervalCall);

  VerticalShake;


}



function fadeOut(){
  var demoImg = $('.demoImages');
}


var SignInflag = false;
console.log(SignInflag);
$(document).ready(function () {
    $('.SignIn').click(function(){
        location.href = "SignIn/signIn.html";
    });

    $('#Creatives').click(function(){
        if(SignInflag == true){
            location.href = "DashBoard/ToddWebDashboard.html"
        }else{
            location.href="SignIn/ToddWebSignIn.html";
        }

        $('.SignUpButton').click(function(){

        });
    });
});

var NextCounter = 3;
$('.NextButton').click(function(){
    NextView();
    if(NextCounter < 5){
        NextCounter = NextCounter + 1;
    }else{
        NextCounter = 0;
    }
    console.log(NextCounter);
});

function NextView() {
    switch (NextCounter){
        case 0:
            console.log('k')
            $('#1').hide();
            $('#2').hide();
            $('#3').hide();
            $('#4').hide();
            $('.LanderImageDiv').show();
            break;
        case 1:
            console.log('k')
            $('#0').hide();
            $('#2').hide();
            $('#3').hide();
            $('#4').hide();;
            $('.PurposeClass').show();
            break;
        case 2:
            console.log('k')
            $('#1').hide();
            $('#0').hide();
            $('#3').hide();
            $('#4').hide();
            $('.UIAndMissionClass').show();
            break;
        case 3:
            console.log('k')
            $('#1').hide();
            $('#2').hide();
            $('#0').hide();
            $('#4').hide();
            $('.PControlsDiv').show();
            break;
        case 4:
            console.log('k')
            $('#1').hide();
            $('#2').hide();
            $('#3').hide();
            $('#0').hide();
            $('.SusbscriptionDiv').show();
            break;
    }
  }

















$(document).ready(function() {
    AOS.init();
  });




//   https://greensock.com/timelinemax/    && https://www.youtube.com/watch?v=S18Wh9IELo0&list=TLPQMDkwOTIwMjD0ly2i0FJ3qA&index=2  && https://scrollmagic.io/
var timeline = new gsap.timeline({onUpdate:updatePercentage});
const controller = new ScrollMagic.Controller();

timeline.from('.PurposeClass', 0.5,  {y:0 , opacity: 0, duration : 0.5})
timeline.to('.PurposeClass', 0.5,  {y:0 , opacity: 1, duration : 0.5})


// .from('.MissionMoadalDiv', 3 , {x:-250 , opacity: 0 , duration: 1})
// .from('.UIMobileDiv', 10 , {x:250 , opacity: 0 , duration: 1})
// .from('.PCContentDiv',  10,  {y:0 , opacity: 0, duration : 1});



// timeline.from('.OptionsDiv',  1,  {y:0 , opacity: 0, duration : 1});
// timeline.to('.OptionsDiv', 1 ,  {opacity: 1});

// timeline.from('.NoSubDiv', 1 , {x:-250 , opacity: 0 , duration: 1});
// timeline.to('.NoSubDiv', 1 , {x:0 , opacity: 1 , duration: 1});

// timeline.from('.SubDiv', 1 , {x:250 , opacity: 0 , duration: 1});
// timeline.to('.SubDiv', 1, {x:0 , opacity: 1 , duration: 1});



const scene = new ScrollMagic.Scene({
    triggerElement : '.PurposeClass',
    triggerHook : 'center',
    duration : '100%'
})
// .setPin('.PurposeClass')
.setTween(timeline)
.addTo(controller);


function updatePercentage(){
   var prog = timeline.progress();

    if(timeline.progress() > 0.39){
        $('.Header').css({
            "background-color" : "white",
            "box-shadow" : "0vh 0.2vh 0.2vh rgb(0, 0, 0, 0.25)"

        });

        $('.Home').css({
            "color" : "rgba(0, 0, 0, 0.5)"
        });

        $('.About').css({
            "color" : "rgba(0, 0, 0, 0.5)"
        });

        $('.Design').css({
            "color" : "rgba(0, 0, 0, 0.5)"
        });

        $('.Lang').css({
            "color" : "rgba(0, 0, 0, 0.5)"
        });


        $('.Parents').css({
            "color" : "rgba(0, 0, 0, 0.5)"
        });
    }else if(timeline.progress() < 0.39){
        $('.Header').css({
            "background-color" : "rgba(255, 255, 255, 0.125)",
            "box-shadow" : "0vh 0.2vh 0.2vh rgb(0, 0, 0, 0.0)"
        });

        $('.Home').css({
            "color" : "black"
        });

        $('.About').css({
            "color" : "black"
        });

        $('.Design').css({
            "color" : "black"
        });

        $('.Lang').css({
            "color" : "black"
        });


        $('.Parents').css({
            "color" : "black"
        });
    }else if(timeline.progress() > 0.6){
        timeline.progress(0.25);
    }

    console.log(timeline.progress())
    console.log("Function created");
    return timeline.progress();
}


$(function() {
//$().scrollTop(); allows you to get the current scroll position from the top of a scrollable element
//$().offset: allows you to get the current
    var MissionIntialScrollPos;

    $('.MissionMoadalDiv').hide();
    $('.UIMobileDiv').hide();

    $('.Page').on("mousewheel", function() {

        if( $('.Page').scrollTop() < 3 ){
            MissionIntialScrollPos = $('.Page').offset().top -  $('.UIAndMissionClass').offset().top;
        }
        var MissionScrollPos = $('.Page').offset().top -  $('.UIAndMissionClass').offset().top;
        var AbsoluteValueOppacity = Math.abs( ( MissionScrollPos / MissionIntialScrollPos) );
        var Oppacity = ( 1 - AbsoluteValueOppacity);

        if(Oppacity > 0.75){
            $('.MissionMoadalDiv').fadeIn(500);
            $('.UIMobileDiv').fadeIn(500);
        }

        if( Oppacity <0.5){
            $('.MissionMoadalDiv').hide();
            $('.UIMobileDiv').hide();
        }

        console.log($('.Page').scrollTop());
        console.log("Oppacity = " + ( 1 - AbsoluteValueOppacity));

        console.log( "ScrollPostion :     " +  ($('.Page').offset().top -  $('.UIAndMissionClass').offset().top) );
    });
});



$(document).ready(function(){
    $('.Home').click(function(){
        $('.Page').animate({
            scrollTop : $('.LanderImageDiv').offset().top,
        })
        , 800
    });

    $('.About').click(function(){
        $('.Page').animate({
            scrollTop : $('.PurposeClass').offset().top,
        })
        , 800
    });

    $('.Design').click(function(){
        $('.Page').animate({
            scrollTop : $('.UIAndMissionClass').offset().top,
        }
        , 800);

        $('.MissionMoadalDiv').fadeIn(500);
        $('.UIMobileDiv').fadeIn(500);
    });

    $('.Lang').click(function(){
        $('.Page').animate({
            scrollTop : $('.TranslateClass').offset().top,
        })
        , 800
    });


    $('.Parents').click(function(){
        $('.Page').animate({
            scrollTop : $('.PControlsDiv').offset().top,
        })
        , 800
    });




});
