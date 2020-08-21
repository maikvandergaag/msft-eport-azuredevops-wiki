function Image(el)
	return pandoc.Image(el.title, string.gsub(el.src, "^/.", ""), "asd")
end