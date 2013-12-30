fs = require 'fs'

module.exports = (config) -> 

    if 'string' is typeof config

        #
        # more config later
        #

        path = config





    #
    # create web response handle
    # --------------------------
    # 
    # * this can be grafted at any (*/**) point on a vertex `routes tree`
    # 

    handle = ({rest}, callback) -> 

        try 

            if rest[0] is 'js'

                arg1   = (try rest[1]) || ''
                arg2   = (try rest[2]) || ''
                arg3   = (try rest[3]) || ''

                client = (try require path) || -> 

                    #
                    # no node_module present at the specified path
                    # --------------------------------------------
                    # 
                    # * this alert occurs in browser
                    # * a more appropriate error mechanism will be needed
                    # 

                    alert 'client not found!'


                return callback null, 

                    #
                    # send client js
                    # --------------
                    # 
                    # * the resulting script on the client side is the stringification of the 
                    #   exported function of the node_module enclosed in a call to itself.
                    # 
                    # * the call is made with args from the `rest` of the query path
                    # 
                    #           http://*/**/main/js/arg1/agr2/arg3
                    #         
                    #           * input via */**/main is not yet enabled
                    #           * **may remove args injector**
                    #           * am experimenting (thinking: mobile app embedded browser)
                    # 

                    headers: 'Content-Type': 'text/javascript'
                    body: """

                    (
                    #{client.toString()}
                    )('#{arg1}','#{arg2}','#{arg3}');

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

                <script src='build/build.js'></script>
                <script src='main/js'></script>

            </body>

            """

    #
    # activate export
    #

    handle.$www = {}
    return handle
