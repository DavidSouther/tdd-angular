function trimLeadingTabs(){
	var trimTabs = function(el){
		el.innerHTML = el.innerHTML.replace(/\t+</g, '<');
	};
	var pres = document.getElementsByTagName("pre");
	[].forEach.call(pres, trimTabs);
}

window.onload = function(){
	trimLeadingTabs();
}