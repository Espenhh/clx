clx
===

clx is a minimal tool for analyzing and debugging classloading problems.

How to use
----------

clx takes the form of a single .jsp file which can be dropped into an exploded war directory of a misbehaving application.

Simply

1. Copy clx.jsp to the exploded war dir for your application (depends on your app server).
2. Point your browser at http://server/contextroot/clx.jsp