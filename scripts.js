function trimLeadingTabs(){
	var trimTabs = function(el){
		el.innerHTML = el.innerHTML.replace(/\t+</g, '<');
	};
	var pres = document.getElementsByTagName("pre");
	[].forEach.call(pres, trimTabs);
}

function accordinate(){
	var css = "minify";
	var h3s = document.getElementsByTagName("h3");

	var toggle = function(event){
		classes = event.target.parentNode.classList;
		var fn = classes.contains(css) ? "remove" : "add"
		classes[fn](css);
	}

	var bind = function(el){
		el.onclick = toggle;
	};

	[].forEach.call(h3s, bind);
}

window.onload = function(){
	trimLeadingTabs();
	accordinate();
};
