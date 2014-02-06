/*------------------- Live Search ------------------*/

function newLiveSearch(LS_containerID,LS_element,LS_prompt,LS_navLoc,LS_max,LS_showForm) {
	if (!LS_prompt) LS_prompt = 'Search';
	if (!LS_max) LS_max = 8;
	if (!LS_navLoc) LS_navLoc = 'top';
	//if (LS_showForm = '') LS_showForm = true;
	LS_container = $(LS_containerID);
	formHTML = '<form onsubmit="return false;" action="" class="LS-form">'+
      			'<input onkeyup="liveSearch(this,\''+LS_containerID+'\',\''+LS_element+'\',\''+LS_prompt+'\','+LS_max+');" class="LS-input">'+
    			'</form>';
	navHTML = '<p class="LS-pages-nav"><a style="display: none;" href="#" class="LS-previous-page"><span>Previous</span></a> '+ 
				'<span class="LS-current-page"></span> '+
				'<a style="display: none;" href="#" class="LS-next-page"><span>More</span></a></p>';
	errorMsg = '<p style="display: none;" class="LS-no-results error"></p>';
	
	if (LS_container.select('.youtube-nav') == '') {
		cHTML = LS_container.innerHTML;
		if (cHTML.indexOf('</h2>') != -1) {
			cHTMLArray = cHTML.split('</h2>', 2);
			LS_container.innerHTML = cHTMLArray[0]+'</h2>'+formHTML+errorMsg +navHTML+'<div class="animation-wrapper">'+cHTMLArray[1]+'</div>'+navHTML;
		}
		else {
			LS_container.innerHTML = formHTML+errorMsg+navHTML+'<div class="animation-wrapper">'+cHTML+'</div>'+navHTML;
		}
	}
	else {
		LS_container.select('.youtube-nav')[0].addClassName('animation-wrapper');
		LS_container.innerHTML = formHTML + errorMsg + navHTML + LS_container.innerHTML + navHTML;
	}
	//if (LS_navLoc == 'bottom') LS_container.innerHTML = formHTML + errorMsg + navHTML + LS_container.innerHTML + navHTML;
	//LS_container.innerHTML = formHTML + errorMsg + LS_container.innerHTML;
	searchInput = LS_container.select('.LS-input')[0];
	if (LS_showForm == false) {
		searchInput.hide();
		//if ($('past-dates')) Element.hide('past-dates');
	}
	searchInput.value = LS_prompt;
	searchInput.onfocus = function () { 
		if (this.value == LS_prompt) this.value = ''; 
		this.className = '';
		};
	searchInput.onblur = function () { 
		if (this.value == '') this.value = LS_prompt; 
		this.className = 'LS-input';
		};
	liveSearch(searchInput,LS_containerID,LS_element,LS_prompt,LS_max);
}
function liveSearch(searchInput,LS_containerID,LS_element,LS_prompt,LS_max) {
	LS_container = $(LS_containerID);
	allItems = LS_container.select(LS_element);
	searchStr = searchInput.value;
	if (searchStr == LS_prompt) searchStr = '';
	if (allItems.length <= LS_max) {
		searchInput.hide();
		//if ($('past-dates')) Element.hide('past-dates');
	}
	currentPage = 1;
	pageNumber = 1;	
	if (searchStr.length > 1 || searchStr == '') {
	
		liveSearchResults(LS_containerID,allItems,searchStr,LS_max,pageNumber,currentPage);	
	}
	return false;
}


function liveSearchResults(LS_containerID,allItems,searchStr,LS_max,pageNumber,currentPage,doAnimation) {
	var i = 0;
	if (doAnimation == null) doAnimation = false;
	LS_container = $(LS_containerID);
	previousPage = LS_container.select('.LS-previous-page');
	nextPage = LS_container.select('.LS-next-page');
	pageLocation = LS_container.select('.LS-current-page');
	noResults = LS_container.select('.LS-no-results')[0];
	pagesNav = LS_container.select('.LS-pages-nav');
	animationWrapper = LS_container.select('.animation-wrapper')[0];
	pagesNav[0].className = pagesNav[0].className + ' top';
	pagesNav[1].className = pagesNav[1].className + ' bottom';
	var itemGroups = new Array();
	for (z = 0; z < allItems.length; z++) {
		allItems[z].hide();
		itemDetails = allItems[z].innerHTML;
		itemDetails = itemDetails.replace(/<\/?[^>]+(>|$)/g, "");
		var searchExp = new RegExp(searchStr, "gi");
		if (searchExp.test(itemDetails)) {
			itemGroups[i] = allItems[z];
			itemGroups[i].show();
			i++;
		}
	}
	
	if (itemGroups.length == 0) {
		noResults.innerHTML = 'No results found &nbsp;<strong>:(</strong>';
		noResults.show();
		pagesNav.each(function(e){ e.hide(); });
	}
	else {
		noResults.innerHTML = '';
		noResults.hide();
		pagesNav.each(function(e){ e.show(); });
		for (z = 0; z < itemGroups.length; z++) {
			numberOfPages = itemGroups.length/LS_max;
			numberOfPages = Math.ceil(numberOfPages);
			if (numberOfPages == 0) numberOfPages = 1;
			if (numberOfPages == 1) { 
				pagesNav.each(function(e){ e.hide(); });
			}
			pageNumber = z/LS_max+1;
			pageNumber = Math.floor(pageNumber);
			//pageLocation.innerHTML = 'Page ' + currentPage + ' of ' + numberOfPages;
			if (pageNumber == currentPage) {
				itemGroups[z].show();
				if (z < (itemGroups.length - 1)) {
					nextPage.each(function(e){
						e.className = 'LS-next-page';
						e.show();
						e.onclick = function () {
							currentPage = currentPage + 1;
							liveSearchResults(LS_containerID,allItems,searchStr,LS_max,pageNumber,currentPage,true);
							return false;
						}
					});
				}
				else {
					nextPage.each(function(e){
						e.show();
						e.className = 'LS-next-page disabled';
						e.onclick = function () { return false; }
					});
				}
				if (currentPage != 1) {
					previousPage.each(function(e){
						e.show();
						e.className = 'LS-previous-page';
						e.onclick = function () {
							currentPage = currentPage - 1;
							liveSearchResults(LS_containerID,allItems,searchStr,LS_max,pageNumber,currentPage,true);
							return false;
						}
					});					
				}
				else {
					previousPage.each(function(e){
						e.show();
						e.className = 'LS-previous-page disabled';
						e.onclick = function () { return false; }
					});
				}
			}
			else itemGroups[z].hide();
			
		}
	}
	if (doAnimation) {
		LS_container.style.minHeight = LS_container.offsetHeight+'px';
		animationWrapper.hide();
		new Effect.Parallel([	  
		  new Effect.SlideDown(animationWrapper, { sync: true }),
		  new Effect.Appear(animationWrapper, { sync: true })
		], { 
		  duration: 0.3,
		  afterFinish: function () { LS_container.style.minHeight = ''; },
		  queue: { position: 'end', scope: 'livesearchscope' }
		});		
	}
	doAnimation = false;
}

function showRelevantContent(containerID,contentElements,keywords) {
	container = $(containerID);
	contents = container.select(contentElements);
	keywords = keywords.toLowerCase();
	keywords = keywords.replace(' ', '');
	keywords = keywords.split(',');
	contents.each(function(content){
		content.removeAttribute('_counted'); // for IE
		content.hide();
		contentHTML = content.innerHTML;
		contentHTML = contentHTML.replace(/<\/?[^>]+(>|$)/g, '');
		contentHTML = contentHTML.toLowerCase();
		for (i = 0; i < keywords.length; i++) {
			if (contentHTML.indexOf(keywords[i]) != -1) {
				content.show();
			}
		}
	});
	contents.each(function(content){
		if (content.style.display == 'none') content.remove();
	});
	//if (container.innerHTML.indexOf('<') == -1) container.up('.module').hide();
	//alert(contents.length);
	updatedContents = container.select(contentElements);
	updatedContents.each(function(e){ e.removeAttribute('_counted'); });
	if (updatedContents.length == 0) container.up('.module').hide();
}

var feedTimer;
function loadFeeds(containerID,numItems,tags,ajaxURL) {
	params = '';
	if (ajaxURL == null) ajaxURL = '/samplesite/includes/feeds.php';
	if (tags) {
		tags = tags.replace(/(\s)/g, '');
		tags = tags.replace(',', '-');
		params = '?tags='+tags;
	}
	//numItems = 20;
	//clearTimeout(feedTimer);
	$(containerID).innerHTML = '<p class="dimmed">Loading...</p>';
	new Ajax.Updater(containerID,ajaxURL+params,{
		onComplete:function(){ 
			newLiveSearch(containerID,'.feed-item','Search...','bottom',numItems,false);
			}
		});
	//feedTimer = setTimeout(function(){loadFeeds(containerID,numItems)},100000);
}
function basicAjaxLoader(containerID,ajaxUrl) {
	$(containerID).innerHTML = '<p class="dimmed">Loading...</p>';
	new Ajax.Updater(containerID,ajaxUrl);
}
function loadNewsFeed(pg) {
	feedContainer = $('campus-news');
	feedContainer.style.minHeight = feedContainer.offsetHeight+'px';
	if (pg == null) pg = 1;
	feedContainer.innerHTML = '<p class="loading"><img src="/img/loading.gif" alt="Loading..." /></p>';
	new Ajax.Updater(feedContainer,'/samplesite/includes/news.php?page='+pg,{			 
		onComplete:function(){ 
				new Effect.Parallel([	  
					  //new Effect.SlideDown('news-animation-wrapper', { sync: true }),
					  new Effect.Appear('news-animation-wrapper', { sync: true })
					], { 
					  duration: 0.2,
					  afterFinish: function () { feedContainer.style.minHeight = ''; },
					  queue: { position: 'end', scope: 'newsscope' }
					});
			}
		});
}


//var tweetTimer;
function loadTweets(containerID,numTweets,username) {
	//clearTimeout(tweetTimer);
	if (username == null) username = '';
	//numTweets = 20;
	$(containerID).innerHTML = '<p class="dimmed">Loading Tweets...</p>';
	new Ajax.Updater(containerID,'/includes/tweets.php?items=30&username='+username,{
		onComplete:function(){ 
			//newLiveSearch(containerID,'.feed-item','Search tweets...','bottom',numTweets,false);
			}
		});
	//tweetTimer = setTimeout(function(){loadTweets(containerID,numTweets,username)},100000);
}

function loadFeature(f) {
	//alert(feature);
	//param = f;
	$('features-wrapper').innerHTML = '<p class="loading"><img src="/img/loading.gif" alt="Loading..." /></p>';
	new Ajax.Updater('features-wrapper','/samplesite/includes/features.php?feature='+f,{
		onComplete:function(){ 
			fImg = $('features-wrapper').select('img');
			new Effect.Appear(fImg[0],{
				duration:0.3,
				queue: { position: 'end', scope: 'featurescope' }
				});
			}
		});
}

function lastModifiedDate() {
	if ($('last-modified')) $('last-modified').innerHTML = $('modified-date').innerHTML;
}

function hideEmptyContext() {
	if ($('context')) {
		if ($('context').innerHTML.indexOf('<') == -1) {
			$('context').hide();
		}
	}
	if ($('context-nav')) {
		if ($('context-nav').getElementsByTagName('li').length == 0) { $('context-nav').hide(); }
	}
}

function adjustColumnWidths() {
	columnContainers = $$('.columns-2');
	columnContainers.each(function(c){ 
		c.removeAttribute('_counted');
		columns = c.select('.column');
		columns[1].className = columns[1].className + ' adjusted';
	});
	columnContainers = $$('.columns-3');
	columnContainers.each(function(c){ 
		c.removeAttribute('_counted');
		columns = c.select('.column');
		columns[2].className = columns[2].className + ' adjusted';
	});
	columnContainers = $$('.columns-4');
	columnContainers.each(function(c){ 
		c.removeAttribute('_counted');
		columns = c.select('.column');
		columns[3].className = columns[3].className + ' adjusted';
	});
	
}

function buildTabs(headingTag,containerID,count) {
	container = $(containerID);
	navOrientation = '';	
	classAddition = '';
	j = 0;
	contents = new Array();
	headings = new Array();	
	if (container.className.indexOf('vertical') != -1) { 
		navOrientation = 'vertical';
		classAddition = '-vertical';
	}
	container.innerHTML = '<ul class="tabbed-nav'+classAddition+'"></ul>'+container.innerHTML;
	tabsList = container.select('ul')[0];
	tabsList.removeAttribute('_counted'); // for IE
	allContents = container.select('.tabbed-content');
	allContents.each(function(e){ e.removeAttribute('_counted'); }); // for IE
	// where nested tabbed groups exist, make sure we grab only the relevant content containers
	for (i = 0; i < allContents.length; i++) {
		if (allContents[i].up('.tabbed-group').id == containerID) {
			contents[j] = allContents[i];
			headings[j] = contents[j].select(headingTag)[0];
			j++;
		}
	}
	// hide all the content containers (except the first one) and create the tabs
	for (i = 0; i < contents.length; i++) {
		linkClass = '';
		contents[i].className = contents[i].className + classAddition;
		if (i != 0) contents[i].hide();
		else linkClass = 'active';
		/*if (navOrientation != 'vertical')*/ headings[i].hide();		
		headingHTML = headings[i].innerHTML;
		headingAnchor = headingHTML.replace(/(<\/?[^>]+(>|$))|(\s)|([^a-zA-Z 0-9]+)/g, ''); // strip out spaces, tags, weird characters, etc.
		//contents[i].innerHTML = '<a name="'+headingAnchor+'" id="'+headingAnchor+'"></a>' + contents[i].innerHTML;
		contentAnchor = new Element('a');
		contentAnchor.id = headingAnchor;
		Element.insert( contents[i], {'top':contentAnchor} );
		tab = '<li><a href="#'+headingAnchor+'" class="'+linkClass+'">'+headingHTML+'</a></li>';
		tabsList.innerHTML = tabsList.innerHTML + tab;		
	}
	// grab all the tab links and add onclick functions
	setTabActions(tabsList,contents);
	if (count != null) { 
		count++;
		getTabbedGroups(count);
	}
}

function setTabActions(tabsList,contents) {
	tabs = tabsList.select('a');
	tabs.each(function(e){ e.removeAttribute('_counted'); }); // for IE
	for (i = 0; i < tabs.length; i++) {
		tab = tabs[i];
		tab.i = i;
		tab.contents = contents;
		tab.tabs = tabs;
		tab.onclick = function() { displayTab(this.i,this.contents,this.tabs); return false; };
	}
	if (tabs.length == 1) {
		tabsList.hide();
		contents[0].style.border = 'none';
	}
}
// show selected content container and highlight the active tab
function displayTab(i,contents,tabs) {
	contents.each(function(e){ e.hide(); });
	contents[i].show();
	tabs.each(function(e){ e.className = ''; });
	tabs[i].className = 'active';
	tabs[i].blur();	
}

function getTabbedGroups(count) {
	if (count == null) count = 0;
	tabbedGroups = $$('.tabbed-group');
	tabbedGroups.each(function(e){ e.removeAttribute('_counted'); });
	if (count < tabbedGroups.length) {
		contentHTML = tabbedGroups[count].innerHTML;
		headingTag = contentHTML.split('>',2)[1];		
		headingTag = headingTag.split('<')[1];
		containerID = tabbedGroups[count].id;
		buildTabs(headingTag,containerID,count);
	}

}

function createDDMenus() {
	var count = 0;
	var ddSubMenus = new Array();
	ddMenus = $$('.drop-down-menu');
	for (i=0; i<ddMenus.length;i++) {
		ddSubMenus[count] = ddMenus[i].getElementsByTagName('ul')[0];
		count++;
	}
	
	//ddSubMenus = $$('.drop-down-menu ul');
	document.body.onclick = function() {
		ddMenus.each(function(e){ e.removeClassName('active'); });
		for (i=0; i<ddSubMenus.length;i++) {
			Element.hide(ddSubMenus[i]);
		}
	};
	ddMenus.each(function(dd){ 
		dd.removeAttribute('_counted'); 
		trigger = dd.getElementsByTagName('a')[0];
		trigger.subMenu = dd.getElementsByTagName('ul')[0];
		trigger.dd = dd;
		Event.observe(trigger, 'click', function(event) { 
			event.stop();
			for (i=0; i<ddSubMenus.length;i++) {
				if (this.dd.hasClassName('active') == false) {
					Element.hide(ddSubMenus[i]);
					ddMenus[i].removeClassName('active');
				}
			}			
			if (this.dd.hasClassName('active') == false) { 
				this.dd.addClassName('active');				 
			}
			else { this.dd.removeClassName('active'); }
			Effect.toggle(this.subMenu,'blind',{duration:0.05});	
		});
	});		
}


function buildBookmarks(strWhichTag, sBookMarkNode) {
	var i;	
	g_anchorCount = 1;	
	var container = document.getElementById('content');
	var aMarkElements = container.getElementsByTagName(strWhichTag);
	if (aMarkElements.length != '') {
		var oList = document.createElement("UL");
		oList.setAttribute("id","bookmarksList");		
		for (i=0; i<aMarkElements.length;i++) {
			if (aMarkElements[i].className != 'expander') {
				var sName = aMarkElements[i].innerHTML;				
				var oAnchor = buildNamedAnchor();
				aMarkElements[i].innerHTML = oAnchor + aMarkElements[i].innerHTML;	
				var oListItem = document.createElement("LI");
				var oLink = document.createElement("A");
				var sLinkDest = "#bookmark" + g_anchorCount;
				oLink.setAttribute("href", sLinkDest);
				oLink.onclick = function () { Element.hide('bookmarksList'); };			
				oListItem.appendChild(oLink);
				oLink.innerHTML = sName; 
				oList.appendChild(oListItem);
				g_anchorCount++;
			}
		}
		if (oList.innerHTML != '') insertBookmarkList(oList,sBookMarkNode);
	}
}

function buildNamedAnchor() {
	return "<a name='bookmark" + g_anchorCount + "' id='bookmark" + g_anchorCount + "'></a>";
}

// Inserts the bookmark list inside the given container tag 
// indicated by sBookmarkNode
function insertBookmarkList(oList, sBookMarkNode) {
	var oListHost = document.getElementById(sBookMarkNode);
	oList.style.display = 'none';
	oListHost.innerHTML = '<p><a href="#" onclick="Element.toggle(\'bookmarksList\'); return false;">Table of contents</a></p>';
	oListHost.appendChild(oList);
}

function checkSearchQuery() {
	if ($('q').value == 'People, places, web...') $('q').value = '';
}

Event.observe(window, 'load', function() {
	//addIcons();		
	hideEmptyContext();
	getTabbedGroups();
	createDDMenus();
	if (document.getElementById('bookmarks')) {
		buildBookmarks('H2','bookmarks');
	}
});

