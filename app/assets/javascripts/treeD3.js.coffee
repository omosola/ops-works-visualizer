$.ajax("/stacks").done(->
	generateTree()
)

generateTree = ->
	# *************** Generate the tree diagram ***************
	margin = {top: 20, right: 120, bottom: 20, left: 120}
	width = 960 - margin.right - margin.left
	height = 500 - margin.top - margin.bottom

	i = 0

	window.tree = d3.layout.tree()
	.size([height, width])

	window.diagonal = d3.svg.diagonal()
	.projection(-> [d.y, d.x] )


	window.svg = d3.select("body").append("svg")
	.attr("width", width + margin.right + margin.left)
	.attr("height", height + margin.top + margin.bottom)
	.append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top + ")")

	window.root = window.treeData[0]

	update(window.root)

update = (source) ->
	# Compute the new tree layout
	nodes = window.tree.nodes(source).reverse()
	links = window.tree.links(nodes)

	# normalize for fixed-depth
	nodes.forEach((d) -> d.y = d.depth * 180)

	# declare the nodes
	node = window.svg.selectAll("g.node").data(nodes,
		(d) -> d.id || (d.id = ++i) )

	# enter the nodes
	nodeEnter = node.enter().append("g")
		.attr("class", "node")
		.attr("transform", (d) -> "translate(" + d.y + "," + d.x + ")")

	nodeEnter.append("circle")
		.attr("r", 10)
		.style("fill", "#fff")

	nodeEnter.append("text")
		.attr("x", (d) ->
			if d.layers || d._layers
				-13
			else
				13)
		.attr("dy", ".35em")
		.attr("text-anchor", (d) -> 
			d.layers || d.layers ? "end" : "start")
		.text((d) -> d.name)
		.style("fill-opacity", 1)

	# declare the links
	link = window.svg.selectAll("path.link")
		.data(links, (d) -> d.target.id)

	# enter the links
	link.enter().insert("path", "g")
		.attr("class", "link")
		.attr("d", window.diagonal)