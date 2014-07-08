# *************** Generate the tree diagram ***************
margin = {top: 20, right: 120, bottom: 20, left: 120}
width = 960 - margin.right - margin.left
height = 500 - margin.top - margin.bottom

i = 0

tree = d3.layout.tree()
.size([height, width])

diagonal = d3.svg.diagonal()
.projection(-> [d.y, d.x] )


svg = d3.select("body").append("svg")
.attr("width", width + margin.right + margin.left)
.attr("height", height + margin.top + margin.bottom)
.append("g")
.attr("transform", "translate(" + margin.left + "," + margin.top + ")")

root = window.treeData[0]

console.log(window.treeData + "hey")