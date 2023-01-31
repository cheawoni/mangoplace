function getParamMap() { 
	let splited = location.search.replace("?","").split(/[=?&]/);	
	let param = {};
	for(let i=0; i<splited.length; i++) {
		param[splited[i]] = splited[++i];
	}
	return param;
}