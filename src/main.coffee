fs = require 'fs'

module.exports = (config) -> 


    if 'string' is typeof config

        path = config



    handle = ({rest}, callback) -> 

        try 

            if uuid = rest[0]

                client = require path

                return callback null, 

                    headers: 'Content-Type': 'text/javascript'
                    body: """

                    (
                    #{client.toString()}
                    )('#{uuid}');

                    """


        catch error

            return callback null, statusCode: 404


        return callback null,

            #
            # TODO
            # ----
            # 
            # * configurable inclusion of build script (not always in that localtion?)
            #

            headers: 'Content-Type': 'text/html'
            body: """

            <head></head>
            <body>

                <script src='resources/build.js'></script>
                <script src='main/UUID'></script>

            </body>

            """



    handle.$www = {}

    return handle
