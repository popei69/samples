function sendLoginAction() {
	try {
	    webkit.messageHandlers.loginAction.postMessage(
	    	document.getElementById("email").value + " " + document.getElementById("password").value
	    );
    } catch(err) {
        console.log('The native context does not exist yet');
    }
}

function mobileHeader() {
    document.querySelector('h1').innerHTML = "WKWebView Mobile";
}