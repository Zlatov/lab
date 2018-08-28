import sublime
import sublime_plugin
import pprint

class ScopeToClipboardCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		sublime.set_clipboard(self.view.scope_name(self.view.sel()[0].b))
		pprint.pprint(self.view.scope_name(self.view.sel()[0].b))
