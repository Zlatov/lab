function is_version(version) {
  if (Object.prototype.toString.call(version) !== '[object String]') {
    return false
  }
  if (!/^[0-9]+\.[0-9]+\.[0-9]+$/gi.test(version)) {
    return false
  }
  return true
}

function is_version_up(new_version, old_version) {
  nv = new_version.split('.')
  ov = old_version.split('.')
  for(var i=0, l=nv.length; i<l; i++) {
    var inv = parseInt(nv[i])
    var iov = parseInt(ov[i])
    if (inv>iov) {
      return true
    }
  }
  return false
}


version = '1.1.00002'
version_server = '1.1.2'

if (is_version(version)&&is_version(version_server)) {
  console.log(is_version_up(version_server, version))
}
