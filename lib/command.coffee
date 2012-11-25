{Mozfee} = require './mozfee'
argv     = require('optimist')
    .boolean(['help', 'mozrepl-greeting', 'color'])
    .default('color', true)
    .default('mozrepl-greeting', false)
    .argv

usage = """
mozfee [OPTIONS]

OPTIONS:
  --host <host>            Host (default: localhost)
  --port <port>            Port (default: 4242)
  --[no-]mozrepl-greeting  Shows greeting from Mozrepl (defualt: false).
  --[no-]color             Colorize the output (default: true).
  --help                   Show this message.
"""

run = ->
    if argv.help
        console.log usage
        return
    stdin  = process.stdin
    stdout = process.stdout
    mozfee = new Mozfee stdin, stdout, {
        'mozrepl-greeting': argv['mozrepl-greeting']
        color: argv.color
        host: argv.host
        port: argv.port
    }
    mozfee.run()

# Log an error.
process.on 'uncaughtException', (err)->
    console.error (err.stack or err.toString())

exports.run = run
