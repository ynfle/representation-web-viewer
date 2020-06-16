# Package

version       = "0.1.0"
author        = "Yoni Fihrer"
description   = "A server for viewing the normalized representation for Exercism.io v3"
license       = "MIT"
srcDir        = "src"
bin           = @["representation_web_viewer"]


# Dependencies

requires "nim >= 1.2.0", "jester >= 0.4.3"

