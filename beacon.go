package main

import (
	"fmt"
	"net/http"

	"google.golang.org/appengine"
)

func main() {
	http.HandleFunc("/", emitBeacon)
	appengine.Main()
}

func emitBeacon(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "This isn't a beacon!!")
}
