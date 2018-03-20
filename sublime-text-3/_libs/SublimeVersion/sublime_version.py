import sublime, pprint, sublime_plugin

class SublimeVersionCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		# self.view.insert(edit, 0, "Hello, World!")
		# print 'asd'
		pprint.pprint(sublime.version().decode("utf-8").rstrip('\n'))
