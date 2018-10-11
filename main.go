package main

import (
	"encoding/json"
	"net/http"
)

type RandomMessage struct {
	Description string
	DiceRoll    int
}

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
	m := RandomMessage{"This isn't a randomness beacon, but I will give you a fair dice roll.", 4}

	w.Header().Set("Content-Type", "application/json")

	json.NewEncoder(w).Encode(m)
}
