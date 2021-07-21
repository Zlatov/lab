url_for controller: 'tasks', action: 'testing', host: 'somehost.org', port: '8080'
# => 'http://somehost.org:8080/tasks/testing'
url_for controller: 'tasks', action: 'testing', host: 'somehost.org', anchor: 'ok', only_path: true
# => '/tasks/testing#ok'
url_for controller: 'tasks', action: 'testing', trailing_slash: true
# => 'http://somehost.org/tasks/testing/'
url_for controller: 'tasks', action: 'testing', host: 'somehost.org', number: '33'
# => 'http://somehost.org/tasks/testing?number=33'
url_for controller: 'tasks', action: 'testing', host: 'somehost.org', script_name: "/myapp"
# => 'http://somehost.org/myapp/tasks/testing'
url_for controller: 'tasks', action: 'testing', host: 'somehost.org', script_name: "/myapp", only_path: true
# => '/myapp/tasks/testing'
