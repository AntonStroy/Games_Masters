<<<<<<< HEAD
const { environment } = require('@rails/webpacker')

module.exports = environment
=======
const { environment } = require('@rails/webpacker')
const jquery = require('./plugins/jquery')

environment.plugins.prepend('jquery', jquery)
module.exports = environment
>>>>>>> active_admin
