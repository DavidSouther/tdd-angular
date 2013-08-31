window.onload = function(){
	[].forEach.call(document.getElementsByTagName("pre"), function(el){el.innerHTML = el.innerHTML.replace(/\t+</g, '<');});
}