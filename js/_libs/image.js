window.lib.image = {
  determine_mime_type_by_path: function(path) {
    if (!/(?:\.jpg|\.jpeg|\.png|\.gif)$/i.test(path)) {
      return null
    }
    switch(true) {
      case /(?:\.png)$/i.test(path):
        return 'image/png'
        break
      case /(?:\.jpg|\.jpeg)$/i.test(path):
        return 'image/jpg'
        break
      case /(?:\.gif)$/i.test(path):
        return 'image/gif'
        break
      default:
        return null
        break
    }
    return null
  }
}
