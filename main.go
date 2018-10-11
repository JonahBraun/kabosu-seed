package main

import (
	"fmt"
	"net/http"
)

func main() {
	server := http.NewServeMux()
	server.HandleFunc("/", emitBeacon)

	// Because we are only ever intending to run within a container, port is
	// hardcoded to 80. This can be remapped to anything by the container.
	err := http.ListenAndServe(":80", server)
	if err != nil {
		panic(err)
	}
}

func emitBeacon(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "This isn't a randomness beacon yet, but I will give you a fair dice roll: 4")
}
