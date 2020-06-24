# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import jester, json, osproc, strutils

routes:
  get "/":
    redirect uri "index.html"

  post "/normalize":
    writeFile("./public/code.nim", parseJson(request.body)["code"].getStr)
    let (output, errCode) = execCmdEx("nim c -f -d:server --hints:off /Users/ynf/nim-representer/src/representer")
    echo "output: " & output
    resp(
      Http200,
      $(%*{
        "exitCode": errCode,
        "output": parseJson(output)
      }),
      contentType = "application/json"
    )
  
  post "/dumptree":
    let code = parseJson(request.body)["code"]
    let (output, errCode) = execCmdEx("echo 'import macros\ndumpTree:\n  " & code.getStr.replace("\n", "\n  ") & "' | nim c --hints:off -")
    resp(
      Http200,
      $(%*{
        "exitCode": errCode,
        "output": {
          "tree": '\n' & output.strip,
          "map": nil
        }
      }),
      contentType = "application/json"
    )
