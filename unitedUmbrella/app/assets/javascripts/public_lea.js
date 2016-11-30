function render_graph(lea_type) {
	var dataArray3 = lea_type;
	console.log(dataArray3);
	var stringArray3 = ["CS","SD","IU","OCCCTC","SJCI","COMCTC","STATE","SPJ"];
	var rainbow = d3.scaleSequential(d3.interpolateRainbow).domain([0,9]);
	var x = d3.scaleOrdinal().domain(stringArray3).range([0,500]);
	var xAxis = d3.axisBottom(x);
	var svg = d3.select("#graph1").append("svg").attr("height","3000").attr("width","500");

	svg.selectAll("rect")
		.data(dataArray3)
		.enter().append("rect")
		.attr("height", function(d,i){return d*30;})
		.attr("width", 50)
		.attr("fill",function(d,i) {return rainbow(i);})
		.attr("x", function(d,i){return 50+i*60;})
		.attr("y",function(d,i){return 3000-(d*30);});

	svg.append("g")
		.attr("class","x axis hidden")
		.attr("transform","translate(0,210)")
		.call(xAxis);
}
