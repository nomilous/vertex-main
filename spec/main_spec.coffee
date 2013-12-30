{ipso, original} = require 'ipso'

describe 'Main', -> 

    it 'exports default viewport entrypoint', 

        ipso (Main) -> 

            instance = Main 'path/to/client'

            instance rest: [], (err, res) -> 

                res.headers.should.eql 'Content-Type': 'text/html'
                res.body.should.match /<script src='build\/build.js'><\/script>/
                res.body.should.match /<script src='main\/js'><\/script>/

            instance rest: ['js'], (err, res) -> 

                res.headers.should.eql 'Content-Type': 'text/javascript'
                res.body.should.match /client not found/


                    

