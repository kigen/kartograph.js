###
    kartograph - a svg mapping library
    Copyright (C) 2011,2012  Gregor Aisch

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
###

class Bubble extends Symbol

    constructor: (opts) ->
        me = @
        super opts
        me.radius = opts.radius ? 4
        me.style = opts.style ? ''
        me.title = opts.title
        me.class = opts.class ? 'bubble'

    overlaps: (bubble) ->
        me = @
        # check bbox
        [x1,y1,r1] = [me.x, me.y, me.radius]
        [x2,y2,r2] = [bubble.x, bubble.y, bubble.radius]
        return false if x1 - r1 > x2 + r2 or x1 + r1 < x2 - r2 or y1 - r1 > y2 + r2 or y1 + r1 < y2 - r2
        dx = x1-x2
        dy = y1-y2
        if dx*dx+dy*dy > (r1+r2)*(r1+r2)
            return false
        true

    render: (layers) ->
        me = @
        me.path = me.layers.mapcanvas.circle me.x,me.y,me.radius
        me.update()
        me.map.applyStyles(me.path)
        me

    update: () ->
        me = @
        me.path.attr
            x: me.x
            y: me.y
            r: me.radius
        path = me.path
        path.node.setAttribute 'style', me.style
        path.node.setAttribute 'class', me.class
        if me.title?
            path.attr 'title',me.title
        me

    clear: () ->
        me = @
        me.path.remove()
        me

    nodes: () ->
        me = @
        [me.path.node]



Bubble.props = ['radius','style','class','title']
Bubble.layers = [] #{ id:'a', type: 'svg' }

kartograph.Bubble = Bubble

