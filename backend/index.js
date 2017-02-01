const bunyan = require("bunyan")
const express = require("express")
const http = require("http")
const uuid = require("uuid")
const Either = require("data.either")
const { config, name } = require("package.json")

const app = express()
const log = bunyan.createLogger({
    "level": config.logger.level,
    "name": name
})
const plans = {
    "DK": [
        { "delay": 3, "number": 1 },
        { "delay": 0, "number": 6 },
        { "delay": 0, "number": 18 }
    ],

    "NL": [
        { "delay": 3, "number": 1 },
        { "delay": 6, "number": 1 }
    ],

    "NO": [
        { "delay": 0, "number": 3 },
        { "delay": 0, "number": 6 },
        { "delay": 3, "number": 3 }
    ]
}

app.use(require("body-parser").json())
app.use("/cdn", express.static("public"))
app.use("/dist", express.static("dist"))
app.post("/transaction", (req, res) => {
    res.json(Object.assign(req.body, {
        "id": uuid()
    }))
})
app.get("/:country/payment_plans", (req, res) => {
    Either
        .fromNullable(plans[req.params.country])
        .map((plan) => {
            return { "code": 200, "json": plan }
        })
        .orElse(() => {
            return Either.Right({
                "code": 404,
                "json": {
                    "error": "unknown country: plans are known only for DK, NL & NO"
                }
            })
        })
        .map(({ code, json }) => res.status(code).json(json))
})
app.use((err, req, res, next) => {
    log.error({ err }, "unexpected error")
    res.status(500).json({
        "error": "oops."
    })
})

http.createServer(app).listen(config.server.port, (err) => {
    if (err != null) {
        log.error({ err }, "unable to start the server")
        process.exit(1)
    }

    log.info(`connected on localhost:${config.server.port}`)
})
