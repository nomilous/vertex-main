module.exports = (config) -> 

    console.log config: config

    handle = (opts, callback) -> 

        console.log opts: opts
        callback null, main: 1


    handle.$www = {}

    return handle
