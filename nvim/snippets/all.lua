local ls = require('luasnip')
local t = ls.text_node
local s = ls.snippet

return {
	s("trig2", t("loaded!!")),
	s("trig3", t("foo!!")),
	s("trig4", t("foo!!")),
	s("mytrig3", t("foo!!"))
}
