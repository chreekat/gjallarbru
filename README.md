Gjallarbru is a tool for authoring web templates with quick feedback and
placeholders for external data.

As a proof of concept, I want to see a tool that tracks source files and reloads
them view in the browser.

To be test driven, I want to be able to make a test for that. Modifying a source
file is easy. How do I test that the view is updated? It needs to be a test in
the browser. Ok, cool. Already we're building a javascript app. So now we have
a client/server program that is a harness for the app. Sick.

I want a server that notices file changes and sends a json message.. somewhere.
Where? To a websocket endpoint. Can I mock one of those? So, I need to learn
about websockets.
