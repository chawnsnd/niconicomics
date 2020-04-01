/**
 * 
 */

//핸들바 바인드 쉽게 하기

function bindTemplate(templateDom, data){
	var source = $(templateDom).html(); 
	var template = Handlebars.compile(source); 
	var html = template(data);
	$(templateDom).after(html);
	$(templateDom).remove();
}

function bindTemplates(templateDom, datas){
	var source = $(templateDom).html(); 
	var template = Handlebars.compile(source); 
	$.each(datas, function(index, data){
		var html = template(data);
		$(templateDom).after(html);		
	})
	$(templateDom).remove();
}