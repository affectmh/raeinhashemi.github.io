
	  // Initialize Firebase
	  var config = {
	    apiKey: "AIzaSyAXBn2h6sWKQVxqdPfWABhaYEIJ2xg3gFQ",
	    authDomain: "k-journeys.firebaseapp.com",
	    databaseURL: "https://k-journeys.firebaseio.com",
	    projectId: "k-journeys",
	    storageBucket: "k-journeys.appspot.com",
	    messagingSenderId: "123839815109"
	  };
	  firebase.initializeApp(config);
	  
	  /**
	     * initApp handles setting up UI event listeners and registering Firebase auth listeners:
	     *  - firebase.auth().onAuthStateChanged: This listener is called when the user is signed in or
	     *    out, and that is where we update the UI.
	     *  - firebase.auth().getRedirectResult(): This promise completes when the user gets back from
	     *    the auth redirect flow. It is where you can get the OAuth access token from the IDP.
	     */
	    function initApp() {
	      // Result from Redirect auth flow.
	      // [START getidptoken]
	      firebase.auth().getRedirectResult().then(function(result) {
	        if (result.credential) {
	          // This gives you a Google Access Token. You can use it to access the Google API.
	          var token = result.credential.accessToken;
	          // [START_EXCLUDE]
	          //document.getElementById('quickstart-oauthtoken').textContent = token;
	        } else {
	          //document.getElementById('quickstart-oauthtoken').textContent = 'null';
	          // [END_EXCLUDE]
	        }
	        // The signed-in user info.
	        var user = result.user;
	      }).catch(function(error) {
	        // Handle Errors here.
	        var errorCode = error.code;
	        var errorMessage = error.message;
	        // The email of the user's account used.
	        var email = error.email;
	        // The firebase.auth.AuthCredential type that was used.
	        var credential = error.credential;
	        // [START_EXCLUDE]
	        if (errorCode === 'auth/account-exists-with-different-credential') {
	          alert('You have already signed up with a different auth provider for that email.');
	          // If you are using multiple auth providers on your app you should handle linking
	          // the user's accounts here.
	        } else {
	          console.error(error);
	        }
	        // [END_EXCLUDE]
	      });
	      // [END getidptoken]

	      // Listening for auth state changes.
	      // [START authstatelistener]
	      firebase.auth().onAuthStateChanged(function(user) {
	        if (user) {
	          // User is signed in.
	        	
	        	if(document.title != "Home")
	        	  window.location.href = "Home.html";
	        	
	          var displayName = user.displayName;
	          var email = user.email;
	          var emailVerified = user.emailVerified;
	          var photoURL = user.photoURL;
	          var isAnonymous = user.isAnonymous;
	          var uid = user.uid;
	          var providerData = user.providerData;
	          // [START_EXCLUDE]
	          //document.getElementById('quickstart-sign-in-status').textContent = 'Signed in';
	          //document.getElementById('quickstart-sign-in').textContent = 'Sign out';
	          //document.getElementById('quickstart-account-details').textContent = JSON.stringify(user, null, '  ');
	          
	          // [END_EXCLUDE]
	        } else {
	          // User is signed out.
	          // [START_EXCLUDE]
	        
	          document.getElementById('quickstart-sign-in-status').textContent = 'Signed out';
	          if(document.title == "Google Sign In")
	        	  document.getElementById('quickstart-sign-in').textContent = 'Sign in with Google';
	          else if(document.title == "Facebook Sign In")
	        	  document.getElementById('quickstart-sign-in').textContent = 'Sign in with Facebook';
	          else
	        	  document.getElementById('quickstart-sign-in').textContent = 'Sign in';
	          document.getElementById('quickstart-account-details').textContent = 'null';
	          if(!document.title == "Email Sign In")	       
	        	  document.getElementById('quickstart-oauthtoken').textContent = 'null';	
	          	          
	          // [END_EXCLUDE]
	        }
	        // [START_EXCLUDE]
	        if(document.title != "Home")
	        	document.getElementById('quickstart-sign-in').disabled = false;
	        // [END_EXCLUDE]
	      });
	      // [END authstatelistener]

	      if(document.title != "Home")
	    	  document.getElementById('quickstart-sign-in').addEventListener('click', toggleSignIn, false);
	    }

	    window.onload = function() {
	    	
	      initApp();	      	      
	      
	      var bMouseIsDown = false; 
	      
	      var oCanvas = document.getElementById("drawingCanvas"); 
	      var oCtx = oCanvas.getContext("2d"); 
		   var iWidth = oCanvas.width; 
		      var iHeight = oCanvas.height; 
		   function showDownloadText() { 
		      document.getElementById("textdownload").style.display = "block"; 
		      }
		   function hideDownloadText() { 
		      document.getElementById("textdownload").style.display = "none"; 
		      }		  		  
		   
		   function convertCanvas(strType) { 
		      if (strType == "PNG") 
		      var oImg = Canvas2Image.saveAsPNG(oCanvas, true); 
		      if (strType == "BMP") 
		      var oImg = Canvas2Image.saveAsBMP(oCanvas, true); 
		      if (strType == "JPEG") 
		      var oImg = Canvas2Image.saveAsJPEG(oCanvas, true); 
			    if (!oImg) { 
			      alert("Sorry, this browser is not capable of saving." + strType + " files!"); 
			      return false; 
			      } 
			   oImg.id = "canvasimage"; 
			    oImg.style.border = oCanvas.style.border; 
			      oCanvas.parentNode.replaceChild(oImg, oCanvas); 
			   howDownloadText(); 
		      } 
		   
		   function saveCanvas(pCanvas, strType) { 
		      var bRes = false; 
		      if (strType == "PNG") 
		      bRes = Canvas2Image.saveAsPNG(oCanvas); 
		      if (strType == "BMP") 
		      bRes = Canvas2Image.saveAsBMP(oCanvas); 
		      if (strType == "JPEG") 
		      bRes = Canvas2Image.saveAsJPEG(oCanvas); 
			   if (!bRes) { 
			      alert("Sorry, this browser is not capable of saving " + strType + " files!"); 
			      return false; 
			      } 
		      } 
		   
		   document.getElementById("convertpngbtn").onclick = function() { 			   
		      convertCanvas("PNG"); 
		      }
		   document.getElementById("resetbtn").onclick = function() { 
		      var oImg = document.getElementById("canvasimage"); 
		      oImg.parentNode.replaceChild(oCanvas, oImg); 
		    hideDownloadText(); 
		   }
	      
	    };
	    
	    /////////////////////////////////////////////////////////
	    
	    var context;
	    
	 // Check for the canvas tag onload. 
	    if(window.addEventListener) { 
	    	window.addEventListener('load', function () {
	    		
	    		var canvas, canvaso, contexto; 
	    		 // Default tool. (chalk, line, rectangle) 
	    		   var tool; 
	    		   var tool_default = 'chalk'; 
	    		  
	    		function init () { 
	    		canvaso = document.getElementById('drawingCanvas');
	    		wrapper = document.getElementById('wrapper');
	    		   if (!canvaso) { 
	    		   //alert('Error! The canvas element was not found!'); 
	    		   return; 
	    		   } 
	    		 if (!canvaso.getContext) { 
	    		   alert('Error! No canvas.getContext!'); 
	    		   return; 
	    		   } 
	    		// Create 2d canvas. 
	    		   contexto = canvaso.getContext('2d'); 
	    		   if (!contexto) { 
	    		   alert('Error! Failed to getContext!'); 
	    		   return; 
	    		   } 
	    		 // Build the temporary canvas. 
	    		   var container = canvaso.parentNode; 
	    		   canvas = document.createElement('canvas'); 
	    		   if (!canvas) { 
	    		   alert('Error! Cannot create a new canvas element!'); 
	    		   return; 
	    		   } 
	    		 canvas.id     = 'tempCanvas';
	    		   canvas.width  = 0.9*wrapper.offsetWidth; 
	    		   canvas.height = 500;
	    		   canvaso.width  = 0.9*wrapper.offsetWidth; 
	    		   canvaso.height = 500;
	    		   container.appendChild(canvas); 
	    		context = canvas.getContext('2d'); 
	    		   context.strokeStyle = "#FFFFFF";// Default line color. 
	    		   context.lineWidth = 1.0;// Default stroke weight. 
	    		  
	    		   // Fill transparent canvas with dark grey (So we can use the color to erase). 
	    		   context.fillStyle = "#424242"; 
	    		   context.fillRect(0,0,canvas.width,canvas.height);//Top, Left, Width, Height of canvas.
	    		   
	    		// Create a select field with our tools. 
	    		   var tool_select = document.getElementById('selector'); 
	    		   if (!tool_select) { 
	    		   alert('Error! Failed to get the select element!'); 
	    		   return; 
	    		   } 
	    		   tool_select.addEventListener('change', ev_tool_change, false); 
	    		    
	    		   // Activate the default tool (chalk). 
	    		   if (tools[tool_default]) { 
	    		   tool = new tools[tool_default](); 
	    		   tool_select.value = tool_default; 
	    		   } 
	    		   // Event Listeners. 
	    		     canvas.addEventListener('mousedown', ev_canvas, false); 
	    		     canvas.addEventListener('mousemove', ev_canvas, false); 
	    		     canvas.addEventListener('mouseup',   ev_canvas, false); 
	    		     } 
	    		  // Get the mouse position. 
	    		     function ev_canvas (ev) { 
	    		     if (ev.layerX || ev.layerX == 0) { // Firefox 
	    		     ev._x = ev.layerX; 
	    		     ev._y = ev.layerY; 
	    		     } else if (ev.offsetX || ev.offsetX == 0) { // Opera 
	    		     ev._x = ev.offsetX; 
	    		     ev._y = ev.offsetY; 
	    		     } 
	    		  // Get the tool's event handler. 
	    		     var func = tool[ev.type]; 
	    		     if (func) { 
	    		     func(ev); 
	    		     } 
	    		     } 
	    		     function ev_tool_change (ev) { 
	    		     if (tools[this.value]) { 
	    		     tool = new tools[this.value](); 
	    		     } 
	    		     } 
	    		  // Create the temporary canvas on top of the canvas, which is cleared each time the user draws. 
	    		     function img_update () { 
	    		     contexto.drawImage(canvas, 0, 0); 
	    		     context.clearRect(0, 0, canvas.width, canvas.height); 
	    		     } 
	    		     var tools = {}; 
	    		   // Chalk tool. 
	    		     tools.chalk = function () { 
	    		     var tool = this; 
	    		     this.started = false; 
	    		   // Begin drawing with the chalk tool. 
	    		     this.mousedown = function (ev) { 
	    		     context.beginPath(); 
	    		     context.moveTo(ev._x, ev._y); 
	    		     tool.started = true; 
	    		     }; 
	    		     this.mousemove = function (ev) { 
	    		     if (tool.started) { 
	    		     context.lineTo(ev._x, ev._y); 
	    		     context.stroke(); 
	    		     } 
	    		     }; 
	    		     this.mouseup = function (ev) { 
	    		     if (tool.started) { 
	    		     tool.mousemove(ev); 
	    		     tool.started = false; 
	    		     img_update(); 
	    		     } 
	    		     }; 
	    		     };
	    		     
	    		  // The rectangle tool. 
	    		     tools.rect = function () { 
	    		     var tool = this; 
	    		     this.started = false; 
	    		     this.mousedown = function (ev) { 
	    		     tool.started = true; 
	    		     tool.x0 = ev._x; 
	    		     tool.y0 = ev._y; 
	    		     }; 
	    		     this.mousemove = function (ev) { 
	    		     if (!tool.started) { 
	    		     return; 
	    		     } 
	    		     // This creates a rectangle on the canvas. 
	    		     var x = Math.min(ev._x,  tool.x0), 
	    		     y = Math.min(ev._y,  tool.y0), 
	    		     w = Math.abs(ev._x - tool.x0), 
	    		     h = Math.abs(ev._y - tool.y0); 
	    		     context.clearRect(0, 0, canvas.width, canvas.height);// Clears the rectangle onload. 
	    		      
	    		    if (!w || !h) { 
	    		       return; 
	    		       } 
	    		       context.strokeRect(x, y, w, h); 
	    		       }; 
	    		       // Now when you select the rectangle tool, you can draw rectangles. 
	    		       this.mouseup = function (ev) { 
	    		       if (tool.started) { 
	    		       tool.mousemove(ev); 
	    		       tool.started = false; 
	    		       img_update(); 
	    		    } 
	    		    }; 
	    		    };
	    		    
	    		    init();
	    		
	    	}, false); }

	    