function searcher(file)
	path = "./?.lua;./?.so;/usr/lib/lua5.2/?.so;/usr/share/lua5.2/?.lua"
	module_path = package.searchpath(file, path)
	module = loadfile(module_path)
	if module then return module end
	module = package.loadlib(module_path)
	if module then return module end
	return nil
end

package.searchers[1] = searcher
package.searchers[2] = nil
package.searchers[3] = nil
package.searchers[4] = nil

m = require "complex1"
c1 = m.new(1, 2)
c2 = m.new(3, 4)
print(m.tostring(m.add(c1, c2)))
