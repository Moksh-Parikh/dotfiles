local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s({trig="typed", snippetType="snippet", desc="C structure"}, {
		t("typedef struct "),
		t({"{", "\t"}),
		i(1),
		t({"", "} "}),
		i(2),
		t(";"),
	  }
    ),
	s({trig="func", snippetType="snippet", desc="C function"}, {
		i(1),
		t("("),
		i(2),
		t({") {", "\t"}),
		i(3),
		t({"", "}"}),
	  }
    ),
}