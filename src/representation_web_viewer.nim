# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import jester, json, osproc

routes:
  get "/":
    redirect uri "index.html"

  post "/normalize":
    writeFile("./public/code.nim", parseJson(request.body)["code"].getStr)
    let (output, errC) = execCmdEx("nim c -f --hints:off src/representer")
    echo output
    resp(
      Http200, 
      "{\"exitCode\":" & $errc & ",\"output\":" & output & "}",
      contentType = "application/json"
    )
